use project_hr;
-- QUESTIONS
-- 1. What is the gender breakdown of employees in the company?
 
 Select gender, count(*) as count
 from hr
 Where age >= 18 and termdate = '0000-00-00'
 Group by gender;


-- 2. What is the race/ethnicity breakdown of employees in the company?

Select race, count(*) as count
From hr
Where age >= 18 and termdate = '0000-00-00'
Group by race
Order by count(*) desc;


-- 3. What is the age distribution of employees in the company?

Select 
	min(age) as youngest,
    max(age) as oldest
From hr
Where age >= 18 and termdate = '0000-00-00';

-- age_distibution
Select 
		Case
		When age>=18 and age<=24 Then '18-24'
        When age>=25 and age<=34 Then '25-34'
        When age>=35 and age<=44 Then '35-44'
        When age>=45 and age<=54 Then '45-54'
        When age>=55 and age<=64 Then '55-64'
        Else '65+'
	End as age_group, 
    Count(*) as count
From hr
Where age >= 18 and termdate = '0000-00-00'
Group by age_group
order by age_group;

-- age_distibution in genders
Select 
		Case
		When age>=18 and age<=24 Then '18-24'
        When age>=25 and age<=34 Then '25-34'
        When age>=35 and age<=44 Then '35-44'
        When age>=45 and age<=54 Then '45-54'
        When age>=55 and age<=64 Then '55-64'
        Else '65+'
	End as age_group, gender, 
    Count(*) as count
From hr
Where age >= 18 and termdate = '0000-00-00'
Group by age_group,gender
order by age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?

Select location, count(*) as count
From hr
Where age >= 18 and termdate = '0000-00-00'
Group by location
order by count desc;

-- 5. What is the average length of employment for employees who have been terminated?

select 
	Round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employment
from hr
Where termdate <= curdate() and termdate != '0000-00-00' and age >= 18;

-- 6. How dose the gender distibution vary across departments and job titles?

Select department, gender,count(*) as count
From hr
Where age >= 18 and termdate = '0000-00-00'
Group by department,gender
order by count desc;


-- 7. What is the distibution of job titles across the company?

select jobtitle, count(*) as count
from hr
Where age >= 18 and termdate = '0000-00-00'
Group by jobtitle
Order by count desc;

-- 8. Which department has the highest turnover rate?

Select department,
	total_count,
	terminated_count,
	terminated_count/total_count as termination_rate        
from (Select 
		department,
        count(*) as total_count,
        Sum(Case 
        When termdate <= curdate() and termdate != '0000-00-00' Then 1 Else 0 End) as terminated_count
        from hr
        Where age >= 18
        Group by department) as subquery
Order by termination_rate desc;

-- 9. What is the distribution of employees across locations by state?

select 
location_state as state, 
count(*) as counts
from hr
Where age >= 18 and termdate = '0000-00-00'
Group by state
Order by counts desc;

-- 10. How has the company's employee count changed over time based on hire and term date?

Select
	years,
    hires,
    terminations,
    (hires - terminations) as net_change,
    Round((hires - terminations)/hires*100,2) as net_change_percentage
From (
	Select 
    Year(hire_date) as years,
    count(*) as hires,
    Sum( Case When termdate <= curdate() and termdate != '0000-00-00' Then 1 Else 0 End) as terminations
    From hr
    Where age >=18
    Group by years) as subquery
Order by years asc;

-- 11. What is the tenure distribution for each department?

select department,
	   Round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
 from hr
 Where termdate <= curdate() and termdate != '0000-00-00' and age>=18
 group by department
 order by avg_tenure desc;