SELECT last_name,
    LOWER(last_name) LOWER����,
    UPPER(last_name) UPPER����,
    email,
    INITCAP(email) INITCAP����
FROM employees;

SELECT job_id, SUBSTR(job_id, 1, 2) ������
FROM employees;

SELECT job_id, REPLACE(job_id, 'ACCOUNT', 'ACCNT') ������
FROM employees;

SELECT first_name, LPAD(first_name, 12, '*') LPAD������
FROM employees;

SELECT job_id,
    LTRIM(job_id, 'F') LTRIM������,
    RTRIM(job_id, 'T') RTRIM������
FROM employees;

SELECT 'start'||TRIM('   - space -   ')||'end' ���ŵ�_����
FROM dual;

SELECT salary,
    salary/30 �ϱ�,
    ROUND(salary/30, 0) ������0,
    ROUND(salary/30, 1) ������1,
    ROUND(salary/30, -1) ������MINUS1
FROM employees;

SELECT salary,
    salary/30 �ϱ�,
    TRUNC(salary/30, 0) ������0,
    TRUNC(salary/30, 1) ������1,
    TRUNC(salary/30, -1) ������MINUS1
FROM employees;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD/HH24:MI') ���ó�¥,
    SYSDATE + 1 ���ϱ�1,
    SYSDATE -1 ����1,
    TO_DATE('20171202')-TO_DATE('20171201') ��¥����,
    SYSDATE + 13/24 �ð����ϱ�
FROM DUAL;

SELECT SYSDATE, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date) ������
FROM employees
WHERE department_id = 100;

SELECT hire_date,
    ADD_MONTHS(hire_date, 3) ���ϱ�_������,
    ADD_MONTHS(hire_date, -3) ����_������
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT hire_date,
    NEXT_DAY(hire_date, '�ݿ���') ������_��������,
    NEXT_DAY(hire_date, 6) ������_��������
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT hire_date,
    LAST_DAY(hire_date) ������
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT hire_date,
    ROUND(hire_date, 'MONTH') ������_ROUND_M,
    ROUND(hire_date, 'YEAR') ������_ROUND_Y,
    TRUNC(hire_date, 'MONTH') ������_TRUNC_M,
    TRUNC(hire_date, 'YEAR') ������_TRUNC_Y
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT 1 + '2'
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YY'),
    TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'MM'),
    TO_CHAR(SYSDATE, 'MON'),
    TO_CHAR(SYSDATE, 'YYYYMMDD') ��������1,
    TO_CHAR(TO_DATE(20171008), 'YYMMDD') ��������2
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS PM') �ð�����,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS PM') ��¥�ͽð�����
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH-MI-SS PM') �ð�����,
    TO_CHAR(SYSDATE, ' "��¥:" YYYY/MM/DD "�ð�:" HH:MI:SS PM') ��¥�ͽð�����
FROM DUAL;

SELECT TO_NUMBER('123')
FROM DUAL;

SELECT TO_DATE('20171007', 'YYMMDD')
FROM DUAL;

SELECT *
FROM employees
ORDER BY commission_pct;

SELECT salary * NVL(commission_pct, 1)
FROM employees
ORDER BY commission_pct;

SELECT first_name,
    last_name,
    department_id,
    salary �����޿�,
    DECODE(department_id, 60, salary*1.1, salary) �����ȱ޿�,
    DECODE(department_id, 60, '10%�λ�', '���λ�') �λ󿵺�
FROM employees;

SELECT employee_id, first_name, last_name, salary,
    CASE
        WHEN salary >= 9000 THEN '�����޿�'
        WHEN salary BETWEEN 6000 AND 8999 THEN '�����޿�'
        ELSE '�����޿�'
    END AS �޿����
FROM employees
WHERE job_id = 'IT_PROG';

SELECT employee_id,
    salary,
    RANK() OVER(ORDER BY salary DESC) RANK_�޿�,
    DENSE_RANK() OVER(ORDER BY salary DESC) DENSE_RANK_�޿�,
    ROW_NUMBER() OVER(ORDER BY salary DESC) ROW_NUMBER_�޿�
FROM employees;

SELECT A.employee_id,
    A.department_id,
    B.department_name,
    salary,
    RANK() OVER(PARTITION BY A.department_id ORDER BY salary DESC) RANK_�޿�,
    DENSE_RANK() OVER(PARTITION BY A.department_id ORDER BY salary DESC) DENSE_RANK_�޿�,
    ROW_NUMBER() OVER(PARTITION BY A.department_id ORDER BY salary DESC) ROW_NUMBER_�޿�
FROM employees A, departments B
WHERE A.department_id = B.department_id
ORDER BY B.department_id, A.salary DESC;

SELECT COUNT(salary)
FROM employees;

SELECT SUM(salary) �հ�, AVG(salary) ���, SUM(salary)/COUNT(salary) �������
FROM employees;

SELECT MAX(salary), MIN(salary), MAX(first_name), MIN(first_name)
FROM employees;

SELECT job_id ����, SUM(salary) ������_�ѱ޿�, AVG(salary) ������_��ձ޿�
FROM employees
WHERE employee_id >= 10
GROUP BY job_id
ORDER BY ������_�ѱ޿� DESC, ������_��ձ޿�;

SELECT job_id job_id_��׷�,
    manager_id manager_id_�߱׷�,
    SUM(salary) �׷���_�ѱ޿�,
    AVG(salary) �׷���_��ձ޿�
FROM employees
WHERE employee_id >= 10
GROUP BY job_id, manager_id
ORDER BY �׷���_�ѱ޿� DESC, �׷���_��ձ޿�;

SELECT job_id ����, SUM(salary) ������_�ѱ޿�, AVG(salary) ������_��ձ޿�
FROM employees
WHERE employee_id >= 10
GROUP BY job_id
HAVING SUM(salary) > 30000
ORDER BY ������_�ѱ޿� DESC, ������_��ձ޿�;