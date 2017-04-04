
book= load '/home/hduser/Downloads/book-data' USING PigStorage (',') as (book_id:int,price:int,author_id:int);
 
author = load '/home/hduser/Downloads/author-data' USING PigStorage (',') as (author_id:int,author_name:chararray);

--dump book;
--dump author; 

book_filter= filter book by price>=200;
 --dump book_filter;

author_filter= filter author by SUBSTRING(author_name,0,1)== 'J';

--dump author_filter; 

joined_data = join book_filter by $2, author_filter by $0;

dump joined_data;
