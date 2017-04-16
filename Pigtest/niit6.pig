
--join

emp = LOAD '/home/hduser/emp.txt' USING  PigStorage(',')  as (name:chararray, salary:chararray, city:chararray);
--dump emp;


email = LOAD '/home/hduser/email.txt' USING  PigStorage(',')  as (name:chararray, email:chararray);
--dump email;

-- inner join

innerjoined = join emp by $0, email by $0;
--dump innerjoined;

--ANS:
--(tarun,300000,Pondi,tarun,tarun@edureka.in)
--(swetha,250000,Chennai,swetha,swetha@gmail.com)


leftouterjoined = join emp by $0 LEFT, email by $0;
--dump leftouterjoined;

--ANS:
--(anita,250000,Selam,,)
--(tarun,300000,Pondi,tarun,tarun@edureka.in)
--(swetha,250000,Chennai,swetha,swetha@gmail.com)
--(anamika,200000,Kanyakumari,,)


rightouterjoined = join emp by $0 RIGHT, email by $0;
dump rightouterjoined;

--ANS:
--(tarun,300000,Pondi,tarun,tarun@edureka.in)
--(,,,nagesh,nagesh@yahoo.com)
--(swetha,250000,Chennai,swetha,swetha@gmail.com)
--(,,,venkatesh,venki@gmail.com)

fullouterjoined = join emp by $0 FULL, email by $0;
dump fullouterjoined;

--ANS:
--(anita,250000,Selam,,)
--(tarun,300000,Pondi,tarun,tarun@edureka.in)
--(,,,nagesh,nagesh@yahoo.com)
--(swetha,250000,Chennai,swetha,swetha@gmail.com)
--(anamika,200000,Kanyakumari,,)
--(,,,venkatesh,venki@gmail.com)




