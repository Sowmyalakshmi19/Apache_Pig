
-- find pid, total purcahse, total sales, profit, profit%(2 dec place)

purchase = LOAD '/home/sowmya/Downloads/input files/purchase.txt' USING  PigStorage(',')  as (prodid:long,purchaseamount:double);
--dump purchase;
sales = LOAD '/home/sowmya/Downloads/input files/sales.txt' USING  PigStorage(',')  as (prodid:long,salesamount:double);
--dump sales;

cogrouped = cogroup purchase by $0, sales by $0;
--dump cogrouped;

cogroupedcount = foreach cogrouped generate group, SUM(purchase.purchaseamount) as totalpurchase, SUM(sales.salesamount) as totalsales ;
--dump cogroupedcount;

final =  foreach cogroupedcount generate  $0, $1, $2, ($2-$1) as profit, ROUND_TO( ((($2-$1)/$1)*100),2) as percent;
 dump final;

--ANS:
--(101,700.0,500.0,-200.0,-28.57)
--(102,900.0,700.0,-200.0,-22.22)
--(103,1100.0,1300.0,200.0,18.18)



