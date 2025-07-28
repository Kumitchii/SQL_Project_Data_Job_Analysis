-- Find companies that offer an average salary above the overall average yearly salary of all job postings. 
-- Use subqueries to select companies with an average salary higher than the overall average salary (which is another subquery).

-- Мій варіант
SELECT
    company_dim.company_id,
    company_dim.name,
    AVG(job_postings_fact.salary_year_avg)
FROM
    company_dim
INNER JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
GROUP BY
    company_dim.company_id,
    company_dim.name
HAVING 
    AVG(job_postings_fact.salary_year_avg) > (
        SELECT
            AVG(salary_year_avg) AS average_salary
        FROM
            job_postings_fact
    );

--його варіант
SELECT 
    company_dim.company_id,
    company_dim.name
FROM 
    company_dim
INNER JOIN (
    -- Subquery to calculate average salary per company
    SELECT 
        company_id, 
        AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY company_id
    ) AS company_salaries ON company_dim.company_id = company_salaries.company_id
-- Filter for companies with an average salary greater than the overall average
WHERE company_salaries.avg_salary > (
    -- Subquery to calculate the overall average salary
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
);