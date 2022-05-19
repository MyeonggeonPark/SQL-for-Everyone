@c:\sql_practice\create_table.sql;

@c:\sql_practice\1.address.sql;

@c:\sql_practice\2.customer.sql;

@c:\sql_practice\3.item.sql;

@c:\sql_practice\4.reservation.sql;

@c:\sql_practice\5.order_info.sql;

SELECT *
FROM order_info;

SELECT *
FROM reservation;

SELECT *
FROM item;

SELECT COUNT(*) 전체주문건,
        SUM(B.sales) 총매출,
        AVG(B.sales) 평균매출,
        MAX(B.sales) 최고매출,
        MIN(B.sales) 최저매출
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no;

SELECT COUNT(*) 총판매량,
        SUM(B.sales) 총매출,
        SUM(DECODE(B.item_id, 'M0001', 1, 0)) 전용상품판매랑,
        SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품매출
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND A.cancel = 'N';

SELECT C.item_id 상품아이디,
    C.product_name 상품이름,
    SUM(B.sales) 상품매출
FROM reservation A, order_info B, item C
WHERE A.reserv_no = B.reserv_no
AND B.item_id = C.item_id
AND A.cancel = 'N'
GROUP BY C.item_id, C.product_name
ORDER BY SUM(B.sales) DESC;

SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
    SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) SPECIAL_SET,
    SUM(DECODE(B.item_id, 'M0002', B.sales, 0)) PASTA,
    SUM(DECODE(B.item_id, 'M0003', B.sales, 0)) PIZZA,
    SUM(DECODE(B.item_id, 'M0004', B.sales, 0)) SEA_FOOD,
    SUM(DECODE(B.item_id, 'M0005', B.sales, 0)) STEAK,
    SUM(DECODE(B.item_id, 'M0006', B.sales, 0)) SALAD_BAR,
    SUM(DECODE(B.item_id, 'M0007', B.sales, 0)) SALAD,
    SUM(DECODE(B.item_id, 'M0008', B.sales, 0)) SANDWICH,
    SUM(DECODE(B.item_id, 'M0009', B.sales, 0)) WINE,
    SUM(DECODE(B.item_id, 'M0010', B.sales, 0)) JUICE
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND A.cancel = 'N'
GROUP BY SUBSTR(A.reserv_date, 1, 6)
ORDER BY SUBSTR(A.reserv_date, 1, 6);

SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
    SUM(B.sales) 총매출,
    SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품매출
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no
AND A.cancel = 'N'
GROUP BY SUBSTR(A.reserv_date, 1, 6)
ORDER BY SUBSTR(A.reserv_date, 1, 6);

SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
    SUM(B.sales) - SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품외매출,
    SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품매출,
    ROUND(SUM(DECODE(B.item_id, 'M0001', B.sales, 0))/SUM(B.sales)*100, 1) 매출기여율,
    COUNT(A.reserv_no) 총예약건,
    SUM(DECODE(A.cancel, 'N', 1, 0)) 예약완료건,
    SUM(DECODE(A.cancel, 'Y', 1, 0)) 예약취소건
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no(+)
--AND A.cancel = 'N'
GROUP BY SUBSTR(A.reserv_date, 1, 6)
ORDER BY SUBSTR(A.reserv_date, 1, 6);

SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
    SUM(B.sales) - SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품외매출,
    SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품매출,
    ROUND(SUM(DECODE(B.item_id, 'M0001', B.sales, 0))/SUM(B.sales)*100, 1)||'%' 전용상품판매율,
    COUNT(A.reserv_no) 총예약건,
    SUM(DECODE(A.cancel, 'N', 1, 0)) 예약완료건,
    SUM(DECODE(A.cancel, 'Y', 1, 0)) 예약취소건,
    ROUND(SUM(DECODE(A.cancel, 'Y', 1, 0))/COUNT(A.reserv_no)*100,1)||'%' 예약취소율
