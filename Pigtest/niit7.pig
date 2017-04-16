-- catogory count
--composit grouping

txn = LOAD '/home/hduser/txns1.txt' USING  PigStorage(',')  as (txnid,date,custid,amount:double, category, product, city, sate, type);
 txnbygroup = group txn by (category, product);
--dump  txnbygroup;

countbygroup = foreach txnbygroup generate group, COUNT(txn);
--dump countbygroup;
 sumbygroup = foreach txnbygroup generate group, ROUND_TO(COUNT(txn.amount),2);
dump sumbygroup;
