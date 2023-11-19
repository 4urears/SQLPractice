USE assignment_1;

#●	Select dates and commodities for cities Quetta, Karachi, and Peshawar where price was less than or equal 50 PKR
SELECT * FROM wfp_food_prices_pakistan LIMIT 264571;

SELECT date,cmname AS commodities FROM wfp_food_prices_pakistan WHERE mktname IN ("Karachi","Quette","Peshawar") AND price<=50 LIMIT 11234414;

#●	Query to check number of observations against each market/city in PK
SELECT mktname,COUNT( mktname) FROM wfp_food_prices_pakistan GROUP BY (mktname) ;

#	Show number of distinct cities
SELECT DISTINCT mktname FROM wfp_food_prices_pakistan;

#●	List down/show the names of cities in the table
SELECT DISTINCT mktname FROM wfp_food_prices_pakistan;

#●	List down/show the names of commodities in the table
#SELECT * FROM commodity;
SELECT DISTINCT cmname FROM wfp_food_prices_pakistan;

#●	List Average Prices for Wheat flour - Retail in EACH city separately over the entire period.
SELECT mktname,AVG(price) FROM  wfp_food_prices_pakistan  WHERE cmname IN ("Wheat flour - Retail") GROUP BY mktname;

#●	Calculate summary stats (avg price, max price) for each city separately for all cities 
#except Karachi and sort alphabetically the city names, commodity names
# where commodity is Wheat (does not matter which one) with separate rows for each commodity
SELECT * FROM wfp_food_prices_pakistan LIMIT 264571;


SELECT mktname,cmname,AVG(price),MAX(price),MIN(price), COUNT(price) FROM  wfp_food_prices_pakistan WHERE mktname != "Karachi" AND cmname LIKE "%wheat%"  GROUP BY cmname,mktname ORDER BY mktname,cmname;

#●	Calculate Avg_prices for each city for Wheat Retail 
#and show only those avg_prices which are less than 30
SELECT mktname,AVG(price)  FROM  wfp_food_prices_pakistan 
WHERE cmname LIKE "%wheat%"
GROUP BY mktname HAVING AVG(price)<30;

#●	Prepare a table where you categorize prices based on a 
#logic (price < 30 is LOW, price > 250 is HIGH, in between are FAIR)

SELECT  date, cmname, mktname, price,
CASE
WHEN price <30  THEN 'LOW'
WHEN price >250 THEN 'HIGH'
ELSE 'FAIR'
END AS  'price_fair?'
 FROM wfp_food_prices_pakistan;


#●	Create a query showing date, cmname, category, city, price, city_category where Logic for city category is: Karachi and Lahore 
#are 'Big City', Multan and Peshawar are 'Medium-sized city', Quetta is 'Small City'

SELECT  date, cmname, category, mktname, price, 
CASE 
WHEN mktname IN ('Karachi', 'Lahore') THEN 'Big City'
WHEN mktname IN ('Multan', 'Peshawar') THEN 'Medium-sized City'
WHEN mktname = 'Quetta' THEN 'Small City'
ELSE 'Other'
END AS city_category
FROM wfp_food_prices_pakistan;

#●	Create a query to show date, cmname, city, price. Create new column price_fairness through CASE showing price is fair if less than 100,
# unfair if more than or equal to 100, if > 300 then 'Speculative'
SELECT  date, cmname, mktname, price,
CASE
WHEN price <100  THEN 'fair'
WHEN price >=100 AND price <300 THEN 'unfair'
WHEN price > 300 THEN 'Speculative'
ELSE 'Other'
END AS  'price_fairnes'
 FROM wfp_food_prices_pakistan;
 
 #●	Join the food prices and commodities table with a left join. 
 SELECT * FROM wfp_food_prices_pakistan LIMIT 264571;
SELECT * FROM commodity;
SELECT * FROM wfp_food_prices_pakistan LEFT JOIN commodity ON wfp_food_prices_pakistan.cmname=commodity.cmname;

#●	Join the food prices and commodities table with an inner join
SELECT * FROM wfp_food_prices_pakistan INNER JOIN commodity ON wfp_food_prices_pakistan.cmname=commodity.cmname;
