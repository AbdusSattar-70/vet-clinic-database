/* Populate database with sample data. */

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
 ('Gabumon','2018-11-15',2,true,8 ),
 ('Pikachu','2021-01-07',1,false,15.04 ),
 ('Devimon','2017-05-12',5,true,11 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, -11),
('Plantmon','2021-11-15',2,true,-5.7),
('Squirtle','1993-04-02',3,false,-12.13),
('Angemon','2005-06-12',1,true,-45),
('Boarmon','2005-06-07',7,true,20.4),
('Blossom','1998-10-13',3,true,17),
('Ditto','2022-05-14',4,true,22);

INSERT INTO OWNERS (FULL_NAME,AGE)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38 );

INSERT INTO SPECIES (NAME) VALUES('Pokemon'),
('Digimon');


UPDATE ANIMALS SET SPECIES_ID = 2 WHERE NAME like '%mon';
UPDATE ANIMALS SET SPECIES_ID = 1 WHERE NAME NOT like '%mon';

BEGIN;
UPDATE ANIMALS SET OWNERS_ID = 1 WHERE NAME IN ('Agumon');
UPDATE ANIMALS SET OWNERS_ID = 2 WHERE NAME IN ('Gabumon', 'Pikachu');
UPDATE ANIMALS SET OWNERS_ID = 3 WHERE NAME IN ('Devimon', 'Plantmon');
UPDATE ANIMALS SET OWNERS_ID = 4 WHERE NAME IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE ANIMALS SET OWNER_ID = OWNERS.ID
FROM OWNERS
WHERE (ANIMALS.NAME = 'Angemon' OR ANIMALS.NAME = 'Boarmon')
AND (OWNERS.FULL_NAME = 'Dean Winchester');
COMMIT;