FROM reservation A, order_info B
WHERE A.reserv_no = B.reserv_no(+)
--AND A.cancel = 'N'
GROUP BY SUBSTR(A.reserv_date, 1, 6)
ORDER BY SUBSTR(A.reserv_date, 1, 6);

SELECT SUBSTR(A.reserv_date, 1, 6) 날짜,
    A.product_name 상품명,
    SUM(DECODE(A.WEEK, '1', A.sales, 0)) 일요일,
    SUM(DECODE(A.WEEK, '2', A.sales, 0)) 월요일,
    SUM(DECODE(A.WEEK, '3', A.sales, 0)) 화요일,
    SUM(DECODE(A.WEEK, '4', A.sales, 0)) 수요일,
    SUM(DECODE(A.WEEK, '5', A.sales, 0)) 목요일,
    SUM(DECODE(A.WEEK, '6', A.sales, 0)) 금요일,
    SUM(DECODE(A.WEEK, '7', A.sales, 0)) 토요일
FROM
    (
        SELECT A.reserv_date,
                C.product_name,
                TO_CHAR(TO_DATE(A.reserv_date, 'YYYYMMDD'), 'd') WEEK,
                B.sales
        FROM reservation A, order_info B, item C
        WHERE A.reserv_no = B.reserv_no
        AND B.item_id = C.item_id
        AND B.item_id = 'M0001'
    ) A
GROUP BY SUBSTR(reserv_date, 1, 6), A.product_name
ORDER BY SUBSTR(reserv_date, 1, 6);

SELECT *
    FROM
    (
        SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
            A.branch 지점,
            SUM(B.sales) 전용상품매출,
            RANK() OVER(PARTITION BY SUBSTR(A.reserv_date, 1, 6) ORDER BY SUM(B.sales) DESC) 지점순위
        FROM reservation A, order_info B
        WHERE A.reserv_no = B.reserv_no
        AND A.cancel = 'N'
        AND B.item_id = 'M0001'
        GROUP BY SUBSTR(A.reserv_date, 1, 6), A.branch
        ORDER BY SUBSTR(A.reserv_date, 1, 6)
    ) A
    WHERE A.지점순위 <= 3;
    
