/* Populate database with sample data. */

INSERT INTO owners(full_name, age) VALUES 
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES
  ('Pokemon'), ('Digimon');

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id) VALUES
  ('Agumon', '2020-02-03', '0', 'yes', '10.23', 2, 1), ('Gabumon', '2018-11-15', '2', 'yes', '8.0', 2, 2),
  ('Pikachu', '2021-01-07', '1', 'no', '15.04', 1, 2), ('Devimon', '2017-05-12', '5', 'yes', '11.0', 2, 3),
  ('Charmander', '2020-02-08', '0', 'no', '-11.0', 1, 4), ('Plantmon.', '2021-11-15', '2', 'yes', '-5.7', 2, 3),
  ('Squirtle', '1993-04-02', '3', 'no', '-12.13', 1, 4), ('Angemon', '2005-06-12', '1', 'yes', '-45', 2, 5),
  ('Boarmon', '2005-06-07', '7', 'yes', '20.4', 2, 5), ('Blossom', '1998-10-13', '3', 'yes', '17', 1, 4),
  ('Ditto', '2022-05-14', '4', 'yes', '22', 1, NULL);

INSERT INTO vets(name, age, date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations(vets_id, species_id) VALUES
  ('1', '1'),
  ('2', NULL),
  ('3', '1'),
  ('3', '2'), ('4', '2');

INSERT INTO visits(animals_id, vets_id, date_of_visit) VALUES
  ('1', '1', '2020-05-24'), ('1', '3', '2020-07-22'),
  ('2', '4', '2020-02-02'), ('3', '2', '2020-01-05'),
  ('3', '2', '2020-03-08'), ('3', '2', '2020-05-14'),
  ('4', '3', '2021-05-04'), ('5', '4', '2021-04-24'),
  ('6', '2', '2019-12-21'), ('6', '1', '2020-08-10'),
  ('6', '2', '2021-04-07'), ('7', '3', '2019-09-29'),
  ('8', '4', '2020-10-03'), ('8', '4', '2020-11-02'),
  ('9', '2', '2019-01-24'), ('9', '2', '2019-05-15'),
  ('9', '2', '2020-02-27'), ('9', '2', '2020-08-03'),
  ('10', '3', '2020-05-24'), ('10', '1', '2021-01-11');