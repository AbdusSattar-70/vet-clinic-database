/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR(200) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered bool,
    weight_kg decimal,
    PRIMARY KEY (id)
);

ALTER TABLE ANIMALS
ADD COLUMN SPECIES VARCHAR(100);


CREATE TABLE OWNERS (
ID INT GENERATED ALWAYS AS IDENTITY,
FULL_NAME VARCHAR(50),
AGE INT,
PRIMARY KEY(ID)
);

CREATE TABLE SPECIES (
ID INT GENERATED ALWAYS AS IDENTITY,
NAME VARCHAR(50),
PRIMARY KEY(ID)
);


ALTER TABLE ANIMALS DROP COLUMN SPECIES;

ALTER TABLE ANIMALS ADD COLUMN SPECIES_ID int;
ALTER TABLE ANIMALS ADD CONSTRAINT FK_SPECIES
FOREIGN KEY (SPECIES_ID) REFERENCES SPECIES(ID);


ALTER TABLE ANIMALS ADD COLUMN OWNER_ID int;
ALTER TABLE ANIMALS ADD CONSTRAINT FK_OWNERS
FOREIGN KEY (OWNER_ID) REFERENCES OWNERS(ID);

CREATE TABLE VETS (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(60),
	age INT,
	date_of_graduation DATE
);

CREATE TABLE SPECIALIZATIONS (
	ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    SPECIES_ID INT REFERENCES SPECIES(ID),
	VETS_ID INT REFERENCES VETS(ID)
);


CREATE TABLE VISITS (
	ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ANIMALS_ID INT REFERENCES ANIMALS (ID),
	VETS_ID INT REFERENCES VETS(ID),
    VISIT_DATE DATE
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';