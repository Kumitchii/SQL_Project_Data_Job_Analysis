-- Find companies (include company name) that have posted jobs offering health insurance, 
-- where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter. 
-- And order by the job postings count from highest to lowest.

SELECT
    COUNT(job_id) AS job_posted_count,
    company_dim.name AS company_name
FROM
    job_postings_fact
RIGHT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.job_health_insurance = TRUE
--    AND (EXTRACT(MONTH FROM job_postings_fact.job_posted_date) BETWEEN 4 AND 6)
--    AND EXTRACT(YEAR FROM job_postings_fact.job_posted_date) = 2023
    AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2
GROUP BY 
    company_name
HAVING
    COUNT(job_postings_fact.job_id) > 0
ORDER BY 
    job_posted_count DESC;

