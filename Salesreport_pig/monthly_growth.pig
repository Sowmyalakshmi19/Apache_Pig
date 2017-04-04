sales2000 =load '/home/hduser/Downloads/2000.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);

sales2001 =load '/home/hduser/Downloads/2001.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);

sales2002 =load '/home/hduser/Downloads/2002.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);
  
group2000= group sales2000 all;

monthly_sales2000= foreach group2000 generate SUM(sales2000.jan) as jantotal, SUM(sales2000.feb) as febtotal,SUM(sales2000.mar) as martotal,SUM(sales2000.april) as apriltotal,SUM(sales2000.may) as maytotal,SUM(sales2000.jun) as juntotal,SUM(sales2000.july) as julytotal,SUM(sales2000.aug) as augtotal,SUM(sales2000.sept) as septtotal,SUM(sales2000.oct) as octtotal,SUM(sales2000.nov) as novtotal,SUM(sales2000.dec) as dectotal;

group2001= group sales2001 all;

monthly_sales2001= foreach group2001 generate SUM(sales2001.jan) as jantotal, SUM(sales2001.feb) as febtotal,SUM(sales2001.mar) as martotal,SUM(sales2001.april) as apriltotal,SUM(sales2001.may) as maytotal,SUM(sales2001.jun) as juntotal,SUM(sales2001.july) as julytotal,SUM(sales2001.aug) as augtotal,SUM(sales2001.sept) as septtotal,SUM(sales2001.oct) as octtotal,SUM(sales2001.nov) as novtotal,SUM(sales2001.dec) as dectotal;

group2002= group sales2002 all;

monthly_sales2002= foreach group2002 generate SUM(sales2002.jan) as jantotal, SUM(sales2002.feb) as febtotal,SUM(sales2002.mar) as martotal,SUM(sales2002.april) as apriltotal,SUM(sales2002.may) as maytotal,SUM(sales2002.jun) as juntotal,SUM(sales2002.july) as julytotal,SUM(sales2002.aug) as augtotal,SUM(sales2002.sept) as septtotal,SUM(sales2002.oct) as octtotal,SUM(sales2002.nov) as novtotal,SUM(sales2002.dec) as dectotal;
 
--dump group2000;
 
--describe monthly_sales2000;
--dump monthly_sales2000;

ranked2000 = rank(foreach monthly_sales2000 generate FLATTEN(TOBAG(*)));
ranked2001 = rank(foreach monthly_sales2001 generate FLATTEN(TOBAG(*)));
ranked2002 = rank(foreach monthly_sales2002 generate FLATTEN(TOBAG(*)));
--dump ranked2000;
joined_bag= join ranked2000 by $0, ranked2001 by $0, ranked2002 by $0;
describe joined_bag;
--dump joined_bag;
monthly_compare= foreach joined_bag generate $0,$1,$3,$5,ROUND_TO((($3-$1)/$1*100),2), ROUND_TO((($5-$3)/$3*100),2);

--dump monthly_compare;
avg_growth= foreach monthly_compare generate $0,$1,$2,$3,$4,$5, ROUND_TO((($4+$5)/2),2);
dump avg_growth;
final= order avg_growth by $6 desc;
dump final;
