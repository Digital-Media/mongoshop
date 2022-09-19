vagrant@vagrant:~$ sudo mysql -uroot
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 32
Server version: 10.0.31-MariaDB-0ubuntu0.16.04.2 Ubuntu 16.04

Copyright (c) 2000, 2017, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| onlineshop         |
| performance_schema |
| phpmyadmin         |
+--------------------+
5 rows in set (0.00 sec)

MariaDB [(none)]> create database test;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> use test;
Database changed
MariaDB [test]> CREATE TABLE table1 (
    ->      a INT NOT NULL,
    ->      b VARCHAR(32),
    ->      c INT AS (a mod 10) VIRTUAL,
    ->      d VARCHAR(5) AS (left(b,5)) PERSISTENT);
Query OK, 0 rows affected (0.04 sec)

MariaDB [test]> show tables;
+----------------+
| Tables_in_test |
+----------------+
| table1         |
+----------------+
1 row in set (0.00 sec)

MariaDB [test]> create index b_idx on table1(b);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [test]> describe table1;
+-------+-------------+------+-----+---------+------------+
| Field | Type        | Null | Key | Default | Extra      |
+-------+-------------+------+-----+---------+------------+
| a     | int(11)     | NO   |     | NULL    |            |
| b     | varchar(32) | YES  | MUL | NULL    |            |
| c     | int(11)     | YES  |     | NULL    | VIRTUAL    |
| d     | varchar(5)  | YES  |     | NULL    | PERSISTENT |
+-------+-------------+------+-----+---------+------------+
4 rows in set (0.00 sec)


MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.01 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.01 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.00 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.01 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.01 sec)

MariaDB [test]> insert into table1 (b) values ('abcdefghijklmnopqrstuvwxyz');
Query OK, 1 row affected, 1 warning (0.01 sec)

MariaDB [test]> SELECT * FROM table1  WHERE LEFT(b,5)='abcde';
+---+----------------------------+------+-------+
| a | b                          | c    | d     |
+---+----------------------------+------+-------+
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
+---+----------------------------+------+-------+
13 rows in set (0.00 sec)

MariaDB [test]> explain SELECT * FROM table1  WHERE LEFT(b,5)='abcde';
+------+-------------+--------+------+---------------+------+---------+------+------+-------------+
| id   | select_type | table  | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+------+-------------+--------+------+---------------+------+---------+------+------+-------------+
|    1 | SIMPLE      | table1 | ALL  | NULL          | NULL | NULL    | NULL |   13 | Using where |
+------+-------------+--------+------+---------------+------+---------+------+------+-------------+
1 row in set (0.00 sec)MariaDB [test]> create index d_idx on table1(d);
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [test]> SELECT * FROM table1  WHERE d='abcde';
+---+----------------------------+------+-------+
| a | b                          | c    | d     |
+---+----------------------------+------+-------+
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
| 0 | abcdefghijklmnopqrstuvwxyz |    0 | abcde |
+---+----------------------------+------+-------+
13 rows in set (0.00 sec)

MariaDB [test]> explain SELECT * FROM table1  WHERE d='abcde';
+------+-------------+--------+------+---------------+------+---------+------+------+-------------+
| id   | select_type | table  | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+------+-------------+--------+------+---------------+------+---------+------+------+-------------+
|    1 | SIMPLE      | table1 | ALL  | d_idx         | NULL | NULL    | NULL |   13 | Using where |
+------+-------------+--------+------+---------------+------+---------+------+------+-------------+
1 row in set (0.00 sec)

MariaDB [test]> 

Examples from mariadb.com

EXPLAIN FORMAT=JSON SELECT * FROM t1 WHERE col1=1\G

*************************** 1. row ***************************
EXPLAIN: {
  "query_block": {
    "select_id": 1,
    "table": {
      "table_name": "t1",
      "access_type": "ALL",
      "rows": 1000,
      "filtered": 100,
      "attached_condition": "(t1.col1 = 1)"
    }
  }
}

Output is different from MySQL

