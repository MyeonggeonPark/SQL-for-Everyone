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

SELECT employee_id AS �����ȣ, first_name AS �̸�, last_name AS ��
FROM employees;

SELECT employee_id, first_name||last_name
FROM employees;

SELECT employee_id,
    first_name||' '||last_name,
    email||'@'||'company.com'
FROM employees;

SELECT employee_id, salary, salary+500, salary-100, (salary*1.1)/2
FROM employees;

SELECT employee_id AS �����ȣ,
    salary AS �޿�,
    salary+500 AS �߰��޿�,
    salary-100 AS ���ϱ޿�,
    (salary*1.1)/2 AS �����޿�
FROM employees;