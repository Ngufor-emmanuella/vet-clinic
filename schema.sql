/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- add a column to the table
ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

-- project for multiple tables

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(60),
    PRIMARY KEY (id)
);

-- modifying table animals again
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT CONSTRAINT species_fk REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id INT CONSTRAINT owner_fk REFERENCES owners (id);

-- project for add join tables
CREATE TABLE vets (
    id  INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(70),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    vets_id INT REFERENCES vets (id),
    species_id INT REFERENCES species (id),
);

CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    visit_date date,
);

SELECT * FROM visits;

-- delete columns in specializations table
ALTER TABLE specializations DROP COLUMN species_id;
ALTER TABLE specializations DROP COLUMN vets_id;
ALTER TABLE specializations ADD COLUMN species_id INT REFERENCES vets (id);
ALTER TABLE specializations DROP COLUMN species_id;
SELECT * FROM specializations;
ALTER TABLE specializations ADD COLUMN vets_id INT REFERENCES vets (id);
ALTER TABLE specializations ADD COLUMN species_id INT REFERENCES species (id);
DROP TABLE specializations;
DROP TABLE visits;
-- go back to line 45 and 53 and add create tables all over respectively


-- to remove primary keys in specializations and visits tables
ALTER TABLE specializations DROP CONSTRAINT specializations_pkey;
-- the pkey above means primary key on specializations

ALTER TABLE visits DROP CONSTRAINT visits_pkey;


-- ADD A TABLE FOR TESTING AND INDEX PERFOMANCE
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- running explain analyse
explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;

-- prpject requirements;
SELECT COUNT(*) FROM visits where animals_id = 4;
SELECT * FROM visits where vets_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

-- Use EXPLAIN ANALYZE on the previous queries to check what is happening. Take screenshots of them -
-- before improve
EXPLAIN ANALYSE SELECT COUNT(*) FROM visits where animals_id = 4;
SELECT COUNT(*) FROM visits where animals_id = 4;

-- after improve
CREATE INDEX visits_animals_id ON visits(animals_id);
EXPLAIN ANALYSE SELECT COUNT(*) FROM visits WHERE animals_id = 4;

-- SELECT * FROM visits where vet_id = 2; Before improve
SELECT * FROM visits WHERE vets_id = 2;
explain analyse SELECT COUNT(*) FROM visits where animals_id = 2;

-- Querie : SELECT * FROM visits where vet_id = 2; After improve
CREATE INDEX visits_vets_id ON visits(vets_id);
EXPLAIN ANALYSE SELECT * FROM visits WHERE animals_id = 2;

-- Querie :SELECT * FROM owners where email = 'owner_18327@mail.com';
-- Before 
EXPLAIN ANALYSE SELECT * FROM owners WHERE email ='owner_18327@mail.com';
SELECT FROM owners WHERE email='owner_18327@mail.com';

-- after
CREATE INDEX owners_email ON owners(email);
EXPLAIN ANALYSE SELECT * FROM owners WHERE email ='owner_18327@mail.com';


-- changes asked by reviewer
explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;
