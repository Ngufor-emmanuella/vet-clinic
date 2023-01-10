/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', date '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (' Gabumon', date '2018-11-15', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', date '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', date '2017-05-12', 5, true, 11);

-- adding new data
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', date '2020-02-08', 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', date '2021-11-15', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', date '1993-04-02', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', date '2005-06-12', 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', date '2005-06-07', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', date '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (' Ditto', date '2022-05-14', 4, true, 22);

-- project for multiple tables., inserting data in owners table 
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- inserting data in species table 
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- modifying animal table
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';

-- inserting data in animals table
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name in ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name in ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name in ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name in ('Angemon', 'Boarmon');

-- project for add join table
INSERT INTO vets (name, age, date_of_graduation) values ('Vet William Tatcher', 45, date '2000-04-23');
INSERT INTO vets ( name, age, date_of_graduation) VALUES('Maisy Smith', 26, date '2019-01-17');
INSERT INTO vets ( name, age, date_of_graduation) VALUES('Stephanie Mendez', 64, date '1981-05-04');
INSERT INTO vets ( name, age, date_of_graduation) VALUES('Jack Harkness', 38, date '2008-06-08');

-- data for specializations
INSERT INTO specializations (vets_id, species_id)  VALUES (1,1);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 1);
INSERT INTO specializations (vets_id, species_id) VALUES (4, 2);

-- inser data in visit table
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (14, 1, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (14, 3, '2020-07-22');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (15, 4, '2021-02-02');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (16, 2, '2020-01-05');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (16, 2, '2020-03-08');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (16, 2, '2020-05-14');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (17, 3, '2021-05-04');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (18, 4, '2021-02-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (19, 2, '2019-12-21');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (19, 1, '2020-08-10');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (19, 2, '2021-04-07');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (20, 3, '2019-09-29');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (21, 4, '2020-10-03');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (21, 4, '2020-11-04');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (22, 2, '2019-01-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (22, 2, '2019-05-15');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (22, 2, '2020-02-27');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (22, 2, '2020-08-03');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (23, 3, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (23, 1, '2021-01-11');



-- ADD A TABLE FOR TESTING AND INDEX PERFOMANCE
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
