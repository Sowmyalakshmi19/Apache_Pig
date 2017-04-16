
owner = load '/home/sowmya/owners.csv' using PigStorage(',') as (owner:chararray, animal: chararray);
 
--dump owner;

pets = load '/home/sowmya/pets.csv' using PigStorage(',') as (owner:chararray, animal: chararray);

--dump pets;

cogrouped = cogroup owner by $1, pets by $1;

--dump cogrouped;

cogroupedcount= foreach cogrouped generate group, COUNT(owner), COUNT(pets);

dump cogroupedcount;
