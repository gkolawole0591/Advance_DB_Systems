# Kasiro - An E-Commerce System — SQL queries

## 1. Show related customer_order, customer, order_line, product records (up to 20).

```sql
SELECT t0."order_id" AS "customer_order_order_id",
       t0."order_date" AS "customer_order_order_date",
       t3."customer_id" AS "customer_customer_id",
       t3."email" AS "customer_email",
       t1."line_id" AS "order_line_line_id",
       t1."quantity" AS "order_line_quantity",
       t2."product_id" AS "product_product_id",
       t2."sku" AS "product_sku"
FROM portfolio."customer_order" t0
JOIN portfolio."order_line" t1 ON t1."order_id" = t0."order_id"
JOIN portfolio."product" t2 ON t1."product_id" = t2."product_id"
JOIN portfolio."customer" t3 ON t0."customer_id" = t3."customer_id"
ORDER BY t0."order_id", t3."customer_id", t1."line_id", t2."product_id"
LIMIT 20;
```

| customer_order_order_id | customer_order_order_date | customer_customer_id | customer_email | order_line_line_id | order_line_quantity | product_product_id | product_sku |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | 2026-02-14 | 1001 | maya@example.test | 4001 | 2 | 2001 | KAS-001 |

## 2. Find customer_order records where order_date matches "2026-02-14" (up to 20).

```sql
SELECT * FROM portfolio."customer_order"
WHERE "order_date" IS NOT DISTINCT FROM '2026-02-14'
ORDER BY "order_id"
LIMIT 20;
```

| order_id | customer_id | order_date | status |
| --- | --- | --- | --- |
| 3001 | 1001 | 2026-02-14 | placed |

## 3. Count customer_order records for each customer_id (up to 20 groups).

```sql
SELECT "customer_id", count(*) AS record_count
FROM portfolio."customer_order"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;
```

| customer_id | record_count |
| --- | --- |
| 1001 | 1 |

## 4. Find customer_order records where order_date matches "2026-02-14" (up to 20).

```sql
SELECT * FROM portfolio."customer_order"
WHERE "order_date" IS NOT DISTINCT FROM '2026-02-14'
ORDER BY "order_id"
LIMIT 20;
```

| order_id | customer_id | order_date | status |
| --- | --- | --- | --- |
| 3001 | 1001 | 2026-02-14 | placed |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 2.298 | 2.228, 4.97, 2.298 | Sort → Seq Scan | 274 |
| After index | 0.312 | 0.312, 0.266, 0.374 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 2.298 ms to 0.312 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=2.2..2.203 rows=50 loops=1)
  Seq Scan on customer_order (actual time=0.02..2.137 rows=50 loops=1)
Planning Time: 0.314 ms
Execution Time: 2.228 ms
```

### Before index, run 2

```text
Sort (actual time=4.93..4.935 rows=50 loops=1)
  Seq Scan on customer_order (actual time=0.022..4.872 rows=50 loops=1)
Planning Time: 0.457 ms
Execution Time: 4.97 ms
```

### Before index, run 3

```text
Sort (actual time=2.27..2.273 rows=50 loops=1)
  Seq Scan on customer_order (actual time=0.014..2.227 rows=50 loops=1)
Planning Time: 0.365 ms
Execution Time: 2.298 ms
```

### After index, run 1

```text
Sort (actual time=0.265..0.267 rows=50 loops=1)
  Bitmap Heap Scan on customer_order (actual time=0.029..0.227 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=50 loops=1)
Planning Time: 0.52 ms
Execution Time: 0.312 ms
```

### After index, run 2

```text
Sort (actual time=0.221..0.224 rows=50 loops=1)
  Bitmap Heap Scan on customer_order (actual time=0.029..0.184 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=50 loops=1)
Planning Time: 0.548 ms
Execution Time: 0.266 ms
```

### After index, run 3

```text
Sort (actual time=0.306..0.31 rows=50 loops=1)
  Bitmap Heap Scan on customer_order (actual time=0.039..0.251 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.017..0.018 rows=50 loops=1)
Planning Time: 1.317 ms
Execution Time: 0.374 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Kolawole_Gabriel_301930591_P2_Queries.sql, then Kolawole_Gabriel_301930591_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Kolawole_Gabriel_301930591_P2_QueryResults.png) · [Index comparison](screenshots/Kolawole_Gabriel_301930591_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

