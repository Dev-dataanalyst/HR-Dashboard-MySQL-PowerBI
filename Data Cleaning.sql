CREATE DATABASE project_hr;
use project_hr;
Select * from hr;

# DATA CLEANING

# In given data set 'ID' name not correct

Alter table hr
change column ï»¿id emp_id varchar(20);

# Now birthdate column format to be update

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
    END;
    
# If above querry not run then sql is in safe mode because we not use WHERE clause in update mode. 
# So below code while executing above sql querry

SET sql_safe_updates = 0;

# Similarly need to change string to date of hire_date column.

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN   date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
    END;

# now update datatype of birthdate and hire_date column into date 

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

# Also we having termination date column which also to be modify
# In termdate column date and time together, Also some dates are exceeding from current date.

select termdate from hr;  

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', 
				date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),
                '0000-00-00')
WHERE true;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

# Create Age column and extract age from birthdate column

ALTER TABLE hr
ADD COLUMN age INT;

# extract 

UPDATE hr
SET age = timestampdiff(YEAR,birthdate,curdate());  



 
 



