/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';
SELECT * FROM animals WHERE neutered=true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> ' Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- update tables with transactions
BEGIN TRANSACTION;
UPDATE animals
SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;


-- update table in a transaction
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species FROM animals;
COMMIT;
SELECT species FROM animals;

-- delete transaction in the table and roll back;
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT one;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO SAVEPOINT one;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;

-- WRITE COMMITPOINTQUERIES FOR QUESTIONS

SELECT COUNT(name) AS total_animals FROM animals; 
SELECT name, SUM(escape_attempts) FROM animals GROUP BY name having MIN(escape_attempts) < 1;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- project for multiple table relation
SELECT n.name FROM animals n JOIN owners w ON n.owner_id = w.id WHERE w.full_name = 'Melody Pond';

SELECT n.name FROM animals n JOIN species s ON n.species_id = s.id WHERE s.name = 'Pokemon';

SELECT n.full_name, n.name FROM owners w LEFT JOIN animals a ON w.id = n.owner_id;

SELECT count(*), s.name FROM animals n JOIN species s ON n.species_id = s.id GROUP BY s.name;

SELECT n.name FROM animals n JOIN owners w ON n.owner_id = w.id JOIN species s ON n.species_id = s.id WHERE s.name = 'Digimon' AND w.full_name = 'Jennifer Orwell';

SELECT n.name FROM animals n JOIN owners w ON n.owner_id = w.id WHERE n.escape_attempts = 0 AND w.full_name = 'Dean Winchester';

SELECT combined.full_name FROM (SELECT w.full_name, COUNT (n.name) AS animal_number FROM owners w LEFT JOIN animals n ON w.id = n.owner_id
GROUP BY w.full_name) AS combined WHERE combined.animal_number = (SELECT MAX (animal_number)FROM (SELECT w.full_name,COUNT (n.name) AS
animal_number FROM owners w LEFT JOIN animals n ON w.id = n.owner_id GROUP BY w.full_name) AS xx);
