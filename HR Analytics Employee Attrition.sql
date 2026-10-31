USE hr_attrition;
SELECT * FROM HAEA1 LIMIT 5;

-- Check Attrition values
SELECT DISTINCT Attrition FROM HAEA1;

-- Job Role Attrition
-- Find all job roles
SELECT DISTINCT JobRole FROM HAEA1;

-- Count employee by job role
SELECT JobRole, COUNT(*) AS TotalEmployees FROM HAEA1 GROUP BY JobRole;

-- Count employee who left by job role
SELECT JobRole, COUNT(*) AS EmployeesLeft FROM HAEA1 WHERE Attrition = 'Yes' GROUP BY JobRole;

-- Calculate attrition rate by job role
SELECT JobRole, COUNT(*) AS TotalEmployees, 
	SUM(CASE
			WHEN Attrition = 'Yes' THEN 1
            ELSE 0
		END
	) AS EmployeesLeft,
    ROUND(
		SUM(CASE
				WHEN Attrition = 'Yes' THEN 1
                ELSE 0
			END
		) * 100.0 / COUNT(*), 2 
	) AS AttritionRate
FROM HAEA1 GROUP BY JobRole ORDER BY AttritionRate DESC;

-- Years at Comapany Attrition
-- Check YearsAtComplany
SELECT 
	min(YearsAtCompany) AS ManimumYears,
	max(YearsAtCompany) AS MaximumYears,
    ROUND(avg(YearsAtCompany), 2) AS AverageYears
FROM HAEA1;

-- Count employees by years at company
SELECT 
	YearsAtCompany,
    COUNT(*) AS TotalEmployees
FROM HAEA1 GROUP BY YearsAtCompany ORDER BY YearsAtCompany;

-- Count employees who left by years
SELECT
    YearsAtCompany,
    COUNT(*) AS EmployeesLeft
FROM HAEA1
WHERE Attrition = 'Yes'
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany;

-- Calculate attrition rate by years at company
SELECT 
	YearsAtCompany,
    COUNT(*) AS TotalEmployees,
    SUM(CASE
			WHEN Attrition = 'Yes' THEN 1
            ELSE 0
		END
	) AS EmployeesLeft,
    ROUND(
		SUM(CASE
				WHEN Attrition = 'Yes' THEN 1
                ELSE 0
			END
		) * 100.0/COUNT(*), 2
	) AS AttritionRate
FROM HAEA1 GROUP BY YearsAtCompany ORDER BY YearsAtCompany;

-- Attrition by Department
-- Find all Department
SELECT DISTINCT Department FROM HAEA1;

-- Count employees by Department
SELECT Department, COUNT(*) AS TotalEmployee FROM HAEA1 GROUP BY Department;

-- Calculate attrition rate by Department
SELECT Department, COUNT(*) AS TotalEmployee,
	SUM(
		CASE 
			WHEN Attrition = 'Yes' THEN 1
            ELSE 0
		END
	) AS EmployeeLeft,
    ROUND(
		SUM(
			CASE 
				WHEN Attrition = 'Yes' THEN 1
                ELSE 0
			END
		) * 100.0 / COUNT(*), 2
	) AS AttritionRate
    FROM HAEA1 GROUP BY Department ORDER BY AttritionRate DESC;
    
-- Overtime vs Attrition 
SELECT OverTime, COUNT(*) AS TotalEmployees,
	SUM(
		CASE
			WHEN Attrition = 'Yes' THEN 1
			ELSE 0
		END
	) AS EmployeesLeft,
        
	ROUND(
		SUM(
			CASE
				WHEN Attrition ='Yes' THEN 1
				ELSE 0
			END
		) * 100.0 / COUNT(*), 2
	)AS AttritionRate
FROM HAEA1 GROUP BY OverTime ORDER BY AttritionRate DESC;

-- Job Satisfaction vs Attrition
select JobSatisfaction, count(*) as TotalEmployee,
	sum(
		case 
			when Attrition = 'Yes' then 1
            else 0
		end
	) as EmployeeLeft,
    round(
		sum(
			case
				when Attrition = 'Yes' then 1
                else 0
			end
		) * 100.0 / count(*), 2
	) as AttritionRate
from HAEA1 group by JobSatisfaction order by JobSatisfaction;

-- Joblevel vs Attrition 
select Joblevel, count(*) as TotalEmployee,
	sum(
		case
			when Attrition = 'Yes' then 1
            else 0
		end
	) as EmployeeLeft,
    round(
		sum(
			case
				when Attrition = 'Yes' THEN 1
				else 0
			end
		) * 100.0 / count(*), 2
	) as AttritionRate
from HAEA1 group by JobLevel order by JobLevel;

-- Salary Analysis
select Attrition, count(*) as TotalEmployees,
	round(avg(MonthlyIncome), 2) as AverageMonthlyIncome
from HAEA1 group by Attrition;

-- Average Income by Job Role
select JobRole, count(*) as TotalEmployees,
	round(avg(MonthlyIncome),2 ) as AverageMonthlyIncome
from HAEA1 group by JobRole;

-- Department + Overtime + Attrition
SELECT Department, OverTime,
    COUNT(*) AS TotalEmployees,
    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,
    ROUND(
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*), 2
    ) AS AttritionRate
FROM HAEA1 GROUP BY Department, OverTime ORDER BY Department, AttritionRate DESC;