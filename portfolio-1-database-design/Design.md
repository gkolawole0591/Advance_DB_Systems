# Kasiro - An E-Commerce System — database design

My case study records customer, product, customer_order, order_line.

## Users

- Customers browsing and purchasing products
- Store staff reviewing orders and sales

## Main operations

- Register customers and maintain a product catalog
- Create orders containing products and quantities
- Review orders and summarize product sales

## Entities

| Entity | Information stored |
| --- | --- |
| customer | A person with an account that can place orders. |
| product | A catalog item available for purchase. |
| customer_order | An order placed by one customer. |
| order_line | A product and quantity included in an order, with its purchase price. |

## customer

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| customer_id | BIGINT | PK | Yes |
| email | TEXT | Unique | Yes |
| display_name | TEXT |  | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- Unique key: (email).

## product

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| product_id | BIGINT | PK | Yes |
| sku | TEXT | Unique | Yes |
| name | TEXT |  | Yes |
| unit_price | NUMERIC(18,2) |  | Yes |
| active | BOOLEAN |  | Yes |
- Unique key: (sku).

## customer_order

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| order_id | BIGINT | PK | Yes |
| customer_id | BIGINT | FK | Yes |
| order_date | DATE |  | Yes |
| status | TEXT |  | Yes |
- customer_id → customer.customer_id

## order_line

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| line_id | BIGINT | PK | Yes |
| order_id | BIGINT | FK | Yes |
| product_id | BIGINT | FK | Yes |
| quantity | INTEGER |  | Yes |
| unit_price | NUMERIC(18,2) |  | Yes |
- order_id → customer_order.order_id
- product_id → product.product_id
- Unique key: (order_id, product_id).

## Relationships and business rules

- Each customer email identifies at most one customer.
- Each catalog SKU identifies at most one product.
- Every order must reference an existing customer.
- Every order line must reference an existing order.
- Every order line must reference an existing product.
- An order line quantity must be greater than zero.
- An order line purchase price must be greater than zero.
- An order can have at most one line for a given product.

## Assumptions

- All identifiers are synthetic UUIDs and are globally unique across entity tables.
- Each order belongs to one customer; each order line refers to one order and one product.
- Order-line unit_price records the purchase price and may differ from the product's current unit_price.
- An order cannot contain more than one line for the same product; quantities and prices must be positive.
- Student names and student identifiers are not part of this exercise.

