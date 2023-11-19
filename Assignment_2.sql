SELECT * FROM petowners;
SELECT * FROM pets LIMIT 123423235;
SELECT * FROM proceduresdetails;
SELECT * FROM procedureshistory;

#1. List the names of all pet owners along with the names of their pets.

SELECT po.OwnerID,po.NAME,po.SURNAME,p.PetID,p.Name FROM petowners AS po
LEFT JOIN pets AS p
ON po.OwnerID=p.OwnerID;

#2.List all pets and their owner names, including pets that don't have recorded owners.

SELECT * FROM pets AS p
LEFT JOIN  petowners AS po
ON p.OwnerID=po.OwnerID
UNION
SELECT * FROM  petowners AS po
LEFT JOIN  pets AS p
ON po.OwnerID=p.OwnerID;
#why doesn't MY SQL support FULL OUTER JOIN??

#Find the names of pets along with their owners' names and the details of the procedures they have undergone
SELECT * FROM petowners;
SELECT * FROM pets LIMIT 123423235;
SELECT * FROM proceduresdetails;
SELECT * FROM procedureshistory;

SELECT p.name,po.name,ph.procedureType
FROM pets AS P
LEFT JOIN petowners AS po
ON p.ownerID=po.ownerID
LEFT JOIN procedureshistory AS ph
ON p.PetID = ph.PetID;

#5. List all pet owners and the number of dogs they own.

SELECT po.name,count(p.PetID) AS dogs_owned
FROM petowners AS po
LEFT JOIN pets as p
ON po.OwnerID=p.OwnerID
WHERE p.Kind = "dog"
GROUP BY po.name;

#6. Identify pets that have not had any procedures.

SELECT p.petId,p.name,ph.procedureType
FROM pets AS P
LEFT JOIN procedureshistory AS ph
ON p.PetID = ph.PetID
WHERE procedureType IS NULL;

#7. Find the name of the oldest pet.
SELECT * FROM pets
WHERE age = (SELECT MAX(age) FROM pets);


SELECT * FROM procedureshistory;
SELECT * FROM proceduresdetails;

SELECT AVG(price) FROM proceduresdetails;

#8. List all pets who had procedures that cost more than the average cost of all procedures.

SELECT p.petId,p.name,ph.proceduretype,ph.ProcedureSubCode
FROM pets AS p
LEFT JOIN procedureshistory as ph
ON p.petID=ph.petID
WHERE (ProcedureType,procedureSubCode) IN 
(SELECT proceduretype,ProcedureSubCode FROM proceduresdetails
WHERE price >(SELECT AVG(price) FROM proceduresdetails));

SELECT proceduretype,ProcedureSubCode FROM proceduresdetails
WHERE price >(SELECT AVG(price) FROM proceduresdetails);

SELECT AVG(price) FROM proceduresdetails;
#9. Find the details of procedures performed on 'Cuddles'.
SELECT * FROM proceduresdetails
WHERE (procedureType,procedureSubcode) IN(

SELECT procedureType,procedureSubcode
FROM procedureshistory
WHERE petID IN (SELECT petID FROM pets
WHERE Name = 'cuddles'));

#10. Create a list of pet owners along with the total cost they have spent on
#procedures and display only those who have spent above the average spending.


SELECT * FROM petowners;
SELECT * FROM pets LIMIT 123423235;
SELECT * FROM proceduresdetails;
SELECT * FROM procedureshistory;

SELECT p.petid,ph.procedureType,pd.price FROM pets AS p
LEFT JOIN procedureshistory AS ph
on p.petID=ph.PetId 
LEFT JOIN  proceduresdetails AS pd
ON ph.proceduretype = pd.proceduretype
WHERE pd.price >(SELECT AVG(pd1.price) FROM proceduresdetails AS pd1);

#11. List the pets who have undergone a procedure called 'VACCINATIONS'.

SELECT p.name,p.petid,ph.procedureType FROM pets AS p
LEFT JOIN procedureshistory AS ph
on p.petID=ph.PetId 
WHERE ph.procedureType = "VACCINATIONS";

#12. Find the owners of pets who have had a procedure called 'EMERGENCY'.

SELECT po.ownerid,p.name,p.petid,ph.procedureType FROM pets AS p

LEFT JOIN petowners AS po
ON p.OwnerID=po.ownerid
LEFT JOIN procedureshistory AS ph
on p.petID=ph.PetId 
WHERE ph.procedureType = "EMERGENCY";

SELECT * FROM petowners;
SELECT * FROM pets LIMIT 123423235;
SELECT * FROM proceduresdetails;
SELECT * FROM procedureshistory;


SELECT DISTINCT procedureType FROM procedureshistory;

