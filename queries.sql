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
