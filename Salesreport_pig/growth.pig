year2000 =load '/home/sowmya/Downloads/2000.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);

year2001 =load '/home/sowmya/Downloads/2001.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);

 year2002 =load '/home/sowmya/Downloads/2002.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,july:double,aug:double,sept:double,oct:double,nov:double,dec:double);

sale2000 =foreach year2000 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as sale;

sale2001 =foreach year2001 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as sale;

sale2002 =foreach year2002 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as sale;

saledata = join sale2000 by cat_id,sale2001 by cat_id,sale2002 by cat_id;

yearwisesale = foreach saledata generate $0,$1,$2,$5,$8;

cycles = foreach yearwisesale generate $0,$1,ROUND_TO((($3-$2)*100/$2),2) as cycle1,ROUND_TO((($4-$3)*100/$3),2) as cycle2 ;

avggrowth = foreach cycles generate $0,$1, (($2+$3)/2) as avg_growth;

more10avg = filter avggrowth by $2>=10;

dump more10avg;

lessavg = filter avggrowth by $2 <0;

drop5avg = filter lessavg by $2 < -5;

dump drop5avg;

totalsale= foreach yearwisesale generate $0,$1,($2+$3+$4) as total;
describe totalsale;

descendingtotal = order totalsale by $2 desc;

top5 =limit descendingtotal 5;

dump top5;

ascendingtotal = order totalsale by $2 ;

bottom5 = limit ascendingtotal 5;

dump bottom5;
