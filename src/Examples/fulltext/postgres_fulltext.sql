CREATE TABLE public."restaurant"
(
    "id" bigint,
    "name" varchar(255),
    "menu" tsvector,
    "search_tags" tsvector
);

INSERT INTO public."restaurant"
("id",
 "name",
 "menu",
 "search_tags")
VALUES
    (1,
     'My favorite restaurant',
     to_tsvector('Very long list of tasty food and drinks ....'),
     to_tsvector('no-smoking, vegetarian, vegan, wifi'));

CREATE INDEX "FT_menu_tags"
    ON public."restaurant" USING GIN (
    ("menu"),
    ("search_tags")
    );

SELECT
    "id",
    "name",
    "menu",
    "search_tags"
FROM public."restaurant"
WHERE "menu" @@ to_tsquery('english', 'burger|special')
   OR "search_tags" @@ to_tsquery('english', 'vegan|wifi');

explain SELECT
            "id",
            "name",
            "menu",
            "search_tags"
        FROM public."restaurant"
        WHERE "menu" @@ to_tsquery('english', 'burger|special')
           OR "search_tags" @@ to_tsquery('english', 'vegan|wifi');

-- QUERY PLAN
-- Seq Scan on restaurant  (cost=0.00..1.01 rows=1 width=588)
--  Filter: ((menu @@ '''burger'' | ''special'''::tsquery) OR (search_tags @@ '''vegan'' | ''wifi'''::tsquery))

CREATE TABLE public."restaurantlike"
(
    "id" bigint,
    "name" varchar(255),
    "menu" text,
    "search_tags" text
);

INSERT INTO public."restaurantlike"
("id",
 "name",
 "menu",
 "search_tags")
VALUES
    (1,
     'My favorite restaurant',
     to_tsvector('Very long list of tasty food and drinks ....'),
     to_tsvector('no-smoking, vegetarian, vegan, wifi'));

CREATE INDEX "menu_tags_like"
    ON public."restaurantlike" USING BTREE ("menu", "search_tags");

SELECT
    "id",
    "name",
    "menu",
    "search_tags"
FROM public."restaurantlike"
WHERE "menu" LIKE '%burger%'
   OR "menu" LIKE '%special%'
   OR ("search_tags" LIKE '%vegan%' AND "search_tags" LIKE '%wifi%');

-- QUERY PLAN
-- Seq Scan on restaurantlike  (cost=0.00..1.02 rows=1 width=588)
--  Filter: ((menu ~~ '%burger%'::text) OR (menu ~~ '%special%'::text) OR ((search_tags ~~ '%vegan%'::text) AND (search_tags ~~ '%wifi%'::text)))