ANALYZE SELECT *
FROM orders, customer 
WHERE
  customer.c_custkey=orders.o_custkey AND
  customer.c_acctbal < 0 AND
  orders.o_totalprice > 200*1000

+----+-------------+----------+------+---------------+-------------+---------+--------------------+--------+--------+----------+------------+-------------+
| id | select_type | table    | type | possible_keys | key         | key_len | ref                | rows   | r_rows | filtered | r_filtered | Extra       |
+----+-------------+----------+------+---------------+-------------+---------+--------------------+--------+--------+----------+------------+-------------+
|  1 | SIMPLE      | customer | ALL  | PRIMARY,...   | NULL        | NULL    | NULL               | 149095 | 150000 |    18.08 |       9.13 | Using where |
|  1 | SIMPLE      | orders   | ref  | i_o_custkey   | i_o_custkey | 5       | customer.c_custkey |      7 |     10 |   100.00 |      30.03 | Using where |
+----+-------------+----------+------+---------------+-------------+---------+--------------------+--------+--------+----------+------------+-------------+


ANALYZE FORMAT=JSON
SELECT CONT(*)
FROM customer
WHERE
  (SELECT SUM(o_totalprice) FROM orders WHERE o_custkey=c_custkey) > 1000*1000;

The query takes 40 seconds over cold cache

EXPLAIN: {
  "query_block": {
    "select_id": 1,
    "r_loops": 1,
    "r_total_time_ms": 39872,
    "table": {
      "table_name": "customer",
      "access_type": "index",
      "key": "i_c_nationkey",
      "key_length": "5",
      "used_key_parts": ["c_nationkey"],
      "r_loops": 1,
      "rows": 150303,
      "r_rows": 150000,
      "r_total_time_ms": 270.3,
      "filtered": 100,
      "r_filtered": 60.691,
      "attached_condition": "((subquery#2) > <cache>((1000 * 1000)))",
      "using_index": true
    },
    "subqueries": [
      {
        "query_block": {
          "select_id": 2,
          "r_loops": 150000,
          "r_total_time_ms": 39531,
          "table": {
            "table_name": "orders",
            "access_type": "ref",
            "possible_keys": ["i_o_custkey"],
            "key": "i_o_custkey",
            "key_length": "5",
            "used_key_parts": ["o_custkey"],
            "ref": ["dbt3sf1.customer.c_custkey"],
            "r_loops": 150000,
            "rows": 7,
            "r_rows": 10,
            "r_total_time_ms": 39208,
            "filtered": 100,
            "r_filtered": 100
          }
        }
      }
    ]
  }
}

ANALYZE shows that 39.2 seconds were spent in the subquery, which was executed 150K times (for every row of outer table).

DROP TABLE restaurantlike;
CREATE TABLE restaurantlike
(
    id bigint,
    name varchar(255),
    menu varchar(255),
    search_tags varchar(255)
);

INSERT INTO restaurantlike
(id,
 name,
 menu,
 search_tags)
VALUES
    (1,
     'My favorite restaurant',
     'Very long list of tasty food and drinks ....',
     'no-smoking, vegetarian, vegan, wifi');

CREATE INDEX menu_tags_like
    ON restaurantlike (menu, search_tags);

SELECT
    id,
    name,
    menu,
    search_tags
FROM restaurantlike
WHERE menu LIKE '%burger%'
   OR menu LIKE '%special%'
   OR (search_tags LIKE '%vegan%' AND search_tags LIKE '%wifi%');

EXPLAIN SELECT
              id,
              name,
              menu,
              search_tags
        FROM restaurantlike
        WHERE menu LIKE '%burger%'
           OR menu LIKE '%special%'
           OR (search_tags LIKE '%vegan%' AND search_tags LIKE '%wifi%');


-- Result:
-- id  select_type table           type possible_keys key  key_len ref     rows Extra
-- 1   SIMPLE	   restaurantlike  ALL	NULL	      NULL NULL	   NULL	   1    Using where




































