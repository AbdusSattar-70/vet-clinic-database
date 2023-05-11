/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name in ('Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN  10.4 AND 17.3;

BEGIN;
ALTER TABLE animals RENAME COLUMN SPECIES TO UNSPECIFIED;
SELECT * FROM ANIMALS;
ROLLBACK;
SELECT * FROM ANIMALS;

BEGIN;
UPDATE ANIMALS SET SPECIES = 'digimon' WHERE name LIKE '%mon';
UPDATE ANIMALS SET SPECIES = 'pokemon' WHERE SPECIES IS NULL;
COMMIT;
SELECT * FROM ANIMALS;

BEGIN;
DELETE FROM ANIMALS;
SELECT * FROM ANIMALS;
ROLLBACK;
SELECT * FROM ANIMALS;

BEGIN;
DELETE FROM ANIMALS WHERE date_of_birth > '2022-01-01';
SAVEPOINT SAVEPOIN_1;
UPDATE ANIMALS SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOIN_1;
UPDATE ANIMALS SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM ANIMALS;

SELECT COUNT(*) AS TOTAL_ANIMALS FROM ANIMALS;
SELECT COUNT (*) AS NEVER_ESCAPE FROM ANIMALS WHERE ESCAPE_ATTEMPTS = 0;
SELECT AVG(WEIGHT_KG) AS AVA_WEIGHT_KG FROM ANIMALS;
SELECT neutered, SUM(ESCAPE_ATTEMPTS) AS TOTAL_ESCAP_ATM FROM ANIMALS GROUP BY neutered;
SELECT SPECIES, MIN(WEIGHT_KG) AS MIN_WEIGHT_KG, MAX(WEIGHT_KG) AS MAX_WEIGHT_KG FROM ANIMALS GROUP BY SPECIES;
SELECT SPECIES, AVG(ESCAPE_ATTEMPTS) as AVG_ESCATM FROM ANIMALS WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY SPECIES;

SELECT NAME, FULL_NAME
FROM ANIMALS
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID
WHERE FULL_NAME = 'Melody Pond';

SELECT * FROM ANIMALS
JOIN SPECIES ON SPECIES.ID = ANIMALS.SPECIES_ID
WHERE SPECIES.NAME = 'Pokemon';

SELECT OWNERS.FULL_NAME, ANIMALS.NAME
FROM OWNERS
LEFT JOIN ANIMALS ON ANIMALS.OWNER_ID = OWNERS.ID;

SELECT  SPECIES.NAME, COUNT(ANIMALS.NAME) AS TOTAL
FROM ANIMALS
JOIN SPECIES ON ANIMALS.SPECIES_ID = SPECIES.ID
GROUP BY SPECIES.NAME;

SELECT SPECIES.NAME,
OWNERS.FULL_NAME,
ANIMALS.NAME
FROM SPECIES
JOIN ANIMALS ON ANIMALS.SPECIES_ID = SPECIES.ID
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID
WHERE SPECIES.NAME = 'Digimon'
AND OWNERS.FULL_NAME = 'Jennifer Orwell';

SELECT ANIMALS.NAME AS ANIMALS_NAME,
OWNERS.FULL_NAME
FROM ANIMALS
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID
WHERE OWNERS.FULL_NAME = 'Dean Winchester' AND ANIMALS.ESCAPE_ATTEMPTS = 0;

SELECT OWNERS.FULL_NAME, COUNT(*) AS MOST_ANIMALS
FROM ANIMALS
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID
GROUP BY FULL_NAME ORDER BY COUNT(*) DESC LIMIT 1;


SELECT ANIMALS.NAME AS ANIMAL_NAME, VETS.NAME AS VET_NAME, VISITS.VISIT_DATE
FROM ANIMALS, VETS, VISITS WHERE VETS.NAME = 'William Tatcher'
AND VETS.ID = VISITS.VETS_ID
AND ANIMALS.ID = VISITS.ANIMALS_ID ORDER BY VISIT_DATE DESC LIMIT 1;

SELECT VETS.NAME AS VET_NAME, COUNT(distinct animals.id) as total_visited_animals_by_animals_type FROM
VETS, VISITS, ANIMALS WHERE VETS.NAME = 'Stephanie Mendez'
AND VETS.ID = VISITS.VETS_ID
AND ANIMALS.ID = VISITS.ANIMALS_ID GROUP BY VET_NAME;

SELECT VETS.NAME AS VET_NAME, SPECIES.NAME AS SPECIALTIES
FROM VETS
LEFT JOIN SPECIALIZATIONS ON VETS.ID = SPECIALIZATIONS.VETS_ID
LEFT JOIN SPECIES ON SPECIES.ID = SPECIALIZATIONS.SPECIES_ID;

SELECT ANIMALS.NAME AS ANIMALS_NAME, VETS.NAME AS VET_NAME, VISITS.VISIT_DATE
FROM ANIMALS, VETS, VISITS WHERE VETS.NAME = 'Stephanie Mendez'
AND ANIMALS.ID = VISITS.ANIMALS_ID
AND VETS.ID = VISITS.VETS_ID
AND VISITS.VISIT_DATE BETWEEN '2020-04-01' AND '2020-08-30';

SELECT ANIMALS.NAME AS MOST_VISITED_ANIMAL_NAME, COUNT(VISITS.VISIT_DATE) AS TOTAL_VISITED
FROM ANIMALS, VISITS
WHERE ANIMALS.ID = VISITS.ANIMALS_ID
GROUP BY MOST_VISITED_ANIMAL_NAME
ORDER BY TOTAL_VISITED DESC LIMIT 1;

SELECT VETS.NAME AS VET_NAME, ANIMALS.NAME AS FIRST_VISITED_ANIMAL_NAME
FROM VETS, ANIMALS, VISITS
WHERE VETS.NAME = 'Maisy Smith'
AND VETS.ID = VISITS.VETS_ID
AND ANIMALS.ID = VISITS.ANIMALS_ID
ORDER BY VISITS.VISIT_DATE ASC LIMIT 1;

SELECT ANIMALS.NAME, ANIMALS.DATE_OF_BIRTH, ANIMALS.ESCAPE_ATTEMPTS, ANIMALS.NEUTERED,
ANIMALS.WEIGHT_KG, VETS.NAME AS VET_NAME, VETS.AGE AS VET_AGE, VETS.DATE_OF_GRADUATION,SPECIES.NAME AS SPECIES_NAME,
VISITS.VISIT_DATE FROM ANIMALS, SPECIES, VETS, VISITS
WHERE ANIMALS.ID = VISITS.ANIMALS_ID
AND VETS.ID = VISITS.VETS_ID
AND ANIMALS.SPECIES_ID = SPECIES.ID
ORDER BY VISITS.VISIT_DATE DESC LIMIT 1;

SELECT VETS.NAME AS VET_NAME,
COUNT(VISITS.VISIT_DATE) AS AMOUNT_OF_VISITS
FROM VETS, VISITS
WHERE VETS.ID = VISITS.VETS_ID
AND VETS.ID NOT IN (SELECT VETS_ID FROM SPECIALIZATIONS)
GROUP BY VET_NAME;

SELECT SPECIES.NAME AS MOST_VISITED_SPECIES,
COUNT(VISITS.VISIT_DATE) AS AMOUNT_OF_VISITS
FROM VETS, VISITS, SPECIES, ANIMALS
WHERE  VETS.NAME = 'Maisy Smith'
AND VETS.ID = VISITS.VETS_ID
AND SPECIES.ID = ANIMALS.SPECIES_ID
AND ANIMALS.ID = VISITS.ANIMALS_ID
GROUP BY VETS.NAME, MOST_VISITED_SPECIES
ORDER BY AMOUNT_OF_VISITS DESC LIMIT 1;



