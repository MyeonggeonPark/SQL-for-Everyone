SELECT *
FROM employees A
WHERE A.salary = (
                    SELECT salary
                    FROM employees
                    WHERE last_name = 'De Haan'
                    );

SELECT salary
FROM employees
WHERE last_name = 'De Haan';

SELECT salary
FROM employees A
WHERE A.salary = 17000;

--error
SELECT *
FROM employees A
WHERE A.salary = (
                    SELECT salary
                    FROM employees
                    WHERE last_name = 'Taylor'
                    );

SELECT *
FROM employees A
WHERE A.salary IN (
                    SELECT MIN(salary)
                    FROM employees
                    GROUP BY department_id
                    )
ORDER BY A.salary DESC;

SELECT *
FROM employees A
WHERE (A.job_id, A.salary) IN (
                                SELECT job_id, MIN(salary)
                                FROM employees
                                GROUP BY job_id
                                )
ORDER BY A.salary DESC;

SELECT *
FROM employees A,
                    ( SELECT department_id
                      FROM departments
                      WHERE department_name = 'IT') B
WHERE A.department_id = B.department_id;