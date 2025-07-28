-- Identify companies with the most diverse (unique) job titles. 
-- Use a CTE to count the number of unique job titles per company, then select companies with the highest diversity in job titles.

-- Hint
-- Use a CTE to count the distinct number of job titles for each company.
-- After identifying the number of unique job titles per company, 
-- join this result with the company_dim table to get the company names.
-- Order your final results by the number of unique job titles in descending order to highlight the companies
-- with the highest diversity.
-- Limit your results to the top 10 companies. 
-- This limit helps focus on the companies with the most significant diversity in job roles. 
-- Think about how SQL determines which companies make it into the top 10 when there are ties in the number of unique job titles.

WITH unique_job_titles AS (
    SELECT 
        job_postings_fact.company_id,
        COUNT(DISTINCT job_postings_fact.job_title) AS job_count,
        company_dim.name
    FROM 
        company_dim
        INNER JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
    GROUP BY
        job_postings_fact.company_id,
        company_dim.name
    ORDER BY
        job_count DESC
)

SELECT *
FROM unique_job_titles
LIMIT 10;

-- Define a CTE named title_diversity to calculate unique job titles per company
WITH title_diversity AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS unique_titles  
    FROM job_postings_fact
    GROUP BY company_id  
)
-- Get company name and count of how many unique titles each company has
SELECT
    company_dim.name,  
    title_diversity.unique_titles  
FROM title_diversity
	INNER JOIN company_dim ON title_diversity.company_id = company_dim.company_id  
ORDER BY 
	unique_titles DESC  
LIMIT 10;  