SELECT *
    FROM
    (
        SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
            A.branch 지점,
            SUM(B.sales) 전용상품매출,
            ROW_NUMBER() OVER(PARTITION BY SUBSTR(A.reserv_date, 1, 6) ORDER BY SUM(B.sales) DESC) 지점순위,
            DECODE(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B') 지점등급
        FROM reservation A, order_info B
        WHERE A.reserv_no = B.reserv_no
        AND A.cancel = 'N'
        AND B.item_id = 'M0001'
        GROUP BY SUBSTR(A.reserv_date, 1, 6), A.branch, DECODE(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')
        ORDER BY SUBSTR(A.reserv_date, 1, 6)
    ) A
    WHERE A.지점순위 = 1;
    -- AND 지점등급 = 'A';
    
SELECT A.매출월 매출월,
    MAX(총매출) 총매출,
    MAX(전용상품외매출) 전용상품외매출,
    MAX(전용상품매출) 전용상품매출,
    MAX(전용상품판매율) 전용상품판매율,
    MAX(총예약건) 총예약건,
    MAX(예약완료건) 예약완료건,
    MAX(예약취소건) 예약취소건,
    MAX(예약취소율) 예약취소율,
    MAX(최대매출지점) 최대매출지점,
    MAX(지점매출액) 지점매출액
FROM 
(
    SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
        SUM(B.sales) 총매출,
        SUM(B.saLes) - SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품외매출,
        SUM(DECODE(B.item_id, 'M0001', B.sales, 0)) 전용상품매출,
        ROUND(SUM(DECODE(B.item_id, 'M0001', B.sales, 0))/SUM(B.sales)*100, 1)||'%' 전용상품판매율,
        COUNT(A.reserv_no) 총예약건,
        SUM(DECODE(A.cancel, 'N', 1, 0)) 예약완료건,
        SUM(DECODE(A.cancel, 'Y', 1, 0)) 예약취소건,
        ROUND(SUM(DECODE(A.cancel, 'Y', 1, 0))/COUNT(A.reserv_no)*100, 1)||'%' 예약취소율,
        '' 최대매출지점,
        0 지점매출액
    FROM reservation A, order_info B
    WHERE A.reserv_no = B.reserv_no
    -- AND A.cancel ='N'
    GROUP BY SUBSTR(A.reserv_date, 1, 6), '', 0
UNION
    SELECT A.매출월,
        0 총매출,
        0 전용상품외매출,
        0 전용상품매출,
        '' 전용상품판매율,
        0 총예약건,
        0 예약완료건,
        0 예약취소건,
        '' 예약취소율,
        A.지점 최대매출지점,
        A.전용상품매출 지점매출액
    FROM
    (
        SELECT SUBSTR(A.reserv_date, 1, 6) 매출월,
            A.branch 지점,
            SUM(B.sales) 전용상품매출,
            ROW_NUMBER() OVER(PARTITION BY SUBSTR(A.reserv_date, 1, 6) ORDER BY SUM(B.sales) DESC) 지점순위,
            DECODE(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B') 지점등급
        FROM reservation A, order_info B
        WHERE A.reserv_no = B.reserv_no
        AND A.cancel = 'N'
        AND B.item_id = 'M0001'
        GROUP BY SUBSTR(A.reserv_date, 1, 6), A.branch, DECODE(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')
        ORDER BY SUBSTR(A.reserv_date, 1, 6)
    ) A
    WHERE A.지점순위 = 1
    -- AND 지검등급 = 'A'
) A
GROUP BY A.매출월
ORDER BY A.매출월;

SELECT *
FROM customer;

SELECT COUNT(customer_id)||'명' 고객수,
    SUM(DECODE(sex_code, 'M', 1, 0))||'명' 남자,
    SUM(DECODE(sex_code, 'F', 1, 0))||'명' 여자,
    ROUND(AVG(MONTHS_BETWEEN(TO_DATE('20171231', 'YYYYMMDD'), TO_DATE(birth, 'YYYYMMDD'))/12), 1)||'세' 평균나이,
    ROUND(AVG(MONTHS_BETWEEN(TO_DATE('20171231', 'YYYYMMDD'), first_reg_date)), 1)||'달' 평균거래기간
FROM customer;

SELECT A.customer_id 고객아이디,
    A.customer_name 고객이름,
    COUNT(C.order_no) 전체상품주문건수,
    SUM(C.sales) 총매출,
    SUM(DECODE(C.item_id, 'M0001', 1, 0)) 전용상품주문건수,
    SUM(DECODE(C.item_id, 'M0001', C.sales, 0)) 전용상품매출
FROM customer A, reservation B, order_info C
WHERE A.customer_id = B.customer_id
AND B.reserv_no = C.reserv_no
AND B.cancel = 'N'
GROUP BY A.customer_id, A.customer_name
ORDER BY SUM(DECODE(C.item_id, 'M0001', C.sales, 0)) DESC;

SELECT B.address_detail 주소, B.zip_code, COUNT(B.address_detail) 카운팅
FROM (
    SELECT DISTINCT A.customer_id, A.zip_code
    FROM customer A, reservation B, order_info C
    WHERE A.customer_id = B.customer_id
    AND B.reserv_no = C.reserv_no
    AND B.cancel = 'N'
    -- AND C.item_id = 'M0001'
) A, address B
WHERE A.zip_code = B.zip_code
GROUP BY B.address_detail, B.zip_code
ORDER BY COUNT(B.address_detail) DESC;

SELECT NVL(B.job, '정보없음') 직업, COUNT(NVL(B.job, 1)) 카운팅
FROM (
    SELECT DISTINCT A.customer_id, A.zip_code
    FROM customer A, reservation B, order_info C
    WHERE A.customer_id = B.customer_id
    AND B.reserv_no = C.reserv_no
    AND B.cancel = 'N'
    -- AND C.item_id = 'M0001'
    ) A, customer B
WHERE A.customer_id = B.customer_id
GROUP BY NVL(B.job, '정보없음')
ORDER BY COUNT(NVL(B.job, 1)) DESC;

SELECT *
FROM
(
    SELECT A.customer_id, A.customer_name,
        SUM(C.sales) 전용상품매출,
        ROW_NUMBER() OVER(PARTITION BY C.item_id ORDER BY SUM(C.sales) DESC) 순위
    FROM customer A, reservation B, order_info C
    WHERE A.customer_id = B.customer_id
    AND B.reserv_no = C.reserv_no
    AND B.cancel = 'N'
    AND C.item_id = 'M0001'
    GROUP BY A.customer_id, C.item_id, A.customer_name
) A
WHERE A.순위 <= 10
ORDER BY A.순위;

SELECT A.주소, COUNT(A.주소) 카운팅
FROM
(
    SELECT A.customer_id 고객아이디,
        A.customer_name 고객이름,
        NVL(A.job, '정보없음') 직업,
        D.address_detail 주소,
        SUM(C.sales) 전용상품_매출,
        RANK() OVER(PARTITION BY C.item_id ORDER BY SUM(C.sales) DESC) 순위
    FROM customer A, reservation B, order_info C, address D
    WHERE A.customer_id = B.customer_id
    AND B.reserv_no = C.reserv_no
    AND A.zip_code = D.zip_code
    AND B.cancel = 'N'
    AND C.item_id = 'M0001'
    GROUP BY A.customer_id, C.item_id, A.customer_name, NVL(A.job, '정보없음'), D.address_detail
) A
WHERE A.순위 <= 10
GROUP BY A.주소
ORDER BY COUNT(A.주소) DESC;

SELECT A.직업, COUNT(A.직업) 카운팅
FROM
(
    SELECT A.customer_id 고객아이디,
        A.customer_name 고객이름,
        NVL(A.job, '정보없음') 직업,
        D.address_detail 주소,
        SUM(C.sales) 전용상품_매출,
        RANK() OVER(PARTITION BY C.item_id ORDER BY SUM(C.sales) DESC) 순위
    FROM customer A, reservation B, order_info C, address D
    WHERE A.customer_id = B.customer_id
    AND B.reserv_no = C.reserv_no
    AND A.zip_code = D.zip_code
    AND B.cancel = 'N'
    AND C.item_id = 'M0001'
    GROUP BY A.customer_id, C.item_id, A.customer_name, NVL(A.job, '정보없음'), D.address_detail
) A
WHERE A.순위 <= 10
GROUP BY A.직업
ORDER BY COUNT(A.직업) DESC;

SELECT *
FROM
(
    SELECT A.고객아이디,
        A.고객이름,
        D.product_name 상품명,
        SUM(C.sales) 상품매출,
        RANK() OVER(PARTITION BY A.고객아이디 ORDER BY SUM(C.sales) DESC) 선호도순위
    FROM
    (
        SELECT A.customer_id 고객아이디,
            A.customer_name 고객이름,
            SUM(C.sales) 전용상품_매출
        FROM customer A, reservation B, order_info C
        WHERE A.customer_id = B.customer_id
        AND B.reserv_no = C.reserv_no
        AND B.cancel = 'N'
        AND C.item_id = 'M0001'
        GROUP BY A.customer_id, A.customer_name
        HAVING SUM(C.sales) >= 216000
    ) A, reservation B, order_info C, item D
    WHERE A.고객아이디 = B.customer_id
    AND B.reserv_no = C.reserv_no
    AND C.item_id = D.item_id
    AND C.item_id <> 'M0001'
    AND B.cancel = 'N'
    GROUP BY A.고객아이디, A.고객이름, D.product_name
) A
WHERE A.선호도순위 = 1;