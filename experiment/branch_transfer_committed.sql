so_order -> bt_request
so_order_line -> bt_request_line
so_shipment_line -> bt_xfer_out_line




SELECT
  l.ship_from_warehouse,
  l.product_code,
  SUM(l.ordered_qty) AS commited,
  SUM(CASE WHEN [s].[ship_line_status] = 'I' THEN [l].ordered_qty - [s].[shipped_qty] ELSE [l].[ordered_qty] - [l].[cancelled_qty] END) 
                         AS committed1
FROM            dbo.so_order AS o WITH (NOLOCK)
 INNER JOIN
                         dbo.so_order_line AS l WITH (NOLOCK)
 ON
          o.order_no = l.order_no 
LEFT OUTER JOIN
                         dbo.so_shipment_line AS s 
WITH (NOLOCK) ON l.order_no = s.order_no AND l.order_line_nr = s.order_line_nr
WHERE
  (o.order_status <> 'H') AND
  (l.completed_flag <> 'Y') AND
  (l.stock_alloc_flag = 'L')
GROUP BY l.ship_from_warehouse, l.product_code
