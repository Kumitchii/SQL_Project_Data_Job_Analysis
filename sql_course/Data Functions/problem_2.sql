-- Count the number of job postings for each month, 
-- adjusting the job_posted_date to be in 'America/New_York' time zone before extracting the month. 
-- Assume the job_posted_date is stored in UTC. Group by and order by the month.

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS job_posted_month
FROM 
    job_postings_fact
GROUP BY 
    job_posted_month
ORDER BY
    job_posted_month;
