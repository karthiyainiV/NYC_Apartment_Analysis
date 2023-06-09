select * from dbo.Nycapartment$;

select * from dbo.Nycapartment$ where price is null;

alter table dbo.Nycapartment$ add Year_wise_review int;

update dbo.Nycapartment$
set Year_wise_review  = YEAR(last_review);

alter table dbo.Nycapartment$ 
drop column review_as_per_year;

select neighbourhood_group, COUNT(neighbourhood_group) as nbhcount 
from  dbo.Nycapartment$
group by(neighbourhood_group);


select t1.room_type, round(t1.avg_price, 2) as avg_price, t2.max_reviews_permonth, t2.max_reviews
from
(
  select room_type, Avg(price) as avg_price 
  from dbo.Nycapartment$
  group by(room_type)
)t1 join
(select room_type, max(reviews_per_month) as max_reviews_permonth , max(number_of_reviews) as max_reviews
from dbo.Nycapartment$
group by(room_type)) 
t2 on t1.room_type = t2.room_type
order by avg_price, max_reviews, max_reviews_permonth;


select t1.room_type, round(t1.avg_price, 2) as avg_price, round(t2.avg_reviews_permonth, 2) as avg_reviews_permonth , round(t2.avg_reviews,2) as avg_reviews
from
(
  select room_type, Avg(price) as avg_price
  from dbo.Nycapartment$
  group by(room_type)
)t1 
join
(select room_type, avg(reviews_per_month) as avg_reviews_permonth , avg(number_of_reviews) as avg_reviews
from dbo.Nycapartment$
group by(room_type)) 
t2 
on 
t1.room_type = t2.room_type
order by avg_price,avg_reviews, avg_reviews_permonth;

with apt_description as
(
select  neighbourhood_group, minimum_nights,(price * minimum_nights) as price_as_per_night, room_type
from dbo.Nycapartment$
)
select  room_type, round(Avg(price_as_per_night) ,2) as avg_price from apt_description
group by room_type;

select neighbourhood_group, COUNT(neighbourhood_group) as Total_count from dbo.Nycapartment$
where availability_365 = 365
group by neighbourhood_group;

select Year_wise_review ,round(Avg(reviews_per_month) ,2) as review_percentage
from dbo.Nycapartment$ 
group by Year_wise_review ;



with Apartment_details_2019 as 
(
select  neighbourhood_group, minimum_nights,(price * minimum_nights) as price_as_per_night, room_type
from dbo.Nycapartment$
where Year_wise_review = 2019 and availability_365= 365 
)
select  neighbourhood_group, round(Avg(price_as_per_night) ,2) as avg_price from Apartment_details_2019
group by neighbourhood_group;

select t1.neighbourhood_group, round(t1.price_as_per_night, 2) as avg_room_price_on_days, round(t2.avg_price, 2) as price_of_singleday
from
(
  select neighbourhood_group, Avg(price * minimum_nights) as price_as_per_night
  from dbo.Nycapartment$
  group by(neighbourhood_group)
)t1 
join
(select neighbourhood_group, avg(price) as avg_price
from dbo.Nycapartment$
group by(neighbourhood_group)) 
t2 
on 
t1.neighbourhood_group = t2.neighbourhood_group
order by avg_price;

