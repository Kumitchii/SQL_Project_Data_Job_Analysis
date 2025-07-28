-- Determine the size category ('Small', 'Medium', or 'Large') for each company 
-- by first identifying the number of job postings they have.
-- Use a subquery to calculate the total job postings per company. 
-- A company is considered 'Small' if it has less than 10 job postings, 
-- 'Medium' if the number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings. 
-- Implement a subquery to aggregate job counts per company before classifying them based on size.

SELECT
    company_dim.company_id,
    name,
    CASE
        WHEN COUNT(job_id) <= 10 THEN 'Small'
        WHEN COUNT(job_id) <= 50 THEN 'Medium'
        WHEN COUNT(job_id) > 50 THEN 'Large'
    END AS company_size_category
FROM 
    company_dim
INNER JOIN job_postings_fact 
    ON job_postings_fact.company_id = company_dim.company_id
GROUP BY
    company_dim.company_id,
    company_dim.name
ORDER BY 
   COUNT(job_id) DESC;

-- Aggregate job counts per company in the subquery. This involves grouping by company and counting job postings.
-- Use this subquery in the FROM clause of your main query.
-- In the main query, categorize companies based on the aggregated job counts from the subquery with a CASE statement.
-- The subquery prepares data (counts jobs per company), and the outer query classifies companies based on these counts.

SELECT
    company_id,
    name,
    CASE
        WHEN postings_count <= 10 THEN 'Small'
        WHEN postings_count <= 50 THEN 'Medium'
        WHEN postings_count > 50 THEN 'Large'
    END AS company_size_category
FROM (
    SELECT
        company_dim.company_id,
        company_dim.name,
        COUNT(job_postings_fact.job_id) AS postings_count
    FROM 
        company_dim
    INNER JOIN job_postings_fact 
        ON job_postings_fact.company_id = company_dim.company_id
    GROUP BY 
        company_dim.company_id,
        company_dim.name
) AS job

