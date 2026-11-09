# Kasiro - An E-Commerce System — ER diagram

```mermaid
erDiagram
    direction LR
    customer {
        bigint customer_id PK
        text email UK
        text display_name
        timestamptz created_at
    }
    product {
        bigint product_id PK
        text sku UK
        text name
        numeric unit_price
        boolean active
    }
    customer_order {
        bigint order_id PK
        bigint customer_id FK
        date order_date
        text status
    }
    order_line {
        bigint line_id PK
        bigint order_id FK
        bigint product_id FK
        integer quantity
        numeric unit_price
    }
    customer ||--o{ customer_order : "customer_id"
    customer_order ||--o{ order_line : "order_id"
    product ||--o{ order_line : "product_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Kolawole_Gabriel_301930591_ERDiagram.png)
