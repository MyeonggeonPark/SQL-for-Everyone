SELECT A.first_name, A.last_name, B.*
FROM employees A, job_history B
WHERE A.employee_id = B.employee_id
AND A.employee_id = 101;

SELECT *
FROM employees A, departments B
WHERE A.department_id = B.department_id;

SELECT A.employee_id, A.department_id, B.department_name, C.location_id, C.city
FROM employees A, departments B, locations C
WHERE A.department_id = B.department_id
AND B.location_id = C.location_id;

SELECT COUNT(*) 조인된건수
FROM employees A, departments B
WHERE A.department_id = B.department_id;

SELECT A.employee_id, A.first_name, A.last_name, B.department_id, B.department_name
FROM employees A, departments B
WHERE A.department_id = B.department_id(+)
ORDER BY A.employee_id;

SELECT A.employee_id, A.first_name, A.last_name, B.department_id, B.department_name
FROM employees A, departments B
WHERE A.department_id(+) = B.department_id
ORDER BY A.employee_id;

SELECT A.employee_id, A.first_name, A.last_name, A.manager_id,
    B.first_name||' '||B.last_name manager_name
FROM employees A, employees B
WHERE A.manager_id = B.employee_id
ORDER BY A.employee_id;

SELECT department_id
FROM employees
UNION
SELECT department_id
FROM departments;

SELECT department_id
FROM employees
UNION ALL
SELECT department_id
FROM departments
ORDER BY department_id;

SELECT department_id
FROM employees
INTERSECT
SELECT department_id
FROM departments
ORDER BY department_id;

SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees;