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
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;

SELECT count(*), s.name FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;

SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id JOIN species s ON a.species_id = s.id WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE a.escape_attempts = 0 AND o.full_name = 'Dean Winchester';

SELECT combined.full_name FROM (SELECT o.full_name, COUNT (a.name) AS animal_number FROM owners o LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name) AS combined WHERE combined.animal_number = (SELECT MAX (animal_number)FROM (SELECT o.full_name,COUNT (a.name) AS
animal_number FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name) AS xx);


-- code for join tables

-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT animals.name AS last_animal_seen_by_William_Tatcher
FROM animals 
JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON visits.vets_id = vets.id 
WHERE vets.name='William Tatcher' 
ORDER BY visits.visit_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) AS no_of_different_animals_seen_by_Stephanie_Mendez  
FROM (SELECT DISTINCT animals.name FROM animals 
JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id 
WHERE vets.name='Stephanie Mendez') AS foo;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_names, species.name AS vet_specialities
FROM vets 
FULL JOIN specializations ON vets.id = specializations.vets_id FULL 
JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animals_that_visited_Stephanie_Mendez
FROM animals 
JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON visits.vets_id = vets.id 
WHERE vets.name='Stephanie Mendez' 
AND visits.visit_date > '2020-04-01' 
AND visits.visit_date <'2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS animal_with_most_visit_to_vets, COUNT(*)
FROM animals 
JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON visits.vets_id = vets.id 
GROUP BY animals.name 
ORDER BY count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name AS Maisy_Smith_first_visit
FROM animals 
JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON visits.vets_id = vets.id 
WHERE vets.name='Maisy Smith' 
ORDER BY visits.visit_date ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.*, visits.visit_date 
FROM animals 
JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON visits.vets_id = vets.id 
ORDER BY visits.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) 
FROM specializations
RIGHT JOIN vets ON specializations.vets_id = vets.id 
JOIN visits ON vets.id = visits.vets_id  
JOIN animals ON animals.id = visits.animals_id 
JOIN species ON animals.species_id = species.id 
WHERE specializations.species_id <> species.id OR specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(*) 
FROM vets 
JOIN visits ON vets.id = visits.vets_id 
JOIN animals ON animals.id = visits.animals_id 
JOIN species ON animals.species_id = species.id 
WHERE vets.name='Maisy Smith' 
GROUP BY species.name 
ORDER BY count DESC LIMIT 1;