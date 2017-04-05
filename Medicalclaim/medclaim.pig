
medical_data =load '/home/hduser/Downloads/medical' using PigStorage() as (name:chararray, dept:chararray, claim:float);

dump medical_data;
 
groupbyname= group medical_data by name;
 
dump groupbyname;
 
avg_claim= foreach groupbyname generate group, ROUND_TO(AVG(medical_data.claim),2);
 
dump avg_claim; 

