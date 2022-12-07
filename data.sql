/* Populate database with sample data. */

INSERT INTO owners(full_name, age) VALUES 
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES
  ('Pokemon'),
  ('Digimon');

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id) VALUES
  ('Agumon', '2020-02-03', '0', 'yes', '10.23', 2, 1),
  ('Gabumon', '2018-11-15', '2', 'yes', '8.0', 2, 2),
  ('Pikachu', '2021-01-07', '1', 'no', '15.04', 1, 2),
  ('Devimon', '2017-05-12', '5', 'yes', '11.0', 2, 3),
  ('Charmander', '2020-02-08', '0', 'no', '-11.0', 1, 4),
  ('Plantmon.', '2021-11-15', '2', 'yes', '-5.7', 2, 3),
  ('Squirtle', '1993-04-02', '3', 'no', '-12.13', 1, 4),
  ('Angemon', '2005-06-12', '1', 'yes', '-45', 2, 5),
  ('Boarmon', '2005-06-07', '7', 'yes', '20.4', 2, 5),
  ('Blossom', '1998-10-13', '3', 'yes', '17', 1, 4),
  ('Ditto', '2022-05-14', '4', 'yes', '22', 1, NULL);
