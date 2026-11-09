# Kasiro - An E-Commerce System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| order_id | order_line records (list) |
| --- | --- |
| 3001 | [4001] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| order_line.line_id | order_line.order_id | order_line.product_id | customer_order.order_id | customer_order.customer_id | customer_order.status | customer.customer_id | customer.email |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4001 | 3001 | 2001 | 3001 | 1001 | placed | 1001 | maya@example.test |

Key: line_id.

## 2NF: depend on the whole key

order_line: order_id is a proper part of candidate key (order_id, product_id), and determines customer_order details. order_line: product_id is a proper part of candidate key (order_id, product_id), and determines product details.

## customer_order_example

| customer_order.order_id | customer_order.customer_id | customer_order.status | customer.customer_id | customer.email |
| --- | --- | --- | --- | --- |
| 3001 | 1001 | placed | 1001 | maya@example.test |

## order_line_example

| order_line.line_id | order_line.order_id | order_line.product_id |
| --- | --- | --- |
| 4001 | 3001 | 2001 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## customer

| customer_id | email | display_name | created_at |
| --- | --- | --- | --- |
| 1001 | maya@example.test | Maya Ndlovu | 2026-01-10T09:30:00+00:00 |

## product

| product_id | sku | name | unit_price | active |
| --- | --- | --- | --- | --- |
| 2001 | KAS-001 | Canvas Tote | 24.5 | true |
| 2002 | KAS-002 | Ceramic Mug | 12 | true |

## customer_order

| order_id | customer_id | order_date | status |
| --- | --- | --- | --- |
| 3001 | 1001 | 2026-02-14 | placed |

## order_line

| line_id | order_id | product_id | quantity | unit_price |
| --- | --- | --- | --- | --- |
| 4001 | 3001 | 2001 | 2 | 22.5 |

## Dependencies

- customer: (customer_id) → email, display_name, created_at
- product: (product_id) → sku, name, unit_price, active
- customer_order: (order_id) → customer_id, order_date, status
- order_line: (line_id) → order_id, product_id, quantity, unit_price

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
