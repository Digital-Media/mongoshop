#####################################
##                                 ##
## InnoDB                          ##
##                                 ##
#####################################


CREATE TABLE article (
    idarticle BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    body LONGTEXT,
    date_entered TIMESTAMP
    ) ENGINE=InnoDB;
Query OK, 0 rows affected (0.02 sec)

insert into article (title,body) values
    ('MariaDB Tutorial','DBMS stands for DataBase ...'),
    ('How To Use PostgreSQL Well','After you went through a ...'),
    ('Optimizing MariaDB','In this tutorial we will show ...'),
    ('1001 MariaDB Tricks','1. Never run mysqld as root ... '),
    ('SQLLite vs. MySQL','In the following database ...'),
    ('MariaDB Security','When configured properly, MariaDB ...');
Query OK, 6 rows affected (0.00 sec)
Records: 6  Duplicates: 0  Warnings: 0

CREATE FULLTEXT INDEX full_idx on article (title, body);
Query OK, 0 rows affected, 1 warning (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 1

select * from article where match (title, body) against ('database');
+-----------+-------------------+-------------------------------+---------------------+
| idarticle | title             | body                          | date_entered        |
+-----------+-------------------+-------------------------------+---------------------+
|         1 | MariaDB Tutorial  | DBMS stands for DataBase ...  | 2017-11-17 14:40:10 |
|         5 | SQLLite vs. MySQL | In the following database ... | 2017-11-17 14:40:10 |
+-----------+-------------------+-------------------------------+---------------------+
2 rows in set (0.00 sec)

select * from article where match (title, body) against ('database, tutorial');
+-----------+--------------------+-----------------------------------+---------------------+
| idarticle | title              | body                              | date_entered        |
+-----------+--------------------+-----------------------------------+---------------------+
|         1 | MariaDB Tutorial   | DBMS stands for DataBase ...      | 2017-11-17 14:40:10 |
|         3 | Optimizing MariaDB | In this tutorial we will show ... | 2017-11-17 14:40:10 |
|         5 | SQLLite vs. MySQL  | In the following database ...     | 2017-11-17 14:40:10 |
+-----------+--------------------+-----------------------------------+---------------------+
3 rows in set (0.00 sec)

select * from article where match (title, body) against ('tutorial, database');
+-----------+--------------------+-----------------------------------+---------------------+
| idarticle | title              | body                              | date_entered        |
+-----------+--------------------+-----------------------------------+---------------------+
|         1 | MariaDB Tutorial   | DBMS stands for DataBase ...      | 2017-11-17 14:40:10 |
|         3 | Optimizing MariaDB | In this tutorial we will show ... | 2017-11-17 14:40:10 |
|         5 | SQLLite vs. MySQL  | In the following database ...     | 2017-11-17 14:40:10 |
+-----------+--------------------+-----------------------------------+---------------------+
3 rows in set (0.00 sec)

select * from article where match (title, body) against ('...');
Empty set (0.00 sec)

select * from article where match (title, body) against ('in');
Empty set (0.00 sec)

select * from article where match (title,body) against ('database' IN NATURAL LANGUAGE MODE);
+-----------+-------------------+-------------------------------+---------------------+
| idarticle | title             | body                          | date_entered        |
+-----------+-------------------+-------------------------------+---------------------+
|         1 | MariaDB Tutorial  | DBMS stands for DataBase ...  | 2017-11-17 14:40:10 |
|         5 | SQLLite vs. MySQL | In the following database ... | 2017-11-17 14:40:10 |
+-----------+-------------------+-------------------------------+---------------------+
2 rows in set (0.00 sec)

select * from article where match (title,body) against ('database' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);
+-----------+---------------------+---------------------------------------+---------------------+
| idarticle | title               | body                                  | date_entered        |
+-----------+---------------------+---------------------------------------+---------------------+
|         5 | SQLLite vs. MySQL   | In the following database ...         | 2017-11-17 14:40:10 |
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...          | 2017-11-17 14:40:10 |
|         3 | Optimizing MariaDB  | In this tutorial we will show ...     | 2017-11-17 14:40:10 |
|         6 | MariaDB Security    | When configured properly, MariaDB ... | 2017-11-17 14:40:10 |
|         4 | 1001 MariaDB Tricks | 1. Never run mysqld as root ...       | 2017-11-17 14:40:10 |
+-----------+---------------------+---------------------------------------+---------------------+
5 rows in set (0.00 sec)

select * from article where match (title,body) against ('mariadb' IN NATURAL LANGUAGE MODE);
+-----------+---------------------+---------------------------------------+---------------------+
| idarticle | title               | body                                  | date_entered        |
+-----------+---------------------+---------------------------------------+---------------------+
|         6 | MariaDB Security    | When configured properly, MariaDB ... | 2017-11-17 14:40:10 |
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...          | 2017-11-17 14:40:10 |
|         3 | Optimizing MariaDB  | In this tutorial we will show ...     | 2017-11-17 14:40:10 |
|         4 | 1001 MariaDB Tricks | 1. Never run mysqld as root ...       | 2017-11-17 14:40:10 |
+-----------+---------------------+---------------------------------------+---------------------+
4 rows in set (0.00 sec)

select * from article where match (title,body) against ('mariadb' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);
+-----------+---------------------+---------------------------------------+---------------------+
| idarticle | title               | body                                  | date_entered        |
+-----------+---------------------+---------------------------------------+---------------------+
|         4 | 1001 MariaDB Tricks | 1. Never run mysqld as root ...       | 2017-11-17 14:40:10 |
|         6 | MariaDB Security    | When configured properly, MariaDB ... | 2017-11-17 14:40:10 |
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...          | 2017-11-17 14:40:10 |
|         3 | Optimizing MariaDB  | In this tutorial we will show ...     | 2017-11-17 14:40:10 |
|         5 | SQLLite vs. MySQL   | In the following database ...         | 2017-11-17 14:40:10 |
+-----------+---------------------+---------------------------------------+---------------------+
5 rows in set (0.00 sec)

select * from article where match (title,body) against ('maria');
Empty set (0.00 sec)

select * from article where match (title,body) against ('maria*');
Empty set (0.00 sec)

select * from article where match (title,body) against ('maria*' in BOOLEAN MODE);
+-----------+---------------------+---------------------------------------+---------------------+
| idarticle | title               | body                                  | date_entered        |
+-----------+---------------------+---------------------------------------+---------------------+
|         6 | MariaDB Security    | When configured properly, MariaDB ... | 2017-11-17 14:40:10 |
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...          | 2017-11-17 14:40:10 |
|         3 | Optimizing MariaDB  | In this tutorial we will show ...     | 2017-11-17 14:40:10 |
|         4 | 1001 MariaDB Tricks | 1. Never run mysqld as root ...       | 2017-11-17 14:40:10 |
+-----------+---------------------+---------------------------------------+---------------------+
4 rows in set (0.00 sec)

DROP INDEX IF EXISTS full_idx on article;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

select * from article where match (title, body) against ('database');
ERROR 1191 (HY000): Can't find FULLTEXT index matching the column list

select * from article where title like '%database%' or body like '%database%';
+-----------+-------------------+-------------------------------+---------------------+
| idarticle | title             | body                          | date_entered        |
+-----------+-------------------+-------------------------------+---------------------+
|         1 | MariaDB Tutorial  | DBMS stands for DataBase ...  | 2017-11-17 14:40:10 |
|         5 | SQLLite vs. MySQL | In the following database ... | 2017-11-17 14:40:10 |
+-----------+-------------------+-------------------------------+---------------------+
2 rows in set (0.00 sec)