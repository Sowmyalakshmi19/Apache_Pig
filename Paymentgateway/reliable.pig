
user_data = load '/home/hduser/Downloads/weblog' using PigStorage() as (name:chararray, bank:chararray, logtime:float);
gateway = load '/home/hduser/Downloads/gateway' using PigStorage() as (bank:chararray, success_rate:float);

dump user_data;

dump gateway;

joined= join user_data by $1, gateway by $0;

dump joined;
 
data1 = foreach joined generate $0,$1,$4;

dump data1;

group1= group data1 by $0;
dump group1;

avg_user= foreach group1 generate group, AVG(data1.success_rate);
  
dump avg_user; 

final= filter avg_user by $1>90.00;
 
dump final;
 

