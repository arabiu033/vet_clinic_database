/* Database schema to keep the structure of entire database. */

-- Delete table if already exist
DROP TABLE IF EXISTS animals CASCADE;
DROP TABLE IF EXISTS owners CASCADE;
DROP TABLE IF EXISTS species CASCADE;
DROP TABLE IF EXISTS vets CASCADE;
DROP TABLE IF EXISTS visits CASCADE;
DROP TABLE IF EXISTS specializations CASCADE;

-- animals owners table
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(256),
    age INT,
    PRIMARY KEY (id)
);

-- species table
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(256),
    PRIMARY KEY (id)
);

-- animals table
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT,
    species_id INT REFERENCES species(id),
    owner_id INT REFERENCES owners(id),
    PRIMARY KEY(ID)
);

-- vets table
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(256),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

-- Join table for vets and species
CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
    vets_id INT REFERENCES vets(id)
);

-- JOI table for animals and vets
CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    date_of_visit DATE
);