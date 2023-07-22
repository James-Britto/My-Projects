/*Use MySQL or PyMySQL to perform the below queries.

Note: Use only the cleaned data for SQL part of the project

*/

select * from credit_card_approval_cleaned;

-- Query 1: Group the customers based on their income type and find the average of their annual income.

select type_income,round(avg(annual_income),2) Average_Income from credit_card_approval_cleaned group by type_income;

-- Query 2: Find the female owners of cars and property.

select Ind_Id from credit_card_approval_cleaned where gender='F' and car_owner='Y' and propert_owner='Y';

-- Query 3: Find the male customers who are staying with their families.

select Ind_ID, gender, marital_status,family_members from credit_card_approval_cleaned where gender='M' and family_members>1;

-- Query 4: Please list the top five people having the highest income.

select Ind_ID,annual_income,rnk from (select *,dense_rank() over(order by annual_income desc) rnk from credit_card_approval_cleaned) x
where x.rnk<=5;

select Ind_ID,annual_income,rnk from (select *,row_number() over(order by annual_income desc) rnk from credit_card_approval_cleaned) x
where x.rnk<=5;

-- Query 5: How many married people are having bad credit?
select count(Ind_ID) people_count from credit_card_approval_cleaned where marital_status in ('Married','Civil marriage') and label=1;

-- Query 6: What is the highest education level and what is the total count?
select education,count(*) total from credit_card_approval_cleaned where education='Academic degree';
select education,count(*) total from credit_card_approval_cleaned group by education order by total desc limit 1;

-- Query 7: Between married males and females, who is having more bad credit?
select gender,count(*) total from credit_card_approval_cleaned where label=1 group by gender order by total desc limit 1;