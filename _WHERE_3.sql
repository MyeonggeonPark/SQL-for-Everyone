SELECT *
FROM employees
WHERE employee_id = 100;

SELECT *
FROM employees
WHERE first_name = 'David';

SELECT *
FROM employees
WHERE employee_id >= 105;

SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

SELECT *
FROM employees
WHERE salary IN (10000, 17000, 24000);

SELECT *
FROM employees
WHERE job_id LIKE 'AD%';

SELECT *
FROM employees
WHERE job_id LIKE 'AD___';

SELECT *
FROM employees
WHERE manager_id IS NULL;

SELECT *
FROM employees
WHERE salary > 4000
AND job_id = 'IT_PROG';

SELECT *
FROM employees
WHERE salary > 4000
AND job_id = 'IT_PROG'
OR job_id = 'FI_ACCOUNT';

SELECT *
FROM employees
WHERE employee_id <> 105;

SELECT *
FROM employees
WHERE manager_id IS NOT NULL;
