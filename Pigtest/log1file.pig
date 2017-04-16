-- log file

log1 = LOAD '/home/hduser/hadoop-hduser-datanode-ubuntu.log' USING PigStorage() as (lines:chararray);
--dump log1;
--describe log1;


split log1 into log2 if  SUBSTRING (lines, 24, 28) == 'INFO' , log3 if   SUBSTRING(lines, 24, 29) == 'ERROR', log4  if SUBSTRING(lines, 24, 28) == 'WARN' ;

groupoflog2 = group log2 all;
groupoflog3 = group log3 all;
groupoflog4 = group log4 all;

countoflog2 = foreach groupoflog2 generate COUNT(log2);
countoflog3 = foreach groupoflog3 generate COUNT(log3);
countoflog4 = foreach groupoflog4 generate COUNT(log4);

--dump countoflog2;

--dump countoflog3;
--dump countoflog4;

infogroup = group log2 by SUBSTRING(lines, 20, 23);
infocount = foreach infogroup generate group, COUNT(log2);
infoorder = order infocount by $1;
--dump infoorder;

errorgroup = group log3 by SUBSTRING(lines, 20, 23);
errorcount = foreach errorgroup generate group, COUNT(log3);
errororder = order errorcount by $1;
--dump errororder;

warngroup = group log4 by SUBSTRING(lines, 20, 23);
warncount = foreach warngroup generate group, COUNT(log4);
warnorder = order warncount by $1;
dump warnorder;
