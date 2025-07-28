-- Write a SQL query using the job_postings_fact table that returns the following columns:
-- job_id
-- salary_year_avg
-- experience_level (derived using a CASE WHEN)
-- remote_option (derived using a CASE WHEN)

-- Only include rows where salary_year_avg is not null.

SELECT
    job_id,
    salary_year_avg,
    CASE
      WHEN job_title ILIKE '%Senior%' THEN 'Senior'
      WHEN job_title ILIKE '%Manager%' OR job_title ILIKE '%Lead%' THEN 'Lead/Manager'
      WHEN job_title ILIKE '%Junior%' OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'
      ELSE 'Not Specified'
  END AS experience_level,
    CASE 
        WHEN job_work_from_home = TRUE THEN 'Yes' 
        ELSE 'No' 
    END AS remote_option
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY job_id;
