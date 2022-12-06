/* Database schema to keep the structure of entire database. */

-- Delete table if already exist
DROP TABLE IF EXISTS animals;

-- Create new table
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT,
    species varchar(256) DEFAULT NULL
);
