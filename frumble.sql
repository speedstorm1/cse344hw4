-- part a
CREATE TABLE SALES (
    name varchar(10),
    discount varchar(5),
    month varchar(3),
    price int
);

-- data import:
-- .mode csv
-- .import frumbledata.csv Sales
-- delete from sales where month = 'month'; (get rid of unnecessary header)

-- part b

-- fd query for name -> price
SELECT name, COUNT(DISTINCT price)
FROM SALES
GROUP BY name
HAVING COUNT(DISTINCT price) > 1;

-- fd query for month -> discount
SELECT month, COUNT(DISTINCT discount)
FROM SALES
GROUP BY month
HAVING COUNT(DISTINCT discount) > 1;

-- non-fd query showing that there is no fd between name to discount
SELECT name, COUNT(DISTINCT discount)
FROM SALES
GROUP BY name
HAVING COUNT(DISTINCT discount) > 1;


-- part c

CREATE TABLE SALES1 (
    name varchar(10),
    month varchar(3)
);

CREATE TABLE SALES2 (
    name varchar(10), 
    price int,
    FOREIGN KEY (name) REFERENCES SALES1(name)
);

CREATE TABLE SALES3 (
    month varchar(3), 
    discount varchar(5),
    FOREIGN KEY (month) REFERENCES SALES1(month)
);

-- part d

INSERT INTO SALES1 
SELECT name, month
FROM SALES;
-- size of sales1: 427

INSERT INTO SALES2
SELECT distinct name,price
FROM SALES;
-- size of sales2: 37

INSERT INTO SALES3
SELECT distinct month, discount
FROM SALES;
-- size of sales3: 12