#13. Calculate the total cost spent by each pet owner on procedures.

SELECT po.ownerid,SUM(pd.price) AS total_cost FROM pets AS p
LEFT JOIN procedureshistory AS ph
on p.petID=ph.PetId 
LEFT JOIN  proceduresdetails AS pd
ON ph.proceduretype = pd.proceduretype
RIGHT JOIN petowners AS po
ON po.ownerid=p.ownerid
GROUP BY po.ownerid;

#14. Count the number of pets of each kind.

SELECT * FROM pets LIMIT 123423235;

SELECT kind, count(petid) FROM pets
GROUP BY kind;

#15. Group pets by their kind and gender and count the number of pets in each group.

SELECT kind,GENDER, count(petid) FROM pets
GROUP BY kind,GENDER;

#Show the average age of pets for each kind, but only for kinds that have more than 5 pets.
SELECT kind, avg(AGE),COUNT(PETID) FROM pets
GROUP BY kind
HAVING COUNT(petid) > 5;

#17. Find the types of procedures that have an average cost greater than $50.

SELECT ProcedureType,AVG(price) FROM proceduresdetails
GROUP BY ProcedureType
HAVING AVG(price)>50;

#18. Classify pets as 'Young', 'Adult', or 'Senior' based on their age. Age less then 3 Young, 
#Age between 3and 8 Adult, else Senior.
SELECT petid,name,case
WHEN Age<3 THEN "Young"
WHEN age>3 and age<8 THEN "ADULT"
ELSE "Senior"
END AS age_category
FROM pets;

#19. Calculate the total spending of each pet owner on procedures, labeling them
#as 'Low Spender' for spending under $100, 'Moderate Spender' for spending
#between $100 and $500, and 'High Spender' for spending over $500.

SELECT po.ownerid,
CASE
WHEN SUM(pd.price) <100 THEN "Low Spender"
WHEN SUM(pd.price) >100 AND SUM(pd.price) <500 THEN "Moderate Spender"
WHEN SUM(pd.price) >500 THEN "High Spender"
END AS total_cost_fact 
FROM pets AS p
LEFT JOIN procedureshistory AS ph
on p.petID=ph.PetId 
LEFT JOIN  proceduresdetails AS pd
ON ph.proceduretype = pd.proceduretype
RIGHT JOIN petowners AS po
ON po.ownerid=p.ownerid
GROUP BY po.ownerid;


#20. Show the gender of pets with a custom label ('Boy' for male, 'Girl' for female).
SELECT petID,Name,CASE
WHEN GENDER = "male" THEN "Boy"
WHEN GENDER = "female" THEN "Girl"
END AS gender_label
 FROM pets;

#21. For each pet, display the pet's name, the number of procedures they've had,
#and a status label: 'Regular' for pets with 1 to 3 procedures, 'Frequent' for 4 to
#7 procedures, and 'Super User' for more than 7 procedures

SELECT p.petId,COUNT(ph.procedureType),
CASE
WHEN COUNT(ph.procedureType) BETWEEN 1 AND 3 THEN " Regular"
WHEN COUNT(ph.procedureType)BETWEEN 4 AND 7 THEN " Frequent"
ELSE " SUPER USER"
END AS count_name
FROM pets AS P
LEFT JOIN procedureshistory AS ph
ON p.PetID = ph.PetID
GROUP BY p.petID;


#22. Rank pets by age within each kind.
SELECT *,
RANK() OVER (PARTITION BY KIND ORDER BY age) AS R_kind_age
FROM pets;

#23. Assign a dense rank to pets based on their age, regardless of kind.
SELECT *,
DENSE_RANK() OVER (ORDER BY age) AS R_age
FROM pets;

#24. For each pet, show the name of the next and previous pet in alphabetical order.

SELECT name,
LEAD(name) OVER(ORDER BY name) AS previous_pet,
LAG(name) OVER(ORDER BY name) AS next_pet
FROM pets;

#SELECT customer_id,data_used,
#LEAD(data_used) OVER(PARTITION BY customer_id)
#FROM service_usage;

#25. Show the average age of pets, partitioned by their kind.

SELECT petid,name,KIND, AVG(AGE) OVER(PARTITION BY kind) AS p_age_kind
FROM pets;

#Create a CTE that lists all pets, then select pets older than 5 years from the CTE.

WITH NEW_P AS(
SELECT * 
FROM pets)
#WHERE age>5)

SELECT * 
FROM pets
WHERE age>5;



SELECT * FROM petowners;
SELECT * FROM pets LIMIT 123423235;
SELECT * FROM proceduresdetails;
SELECT * FROM procedureshistory;

