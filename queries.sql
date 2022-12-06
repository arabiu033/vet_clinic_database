/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals
WHERE name LIKE '%mon';

SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';

SELECT name FROM animals
WHERE neutered = 't' AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name = 'Pikachu' OR name = 'Agumon';

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutered = 't';

SELECT * FROM animals
WHERE name <> 'Gabumon';

SELECT * FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN; -- a transaction
-- update the animals table by setting the species column to unspecified
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK; -- rollback the changes
SELECT * FROM animals;

BEGIN; -- a transaction
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals;

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;
COMMIT; -- Commit the transaction.
SELECT * FROM animals;

BEGIN; -- a transaction
-- delete all records in the animals table, then roll back the transaction.
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- a transaction
BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT sp; -- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO sp; -- Rollback to the savepoint

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT; -- Commit transaction

-- How many animals are there?
SELECT COUNT(*) AS number_of_animals
FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS never_escape
FROM animals
WHERE escape_attempts = 0;

-- average weight of animals?
SELECT AVG(weight_kg) AS average_weight
FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(escape_attempts) AS neutered_escape_attempts
FROM animals
GROUP BY neutered;

-- minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals
GROUP BY species;

-- average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts 
FROM animals
WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-1-1'
GROUP BY species;