-- Calculate the number of unique skills required by each company. 
-- Aim to quantify the unique skills required per company and identify 
-- which of these companies offer the highest average salary for positions necessitating at least one skill. 
-- For entities without skill-related job postings, list it as a zero skill requirement and a null salary. 
-- Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies.

-- Hint
-- Use two CTEs:
-- The first should focus on counting the unique skills required by each company.
-- The second CTE should aim to find the highest average salary offered by these companies.
-- Ensure the final output includes companies without skill-related job postings. 
-- This involves use of LEFT JOINs to maintain companies in the result set even if they don't match criteria in the subsequent CTEs.
-- After creating the CTEs, the main query joins the company dimension table with the results of both CTEs.

WITH unique_skills AS (
    SELECT  
        skills_dim.skill_id,
        skills_dim.skills,
        company_dim.company_id,
        company_dim.name AS company_name,
        COUNT (DISTINCT skill_id)
    FROM
        company_dim
        INNER JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
        INNER JOIN 
    GROUP BY
        company_name
)