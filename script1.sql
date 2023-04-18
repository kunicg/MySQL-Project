SELECT * FROM project5.sharks;

-- total episodes
select count(distinct `sharks`.`Ep. No.`) as no_of_episodes from sharks;
-- or
select max(`sharks`.`Ep. No.`) as no_of_episodes from sharks;


-- pitches
select count(distinct brand) as no_of_pitches from sharks;
-- or
select count(*) from sharks;


-- pitches got funding
select count(`sharks`.`Amount Invested lakhs`) as funding_received from sharks
where `sharks`.`Amount Invested lakhs`>0;


-- percentage of people got funding
select cast(sum(x.converts)as float) / cast(count(*)as float) *100 as pct_got_funding
from(
select `sharks`.`Amount Invested lakhs`,
case when `sharks`.`Amount Invested lakhs`>0 then 1 else 0 end as converts from sharks) x;


-- total male
select sum(male) as total_male from sharks;


-- total female
select sum(female) as total_female from sharks;


-- gender ratio
select sum(male)/sum(female) as gender_ratio from sharks;


-- total amount invested(lakhs)
select sum(`sharks`.`Amount Invested lakhs`) as total_amount_invested_lakhs from sharks;


-- Average Equity taken %
select avg(`sharks`.`Equity Taken %`) as Average_Equity_taken_pct from sharks
where `sharks`.`Equity Taken %` > 0;


-- Highest deal taken
select max(`sharks`.`Amount Invested lakhs`) as highest_deal from sharks;


-- Highest Equity taken
select max(`sharks`.`Equity Taken %`) as highest_equity_taken from sharks;


-- pitches having atleast women
select count(`sharks`.`Female`) as pitches_having_atleast_1_women from sharks
where `sharks`.`Female`>0;


-- startup having atleast 1 women got deal
select count(`sharks`.`Female`) as having_atleast_1_women_got_deal from sharks
where `sharks`.`Female`> 0 and `sharks`.`Deal` != "No Deal";


-- avg. team member
select avg(`sharks`.`Team members`) as avg_team_member from sharks;


-- avg. amount invested per deal
select avg(`sharks`.`Amount Invested lakhs`) as avg_amt_invst_per_deal from sharks
where `sharks`.`Deal` != "no deal";


-- Debt taken
select sum(`sharks`.`Debt Invested`) as debt_taken from sharks;


-- total amount asked
select sum(`sharks`.`Amout Asked`) as total_amount_asked from sharks;


-- avg equity asked %
select avg(`sharks`.`Equity Asked %`) as avg_equity_asked_pct from sharks
where deal != "no deal";


-- avg age
select `sharks`.`Avg age`, count(`sharks`.`Avg age`) as no_of_people from sharks
where `sharks`.`Avg age` != "0"
group by `sharks`.`Avg age`
order by no_of_people desc;


-- location group by contestant
select `sharks`.`Location`, count(`sharks`.`Location`) as no_of_people from sharks
where `sharks`.`Location` != "0"
group by `sharks`.`Location`
order by no_of_people desc;


-- sector group by contestant
select `sharks`.`Sector` , count(`sharks`.`Sector`) as no_of_people from sharks
where `sharks`.`Sector` != "0"
group by `sharks`.`Sector`
order by no_of_people desc;


-- partner deals
select `sharks`.`Partners` , count(`sharks`.`Partners`) as no_of_people from sharks
where `sharks`.`Partners` != "-"
group by `sharks`.`Partners`
order by no_of_people desc;


-- making matrix
-- total deals ashneer invested
select
sum(`sharks`.`Ashneer Amount Invested`) as amt_invst_lakhs ,
avg(`sharks`.`Ashneer Equity Taken %`) as avg_equity_taken_pct,
count(`sharks`.`Deal`) as deal from sharks
where `sharks`.`Ashneer Amount Invested` != "0" and `sharks`.`Deal` != "no deal";
-- or
select a.Deal,b.amt_invst_lakhs,b.avg_equity_taken_pct from 
(
select 'Ashneer' as keyy, count(`sharks`.`Ashneer Amount Invested`) as deal from sharks
where `sharks`.`Ashneer Amount Invested` is not null and `sharks`.`Ashneer Amount Invested` != 0
) a
inner join(
select 'Ashneer' as keyy, sum(`sharks`.`Ashneer Amount Invested`) as amt_invst_lakhs,
avg(`sharks`.`Ashneer Equity Taken %`) as avg_equity_taken_pct from sharks
where  `sharks`.`Ashneer Amount Invested` != "0" and `sharks`.`Deal` != "no deal"
) b
on
a.keyy=b.keyy;


-- startup in which highest amount invested in each seactor
select `sharks`.`Brand`, `sharks`.`Sector`, `sharks`.`Amount Invested lakhs` ,
rank() over (partition by sector order by `sharks`.`Amount Invested lakhs` desc) as rnk,
row_number() over (partition by sector order by `sharks`.`Amount Invested lakhs` desc) as rn,
dense_rank() over (partition by sector order by `sharks`.`Amount Invested lakhs` desc) as drnk
from sharks
where `sharks`.`Amount Invested lakhs` != "0";


