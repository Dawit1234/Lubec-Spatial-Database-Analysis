-- ==========================================
-- LUBEC SPATIAL DATABASE ANALYSIS
-- PostgreSQL and PostGIS
-- ==========================================


-- QUESTION 1: Count distinct named  roads

SELECT COUNT(DISTINCT TRIM("RDNAME")) AS total_roads
FROM public."LubecRoads"
WHERE "RDNAME" IS NOT NULL
  AND TRIM("RDNAME") <> '';


-- QUESTION 2: Identify the shortest road

SELECT
    "RDNAME" AS road_name,
    ROUND(SUM("FEET")::numeric, 2) AS total_length_feet
FROM public."LubecRoads"
WHERE "RDNAME" IS NOT NULL
  AND TRIM("RDNAME") <> ''
  AND "FEET" IS NOT NULL
GROUP BY "RDNAME"
ORDER BY SUM("FEET") ASC
LIMIT 1;


-- QUESTION 3: Identify the largest parcel

SELECT
    "Parcel_ID",
    "Shape__Are" AS parcel_area
FROM public."LubecParcels"
WHERE "Shape__Are" IS NOT NULL
ORDER BY "Shape__Are" DESC
LIMIT 1;


-- QUESTION 4: Calculate average parcel area

SELECT
    ROUND(AVG("Shape__Are")::numeric, 2) AS average_parcel_area
FROM public."LubecParcels"
WHERE "Shape__Are" IS NOT NULL;


-- QUESTION 5: Find parcels intersecting the coastline

SELECT DISTINCT
    p."Parcel_ID"
FROM public."LubecParcels" AS p
JOIN public."LubecCoast" AS c
    ON ST_Intersects(p.geom, c.geom)
WHERE p."Parcel_ID" IS NOT NULL
ORDER BY p."Parcel_ID";