SELECT *
FROM employees;

SELECT employee_id, first_name, last_name
FROM employees;

SELECT employee_id, first_name, last_name
FROM employees
ORDER BY employee_id DESC;

SELECT job_id
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT employee_id AS 사원번호, first_name AS 이름, last_name AS 성
FROM employees;

SELECT employee_id, first_name||last_name
FROM employees;

SELECT employee_id,
    first_name||' '||last_name,
    email||'@'||'company.com'
FROM employees;

SELECT employee_id, salary, salary+500, salary-100, (salary*1.1)/2
FROM employees;

SELECT employee_id AS 사원번호,
    salary AS 급여,
    salary+500 AS 추가급여,
    salary-100 AS 인하급여,
    (salary*1.1)/2 AS 조정급여
FROM employees;