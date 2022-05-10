SELECT last_name,
    LOWER(last_name) LOWER적용,
    UPPER(last_name) UPPER적용,
    email,
    INITCAP(email) INITCAP적용
FROM employees;

SELECT job_id, SUBSTR(job_id, 1, 2) 적용결과
FROM employees;

SELECT job_id, REPLACE(job_id, 'ACCOUNT', 'ACCNT') 적용결과
FROM employees;

SELECT first_name, LPAD(first_name, 12, '*') LPAD적용결과
FROM employees;

SELECT job_id,
    LTRIM(job_id, 'F') LTRIM적용결과,
    RTRIM(job_id, 'T') RTRIM적용결과
FROM employees;

SELECT 'start'||TRIM('   - space -   ')||'end' 제거된_공백
FROM dual;

SELECT salary,
    salary/30 일급,
    ROUND(salary/30, 0) 적용결과0,
    ROUND(salary/30, 1) 적용결과1,
    ROUND(salary/30, -1) 적용결과MINUS1
FROM employees;

SELECT salary,
    salary/30 일급,
    TRUNC(salary/30, 0) 적용결과0,
    TRUNC(salary/30, 1) 적용결과1,
    TRUNC(salary/30, -1) 적용결과MINUS1
FROM employees;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD/HH24:MI') 오늘날짜,
    SYSDATE + 1 더하기1,
    SYSDATE -1 빼기1,
    TO_DATE('20171202')-TO_DATE('20171201') 날짜빼기,
    SYSDATE + 13/24 시간더하기
FROM DUAL;

SELECT SYSDATE, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date) 적용결과
FROM employees
WHERE department_id = 100;

SELECT hire_date,
    ADD_MONTHS(hire_date, 3) 더하기_적용결과,
    ADD_MONTHS(hire_date, -3) 빼기_적용결과
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT hire_date,
    NEXT_DAY(hire_date, '금요일') 적용결과_문자지정,
    NEXT_DAY(hire_date, 6) 적용결과_숫자지정
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT hire_date,
    LAST_DAY(hire_date) 적용결과
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT hire_date,
    ROUND(hire_date, 'MONTH') 적용결과_ROUND_M,
    ROUND(hire_date, 'YEAR') 적용결과_ROUND_Y,
    TRUNC(hire_date, 'MONTH') 적용결과_TRUNC_M,
    TRUNC(hire_date, 'YEAR') 적용결과_TRUNC_Y
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

SELECT 1 + '2'
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YY'),
    TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'MM'),
    TO_CHAR(SYSDATE, 'MON'),
    TO_CHAR(SYSDATE, 'YYYYMMDD') 응용적용1,
    TO_CHAR(TO_DATE(20171008), 'YYMMDD') 응용적용2
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS PM') 시간형식,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS PM') 날짜와시간조합
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH-MI-SS PM') 시간형식,
    TO_CHAR(SYSDATE, ' "날짜:" YYYY/MM/DD "시각:" HH:MI:SS PM') 날짜와시간조합
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
    salary 원래급여,
    DECODE(department_id, 60, salary*1.1, salary) 조정된급여,
    DECODE(department_id, 60, '10%인상', '미인상') 인상영부
FROM employees;

SELECT employee_id, first_name, last_name, salary,
    CASE
        WHEN salary >= 9000 THEN '상위급여'
        WHEN salary BETWEEN 6000 AND 8999 THEN '중위급여'
        ELSE '하위급여'
    END AS 급여등급
FROM employees
WHERE job_id = 'IT_PROG';

SELECT employee_id,
    salary,
    RANK() OVER(ORDER BY salary DESC) RANK_급여,
    DENSE_RANK() OVER(ORDER BY salary DESC) DENSE_RANK_급여,
    ROW_NUMBER() OVER(ORDER BY salary DESC) ROW_NUMBER_급여
FROM employees;

SELECT A.employee_id,
    A.department_id,
    B.department_name,
    salary,
    RANK() OVER(PARTITION BY A.department_id ORDER BY salary DESC) RANK_급여,
    DENSE_RANK() OVER(PARTITION BY A.department_id ORDER BY salary DESC) DENSE_RANK_급여,
    ROW_NUMBER() OVER(PARTITION BY A.department_id ORDER BY salary DESC) ROW_NUMBER_급여
FROM employees A, departments B
WHERE A.department_id = B.department_id
ORDER BY B.department_id, A.salary DESC;

SELECT COUNT(salary)
FROM employees;

SELECT SUM(salary) 합계, AVG(salary) 평균, SUM(salary)/COUNT(salary) 계산된평균
FROM employees;

SELECT MAX(salary), MIN(salary), MAX(first_name), MIN(first_name)
FROM employees;

SELECT job_id 직무, SUM(salary) 직무별_총급여, AVG(salary) 직무별_평균급여
FROM employees
WHERE employee_id >= 10
GROUP BY job_id
ORDER BY 직무별_총급여 DESC, 직무별_평균급여;

SELECT job_id job_id_대그룹,
    manager_id manager_id_중그룹,
    SUM(salary) 그룹핑_총급여,
    AVG(salary) 그룹핑_평균급여
FROM employees
WHERE employee_id >= 10
GROUP BY job_id, manager_id
ORDER BY 그룹핑_총급여 DESC, 그룹핑_평균급여;

SELECT job_id 직무, SUM(salary) 직무별_총급여, AVG(salary) 직무별_평균급여
FROM employees
WHERE employee_id >= 10
GROUP BY job_id
HAVING SUM(salary) > 30000
ORDER BY 직무별_총급여 DESC, 직무별_평균급여;