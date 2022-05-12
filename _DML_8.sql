INSERT INTO departments ( department_id, department_name, manager_id, location_id)
VALUES (271, 'Sample_Dept', 200, 1700);

SELECT *
FROM departments;

INSERT INTO departments
VALUES (272, 'Sample_Dept', 200, 1700);

SELECT *
FROM departments;

--error
INSERT INTO departments
VALUES (272, Sample_Dept, 200, 1700);

UPDATE departments
SET manager_id = 201,
    location_id = 1800
WHERE department_name = 'Sample_Dept';

SELECT *
FROM departments;

UPDATE departments
SET (manager_id, location_id) = (
                                SELECT manager_id, location_id
                                FROM departments
                                WHERE department_id = 40
                                )
WHERE department_name = 'Sample_Dept';

SELECT *
FROM departments;

--error
UPDATE departments
SET department_id = null
WHERE department_name = 'Sample_Dept';

DELETE FROM departments
WHERE department_name = 'Sample_Dept';

DELETE FROM departments
WHERE department_name IN (SELECT department_id
                            FROM departments
                            WHERE department_name = 'Sample_Dept');