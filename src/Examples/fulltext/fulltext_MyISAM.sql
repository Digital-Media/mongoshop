#####################################
##                                 ##
## MyISAM                          ##
##                                 ##
#####################################

CREATE TABLE article (
idarticle BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100),
body LONGTEXT,
date_entered TIMESTAMP
) ENGINE=MyISAM;
Query OK, 0 rows affected (0.09 sec)

insert into article (title,body) values
 ('MariaDB Tutorial','DBMS stands for DataBase ...'),
 ('How To Use PostgreSQL Well','After you went through a ...'),
 ('Optimizing MariaDB','In this tutorial we will show ...'),
 ('1001 MariaDB Tricks','1. Never run mysqld as root ... '),
 ('SQLLite vs. MySQL','In the following database ...'),
 ('MariaDB Security','When configured properly, MariaDB ...');
Query OK, 6 rows affected (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 0

-- Es geht rascher den FULLTEXT-Index auf eine befüllte Tabelle aufzubauen, als Sätze in eine Tabelle mit bestehendem FULLTEXT-Index einzufügen.

-- Ein FULLTEXT Index kann auch über mehrere Spalten gehen. Es ist sinnvoll diesen auch über alle zu durchsuchenden Spalten auf einmal anzulegen.

CREATE FULLTEXT INDEX full_idx on article (title, body);
Query OK, 0 rows affected, 1 warning (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 1

-- Eine Volltextsuche ist case insensitive

select * from article where match (title, body) against ('database');
+-----------+-------------------+-------------------------------+---------------------+
| idarticle | title             | body                          | date_entered        |
+-----------+-------------------+-------------------------------+---------------------+
|         5 | SQLLite vs. MySQL | In the following database ... | 2017-11-17 14:23:35 |
|         1 | MariaDB Tutorial  | DBMS stands for DataBase ...  | 2017-11-17 14:23:35 |
+-----------+-------------------+-------------------------------+---------------------+
2 rows in set (0.00 sec)

-- Suchbegriffe werden durch Komma getrennt angegeben. Sätze höherer Relevanz werden nach oben sortiert

select * from article where match (title, body) against ('database, tutorial');
+-----------+--------------------+-----------------------------------+---------------------+
| idarticle | title              | body                              | date_entered        |
+-----------+--------------------+-----------------------------------+---------------------+
|         1 | MariaDB Tutorial   | DBMS stands for DataBase ...      | 2017-11-17 14:23:35 |
|         5 | SQLLite vs. MySQL  | In the following database ...     | 2017-11-17 14:23:35 |
|         3 | Optimizing MariaDB | In this tutorial we will show ... | 2017-11-17 14:23:35 |
+-----------+--------------------+-----------------------------------+---------------------+
3 rows in set (0.00 sec)

-- Reihenfolge umdrehen ist egal

select * from article where match (title, body) against ('tutorial, database');
+-----------+--------------------+-----------------------------------+---------------------+
| idarticle | title              | body                              | date_entered        |
+-----------+--------------------+-----------------------------------+---------------------+
|         1 | MariaDB Tutorial   | DBMS stands for DataBase ...      | 2017-11-17 14:23:35 |
|         5 | SQLLite vs. MySQL  | In the following database ...     | 2017-11-17 14:23:35 |
|         3 | Optimizing MariaDB | In this tutorial we will show ... | 2017-11-17 14:23:35 |
+-----------+--------------------+-----------------------------------+---------------------+
3 rows in set (0.00 sec)


select * from article where match (title, body) against ('...');
Empty set (0.00 sec)

select * from article where match (title, body) against ('in');
Empty set (0.00 sec)

select * from article where match (title,body) against ('database' IN NATURAL LANGUAGE MODE);
+-----------+---------------------+-------------------------------+---------------------+
| idarticle | title               | body                          | date_entered        |
+-----------+---------------------+-------------------------------+---------------------+
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...  | 2017-11-17 07:23:34 |
|         5 | MariaDB vs. YourSQL | In the following database ... | 2017-11-17 07:23:34 |
+-----------+---------------------+-------------------------------+---------------------+
2 rows in set (0.00 sec)

select * from article where match (title,body) against ('database' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);
+-----------+--------------------+-----------------------------------+---------------------+
| idarticle | title              | body                              | date_entered        |
+-----------+--------------------+-----------------------------------+---------------------+
|         1 | MariaDB Tutorial   | DBMS stands for DataBase ...      | 2017-11-17 14:23:35 |
|         5 | SQLLite vs. MySQL  | In the following database ...     | 2017-11-17 14:23:35 |
|         3 | Optimizing MariaDB | In this tutorial we will show ... | 2017-11-17 14:23:35 |
+-----------+--------------------+-----------------------------------+---------------------+
3 rows in set (0.00 sec)

select * from article where match (title,body) against ('mariadb' IN NATURAL LANGUAGE MODE);
Empty set (0.00 sec)

select * from article where match (title,body) against ('mariadb' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);
+-----------+---------------------+-----------------------------------+---------------------+
| idarticle | title               | body                              | date_entered        |
+-----------+---------------------+-----------------------------------+---------------------+
|         4 | 1001 MariaDB Tricks | 1. Never run mysqld as root ...   | 2017-11-17 14:23:35 |
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...      | 2017-11-17 14:23:35 |
|         3 | Optimizing MariaDB  | In this tutorial we will show ... | 2017-11-17 14:23:35 |
|         5 | SQLLite vs. MySQL   | In the following database ...     | 2017-11-17 14:23:35 |
+-----------+---------------------+-----------------------------------+---------------------+
4 rows in set (0.00 sec)

select * from article where match (title,body) against ('maria');
Empty set (0.00 sec)

select * from article where match (title,body) against ('maria*');
Empty set (0.00 sec)

select * from article where match (title,body) against ('maria*' in BOOLEAN MODE);
+-----------+---------------------+---------------------------------------+---------------------+
| idarticle | title               | body                                  | date_entered        |
+-----------+---------------------+---------------------------------------+---------------------+
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...          | 2017-11-17 14:23:35 |
|         3 | Optimizing MariaDB  | In this tutorial we will show ...     | 2017-11-17 14:23:35 |
|         4 | 1001 MariaDB Tricks | 1. Never run mysqld as root ...       | 2017-11-17 14:23:35 |
|         6 | MariaDB Security    | When configured properly, MariaDB ... | 2017-11-17 14:23:35 |
+-----------+---------------------+---------------------------------------+---------------------+
6 rows in set (0.00 sec)

DROP INDEX IF EXISTS full_idx on article;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

-- Ohne Index kommt nicht zu einem Full Table Scan sondern zu einer Fehlermeldung.

select * from article where match (title, body) against ('database');
ERROR 1191 (HY000): Can't find FULLTEXT index matching the column list

-- LIKE-Abfragen gehen trotzdem, da sie ohnehin keinen Index verwenden. Siehe explain.txt

select * from article where title like '%database%' or body like '%database%';
+-----------+---------------------+-------------------------------+---------------------+
| idarticle | title               | body                          | date_entered        |
+-----------+---------------------+-------------------------------+---------------------+
|         1 | MariaDB Tutorial    | DBMS stands for DataBase ...  | 2017-11-17 07:23:34 |
|         5 | MariaDB vs. YourSQL | In the following database ... | 2017-11-17 07:23:34 |
+-----------+---------------------+-------------------------------+---------------------+
2 rows in set (0.00 sec)