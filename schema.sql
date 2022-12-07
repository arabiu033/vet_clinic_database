/* Database schema to keep the structure of entire database. */

-- Delete table if already exist
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS species;

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

-- animals tables
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT,
    species_id INT REFERENCES species(id),
    owner_id INT REFERENCES owners(id)
);
