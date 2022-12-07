/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals
WHERE name LIKE '%mon';

SELECT name 
FROM animals
WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';

SELECT name 
FROM animals
WHERE neutered = 't' AND escape_attempts < 3;

SELECT date_of_birth 
FROM animals
WHERE name = 'Pikachu' OR name = 'Agumon';

SELECT name, escape_attempts 
FROM animals
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
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts 
  FROM animals
  WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-1-1'
  GROUP BY species;

-- animals belong to Melody Pond?
SELECT name
  FROM animals
  LEFT JOIN owners
    ON owners.id = animals.owner_id
  WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
  FROM animals
  LEFT JOIN species
    ON species.id = animals.species_id
  WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name
  FROM owners
  LEFT JOIN animals
    ON owners.id = animals.owner_id
  ORDER BY owners.full_name;

-- How many animals are there per species?
SELECT species.name, COUNT(*)
  FROM species
  RIGHT JOIN animals
    ON species.id = animals.species_id
  GROUP BY (species.name);

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name
  FROM animals
  LEFT JOIN species
    ON species.id = animals.species_id
  LEFT JOIN owners
    ON owners.id = animals.owner_id
  WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name
  FROM animals
  LEFT JOIN owners
    ON animals.owner_id = owners.id
  WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT owners.full_name, COUNT(*)
  FROM owners
  LEFT JOIN animals
    ON owners.id = animals.owner_id
  GROUP BY owners.full_name
  ORDER BY count DESC;

  /* ADVANCE QUERIES */

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit
  FROM animals
  INNER JOIN visits
    ON visits.animals_id = animals.id
  WHERE visits.date_of_visit IN (SELECT MAX(visits.date_of_visit)
                                  FROM animals
                                  LEFT JOIN visits
                                    ON animals.id = visits.animals_id
                                  LEFT JOIN vets
                                    ON vets.id = visits.vets_id
                                  WHERE vets.name = 'William Tatcher'
                                  GROUP BY vets.name);

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*)
  FROM animals
  LEFT JOIN visits
    ON visits.animals_id = animals.id
  LEFT JOIN vets
    ON visits.vets_id = vets.id
  WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties
SELECT vets.name, species.name
  FROM vets
  LEFT JOIN specializations
    ON specializations.vets_id = vets.id
  LEFT JOIN species
    ON species.id = specializations.species_id
  ORDER By vets.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
  FROM animals
  LEFT JOIN visits
    ON animals.id = visits.animals_id
  LEFT JOIN vets
    ON vets.id = visits.vets_id
  WHERE vets.name = 'Stephanie Mendez' 
    AND visits.date_of_visit 
    BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*)
  FROM animals
  LEFT JOIN visits
    ON visits.animals_id = animals.id
  GROUP BY animals.name
  ORDER BY count DESC;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit 
  FROM animals
  INNER JOIN visits
    ON visits.animals_id = animals.id
  WHERE visits.date_of_visit IN (SELECT MIN(visits.date_of_visit)
                                  FROM animals
                                  LEFT JOIN visits
                                    ON animals.id = visits.animals_id
                                  LEFT JOIN vets
                                    ON vets.id = visits.vets_id
                                  WHERE vets.name = 'Maisy Smith'
                                  GROUP BY vets.name);

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.*, visits.date_of_visit 
  FROM animals
  INNER JOIN visits
    ON visits.animals_id = animals.id
  LEFT JOIN vets
    ON vets.id = visits.vets_id
  WHERE visits.date_of_visit IN (SELECT MAX(visits.date_of_visit)
                                  FROM animals
                                  LEFT JOIN visits
                                    ON animals.id = visits.animals_id
                                  LEFT JOIN vets
                                    ON vets.id = visits.vets_id
                                  GROUP BY animals.name);

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(*)
  FROM animals
  INNER JOIN visits
    ON visits.animals_id = animals.id
  INNER JOIN specializations
    ON specializations.vets_id = visits.vets_id
  INNER JOIN vets
    ON vets.id = specializations.vets_id
  WHERE specializations.species_id IS NULL OR animals.species_id <> specializations.species_id
  GROUP BY vets.name
  ORDER BY count DESC;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(*)
  FROM animals
  INNER JOIN visits
    ON visits.animals_id = animals.id
  INNER JOIN specializations
    ON specializations.vets_id = visits.vets_id
  INNER JOIN vets
    ON vets.id = specializations.vets_id
  INNER JOIN species
    ON animals.species_id = species.id
  WHERE specializations.species_id IS NULL
  GROUP BY species.name
  ORDER BY count DESC;
