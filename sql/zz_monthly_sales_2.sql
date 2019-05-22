USE [sirius9]
GO

/****** Object:  View [dbo].[zz_sh_monthly_sales_2]    Script Date: 22/05/2019 3:38:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[zz_sh_monthly_sales_2] as

with basequery as (

select supplier_code,
 product_code,
 sum(sales_qty) as sales_qty,
 datediff(month, invoice_date, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) as [age]
 
  from sh_select_trans_view
  where supplier_code is not null and
  supplier_code != '"' 
  and supplier_code != 'ZZ-PROFILE'
  and supplier_code != 'ZUNK'
  and invoice_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-6, 0) -- rolling 13 month
  group by supplier_code,product_code,datediff(month, invoice_date, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0))
  
 ) 
 select 
 supplier_code,[product_code],[0],[1],[2],[3],[4],[5]
 from basequery
 pivot
  (
  sum(sales_qty)
   for [age] in ([0],[1],[2],[3],[4],[5])
   ) as pvt
    where
  not ([0] is  null and
  [1] is  null and
  [2] is  null and
  [3] is  null and
  [4] is  null and
  [5] is  null )
  
 
GO
