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
    PRIMARY KEY (vets_id, species_id)
);

CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    visit_date date,
    PRIMARY KEY (animals_id, vets_id, visit_date)
);

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
-- go back to line 46 and 54 and add create tables all over respectively