/*
Use MySQL or PyMySQL to perform the below queries.
Note: Use only the cleaned data for SQL part of the project
*/
select * from corona_cleaned;
-- Query 1: Find the number of corona patients who faced shortness of breath.
select count(*) num_sob from corona_cleaned where shortness_of_breath='True' and corona='positive';
#Query result: 979

-- Query 2: Find the number of negative corona patients who have fever and sore_throat.
select count(*) fever_sore_throat from corona_cleaned where fever='True' and sore_throat='True' and corona='negative';
#Query result: 50
-- Query 3: Group the data by month and rank the number of positive cases.
select *,rank() over(order by total) as 'rank' from (
select month(test_date) 'month', count(*) total from corona_cleaned where corona='positive' group by month(test_date)) x order by month;
 
-- Query 4: Find the female negative corona patients who faced cough and headache.
select Ind_ID from corona_cleaned where sex='female' and corona='negative' and cough_symptoms='True' and headache='True';
#Query result: 32

-- Query 5: How many elderly corona patients have faced breathing problems?
select count(*) Elderly_wt from corona_cleaned where age_60_above='Yes' and shortness_of_breath='True' and corona='positive';
#Query result: 227

-- Query 6: Which three symptoms were more common among COVID positive patients?
select * from (
select 'Cough' symptom, count(if(cough_symptoms='True',1,null)) symptoms_count from corona_cleaned where corona='positive'
union select 'Fever',count(if(Fever='True',1,null)) from corona_cleaned where corona='positive'
union
select 'Sore_throat' ,count(if(sore_throat='True',1,null)) from corona_cleaned where corona='positive'
union
select 'Shortness_of_breath',count(if(shortness_of_breath='True',1,null)) from corona_cleaned where corona='positive'
union
select 'Headache', count(if(headache='True',1,null)) from corona_cleaned where corona='positive') x order by symptoms_count desc limit 3;

#Query result: Cough, Fever, Headache

-- Query 7: Which symptom was less common among COVID negative people?
select * from (
select 'Cough' symptom, count(if(cough_symptoms='True',1,null)) symptoms_count from corona_cleaned where corona='negative'
union select 'Fever',count(if(Fever='True',1,null)) from corona_cleaned where corona='negative'
union
select 'Sore_throat' ,count(if(sore_throat='True',1,null)) from corona_cleaned where corona='negative'
union
select 'Shortness_of_breath',count(if(shortness_of_breath='True',1,null)) from corona_cleaned where corona='negative'
union
select 'Headache', count(if(headache='True',1,null)) from corona_cleaned where corona='negative') x order by symptoms_count limit 3;

#Query result: Shortness_of_breath, Sore_throat, Headache

-- Query 8: What are the most common symptoms among COVID positive males whose known contact was abroad?
select * from (
select 'Cough' symptom, count(if(cough_symptoms='True',1,null)) symptoms_count from corona_cleaned where corona='positive' and sex='male' and known_contact='Abroad'
union select 'Fever',count(if(Fever='True',1,null)) from corona_cleaned where corona='positive' and sex='male' and known_contact='Abroad'
union
select 'Sore_throat' ,count(if(sore_throat='True',1,null)) from corona_cleaned where corona='positive' and sex='male' and known_contact='Abroad'
union
select 'Shortness_of_breath',count(if(shortness_of_breath='True',1,null)) from corona_cleaned where corona='positive' and sex='male' and known_contact='Abroad'
union
select 'Headache', count(if(headache='True',1,null)) from corona_cleaned where corona='positive' and sex='male' and known_contact='Abroad') x order by symptoms_count desc limit 1;

#Query result: Cough