
book= load '/niit/file1.txt' using TextLoader() as (lines:chararray);

dump book;
 
transforms = foreach book generate FLATTEN(TOKENIZE (lines)) as word;

dump transforms;

groupbyword= group transforms by word;

dump groupbyword;

countword= foreach groupbyword generate group, COUNT(transforms);
 
dump countword;
 
store countword into '/niit/pig/wordcount' using PigStorage();
