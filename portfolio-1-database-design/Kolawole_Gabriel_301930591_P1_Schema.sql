-- Kasiro - An E-Commerce System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."customer" (
  "customer_id" bigint NOT NULL,
  "email" text NOT NULL,
  "display_name" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  CONSTRAINT "pk_customer" PRIMARY KEY ("customer_id"),
  CONSTRAINT "uq_customer_0" UNIQUE ("email")
);
CREATE TABLE portfolio."product" (
  "product_id" bigint NOT NULL,
  "sku" text NOT NULL,
  "name" text NOT NULL,
  "unit_price" numeric(18,2) NOT NULL,
  "active" boolean NOT NULL,
  CONSTRAINT "pk_product" PRIMARY KEY ("product_id"),
  CONSTRAINT "uq_product_0" UNIQUE ("sku")
);
CREATE TABLE portfolio."customer_order" (
  "order_id" bigint NOT NULL,
  "customer_id" bigint NOT NULL,
  "order_date" date NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_customer_order" PRIMARY KEY ("order_id")
);
CREATE TABLE portfolio."order_line" (
  "line_id" bigint NOT NULL,
  "order_id" bigint NOT NULL,
  "product_id" bigint NOT NULL,
  "quantity" bigint NOT NULL,
  "unit_price" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_order_line" PRIMARY KEY ("line_id"),
  CONSTRAINT "uq_order_line_0" UNIQUE ("order_id", "product_id")
);
ALTER TABLE portfolio."customer_order" ADD CONSTRAINT "fk_customer_order_0" FOREIGN KEY ("customer_id") REFERENCES portfolio."customer" ("customer_id");
ALTER TABLE portfolio."order_line" ADD CONSTRAINT "fk_order_line_0" FOREIGN KEY ("order_id") REFERENCES portfolio."customer_order" ("order_id");
ALTER TABLE portfolio."order_line" ADD CONSTRAINT "fk_order_line_1" FOREIGN KEY ("product_id") REFERENCES portfolio."product" ("product_id");
ALTER TABLE portfolio."order_line" ADD CONSTRAINT "line_quantity_positive" CHECK ("quantity" > 0);
ALTER TABLE portfolio."order_line" ADD CONSTRAINT "line_price_positive" CHECK ("unit_price" > 0);
COMMIT;
