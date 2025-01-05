CREATE DATABASE ZOMATO_ANALYSIS;
select * from country;
select * from currency;
select * from main;
select * from calender;


/* 1. Develop Charts based on Cusines, City, Ratings */
SELECT cuisines, city, AVG(rating) AS average_rating
FROM main
GROUP BY cuisines, city;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*2.Percentage of Resturants based on "Has_Online_delivery"*/
-- use 0 and 1

SELECT 
    CASE 
        WHEN Has_Online_delivery = 0 THEN 'Online Delivery Available'
        ELSE 'Online Delivery Not Available'
    END AS Delivery_Status,
    COUNT(*) AS Restaurant_Count,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main)) AS Percentage
FROM 
    main
GROUP BY 
    Has_Online_delivery;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
/* 3.Percentage of Resturants based on "Has_Table_booking"*/ 
  
SELECT 
    CASE 
        WHEN Has_Table_booking = 1 THEN 'Table Booking Available'
        ELSE 'Table Booking Not Available'
    END AS Booking_Status,
    COUNT(*) AS Restaurant_Count,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main)) AS Percentage
FROM 
    main
GROUP BY 
    Has_Table_booking;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
/* 4. Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets */
select * from main;
    WITH BucketedRestaurants AS (
    SELECT 
        NTILE(5) OVER (ORDER BY Averagecostfortwo) AS Bucket,
        Averagecostfortwo
    FROM main
)SELECT 
    Bucket,
    COUNT(*) AS NumRestaurants
FROM 
    BucketedRestaurants
GROUP BY 
    Bucket;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
/* 5. Count of Resturants based on Average Ratings */
select*from main;

    SELECT 
    ROUND(AVG(Rating), 1) AS Average_Rating,
    COUNT(*) AS NumRestaurants
FROM 
    main
GROUP BY 
    ROUND(Rating);
 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 6.Numbers of Resturants opening based on Year , Quarter , Month*/
-- year wise restaurants opening
select Year,count(RestaurantID) as Total_restaurant_open from main
group by 1
order by 1 desc;
    
----------------------------------------------------------------------
-- 7.month wise restaurants opening

select MonthName,count(RestaurantID)as Total_restaurant_open from main
group by 1
order by 1 desc;
------------------------------------------------------------------------------    
-- 8. Quarter wise restaurants openig

select Quarter,count(RestaurantID) as Total_restaurant_open from main
group by 1
order by 1 Asc;





------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
 
 -- Q. 9.Find the Numbers of Resturants based on City and Country.
select m. countryname,m.city,count(RestaurantID) as Total_Restaurent from main m left join country c on
m.CountryCode = c.CountryID
group by 1,2;


-------------------------------------------------------------------------------------------------------------------------------------------------------
-- 10.create calender table
CREATE TABLE Cal (
    Year_date year,
    Month_Full_Name varchar(20),
    Month_NO int,
    QTR varchar(10),
    YearMonth date,
    week_Day_No int(20),
    Weekday_name varchar(10),
    Financial_Month varchar(10),
    Financial_QTR varchar(10)
    
);
select*from main;

select*from cal;

select main.Datekey ,  main.Cuisines ,cal.Year_date ,cal.Week_day_No, cal.Financial_Month , cal.Financial_QTR
from calender
inner join cal on main.Year_opening = cal.Year_date;

insert into cal (Year_date, Month_Full_Name, Month_NO, QTR, YearMonth, week_Day_No, Weekday_name,Financial_Month,Financial_QTR)
values
('2013','September',9,'Q3','2013-09-12',5,'Friday','FM6','FQ1'),
('2018','June',6,'Q2','2018-06-10',3,'Wednesday','FM5','FQ3'),
('2019','october',10,'Q4','2019-10-17',2,'Monday','FM2','FQ2'),
('2014','july',7,'Q3','2014-07-12',2,'Saturday','FM3','FQ4'),
('2015','August',8,'Q3','2015-08-11',4,'Thursday','FM1','FQ1'),
('2016','june',6,'Q2','2016-06-16',5,'Wednesday','FM4','FQ2'),
('2017','September',9,'Q3','2017-09-10',4,'Friday','FM6','FQ3'),
('2016','october',10,'Q4','2016-10-19',1,'Saturday','FM5','FQ4'),
('2015','july',7,'Q3','2015-07-18',2,'Sunday','FM7','FQ3'),
('2014','August',8,'Q3','2014-08-12',3,'Wednesday','FM8','FQ1'),
('2013','june',6,'Q2','2013-06-19',4,'Friday','FM9','FQ4'),
('2015','September',9,'Q3','2015-09-11',2,'Sunday','FM10','FQ3'),
('2017','August',8,'Q3','2017-8-19',5,'Thursday','FM11','FQ2'),
('2012','October',10,'Q4','2012-10-20',6,'Saturday','FM12','FQ1'),
('2017','july',7,'Q3','2017-06-13',7,'Wednesday','FM11','FQ2'),
('2015','june',6,'Q2','2015-06-16',3,'Sunday','FM3','FQ4'),
('2011','December',12,'Q6','2011-12-12',4,'Wednesday','FM5','FQ2'),
('2012','November',11,'Q5','2012-11-12',8,'Sunday','FM9','FQ1'),
('2013','May',5,'Q4','2013-05-13',4,'Friday','FM8','FQ3'),
('2014','January',1,'Q3','2014-01-12',8,'Wednesday','FM6','FQ3'),
('2015','April',4,'Q2','2015-04-19',6,'Sunday','FM1','FQ1'),
('2016','February',2,'Q1','2016-02-12',1,'Monday','FM3','FQ2');
