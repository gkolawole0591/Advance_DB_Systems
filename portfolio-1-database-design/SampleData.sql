-- Fictional sample records for Kasiro - An E-Commerce System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customer" ("customer_id", "email", "display_name", "created_at") VALUES (1001, 'maya@example.test', 'Maya Ndlovu', '2026-01-10T09:30:00Z');
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active") VALUES (2001, 'KAS-001', 'Canvas Tote', 24.5, TRUE);
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active") VALUES (2002, 'KAS-002', 'Ceramic Mug', 12, TRUE);
INSERT INTO portfolio."customer_order" ("order_id", "customer_id", "order_date", "status") VALUES (3001, 1001, '2026-02-14', 'placed');
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price") VALUES (4001, 3001, 2001, 2, 22.5);
COMMIT;
