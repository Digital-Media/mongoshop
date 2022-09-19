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