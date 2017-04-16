book= load '/home/hduser/file1.txt' using TextLoader() as (lines:chararray);

REGISTER /home/hduser/pigudf.jar;

DEFINE LowerToUpper myudfs.upper();

book2= foreach book generate LowerToUpper(lines);

dump book2;
