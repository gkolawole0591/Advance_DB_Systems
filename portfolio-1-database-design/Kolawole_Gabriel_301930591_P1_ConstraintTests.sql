-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. customer duplicate pk. Expected: pk_customer, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "email", "display_name", "created_at")
VALUES (1001, 'duplicate-pk@example.test', 'Duplicate Customer', '2026-03-01T10:00:00Z');

-- 2. customer duplicate email. Expected: uq_customer_0, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "email", "display_name", "created_at")
VALUES (5002, 'maya@example.test', 'Another Maya', '2026-03-01T10:00:00Z');

-- 3. customer null id. Expected: customer_id, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "email", "display_name", "created_at")
VALUES (NULL, 'null-id@example.test', 'Null Id Customer', '2026-03-01T10:00:00Z');

-- 4. customer null email. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "email", "display_name", "created_at")
VALUES (5004, NULL, 'Null Email Customer', '2026-03-01T10:00:00Z');

-- 5. customer null display name. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "email", "display_name", "created_at")
VALUES (5005, 'null-name@example.test', NULL, '2026-03-01T10:00:00Z');

-- 6. customer null created at. Expected: created_at, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "email", "display_name", "created_at")
VALUES (5006, 'null-created@example.test', 'Null Created Customer', NULL);

-- 7. product duplicate pk. Expected: pk_product, SQLSTATE 23505.
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active")
VALUES (2001, 'KAS-TEST-PK', 'Duplicate Id Product', 18, TRUE);

-- 8. product duplicate sku. Expected: uq_product_0, SQLSTATE 23505.
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active")
VALUES (5008, 'KAS-001', 'Duplicate SKU Product', 18, TRUE);

-- 9. product null id. Expected: product_id, SQLSTATE 23502.
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active")
VALUES (NULL, 'KAS-TEST-NULL-ID', 'Null Id Product', 18, TRUE);

-- 10. product null sku. Expected: sku, SQLSTATE 23502.
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active")
VALUES (5010, NULL, 'Null SKU Product', 18, TRUE);

-- 11. product null name. Expected: name, SQLSTATE 23502.
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active")
VALUES (5011, 'KAS-TEST-NULL-NAME', NULL, 18, TRUE);

-- 12. product null price. Expected: unit_price, SQLSTATE 23502.
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active")
VALUES (5012, 'KAS-TEST-NULL-PRICE', 'Null Price Product', NULL, TRUE);

-- 13. product null active. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."product" ("product_id", "sku", "name", "unit_price", "active")
VALUES (5013, 'KAS-TEST-NULL-ACTIVE', 'Null Active Product', 18, NULL);

-- 14. order duplicate pk. Expected: pk_customer_order, SQLSTATE 23505.
INSERT INTO portfolio."customer_order" ("order_id", "customer_id", "order_date", "status")
VALUES (3001, 1001, '2026-03-01', 'placed');

-- 15. order missing customer. Expected: fk_customer_order_0, SQLSTATE 23503.
INSERT INTO portfolio."customer_order" ("order_id", "customer_id", "order_date", "status")
VALUES (5015, 999999, '2026-03-01', 'placed');

-- 16. order null id. Expected: order_id, SQLSTATE 23502.
INSERT INTO portfolio."customer_order" ("order_id", "customer_id", "order_date", "status")
VALUES (NULL, 1001, '2026-03-01', 'placed');

-- 17. order null customer. Expected: customer_id, SQLSTATE 23502.
INSERT INTO portfolio."customer_order" ("order_id", "customer_id", "order_date", "status")
VALUES (5017, NULL, '2026-03-01', 'placed');

-- 18. order null date. Expected: order_date, SQLSTATE 23502.
INSERT INTO portfolio."customer_order" ("order_id", "customer_id", "order_date", "status")
VALUES (5018, 1001, NULL, 'placed');

-- 19. order null status. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."customer_order" ("order_id", "customer_id", "order_date", "status")
VALUES (5019, 1001, '2026-03-01', NULL);

-- 20. line duplicate pk. Expected: pk_order_line, SQLSTATE 23505.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (4001, 3001, 2002, 1, 12);

-- 21. line duplicate order product. Expected: uq_order_line_0, SQLSTATE 23505.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5021, 3001, 2001, 1, 22.5);

-- 22. line missing order. Expected: fk_order_line_0, SQLSTATE 23503.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5022, 999998, 2001, 1, 22.5);

-- 23. line missing product. Expected: fk_order_line_1, SQLSTATE 23503.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5023, 3001, 999997, 1, 22.5);

-- 24. line null id. Expected: line_id, SQLSTATE 23502.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (NULL, 3001, 2002, 1, 12);

-- 25. line null order. Expected: order_id, SQLSTATE 23502.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5025, NULL, 2002, 1, 12);

-- 26. line null product. Expected: product_id, SQLSTATE 23502.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5026, 3001, NULL, 1, 12);

-- 27. line null quantity. Expected: quantity, SQLSTATE 23502.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5027, 3001, 2002, NULL, 12);

-- 28. line null price. Expected: unit_price, SQLSTATE 23502.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5028, 3001, 2002, 1, NULL);

-- 29. line nonpositive quantity. Expected: line_quantity_positive, SQLSTATE 23514.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5029, 3001, 2002, 0, 12);

-- 30. line nonpositive price. Expected: line_price_positive, SQLSTATE 23514.
INSERT INTO portfolio."order_line" ("line_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (5030, 3001, 2002, 1, 0);
