-- Active: 1747675091132@@127.0.0.1@5432@conservation_db
-- Create rangers table
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL
);


-- Create species table
CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  common_name VARCHAR(50) NOT NULL,
  scientific_name VARCHAR(100) NOT NULL,
  discovery_date DATE NOT NULL,
  conservation_status VARCHAR(50) NOT NULL
);

-- Create sightings table
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INT REFERENCES rangers(ranger_id),
  species_id INT REFERENCES species(species_id),
  sighting_time TIMESTAMP NOT NULL,
  location VARCHAR(100) NOT NULL,
  notes TEXT
);


--Insert data in rangers table
INSERT INTO rangers (name, region)
VALUES ('Alice Green', 'Northern Hills'),
       ('Bob White', 'River Delta'),
       ('Carol King', 'Mountain Range');


-- Select data from rangers table
SELECT * FROM rangers;

--Insert data in species table
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES 
  ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
  ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
  ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
  ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
  ('Northern Hairy-nosed Wombat', 'Lasiorhinus krefftii', '1982-05-12', 'Critically Endangered');

-- Select data from species table
SELECT * FROM species;



--Insert data in sightings table
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
VALUES 
  (1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
  (2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
  (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
  (1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL);


-- Select data from sightings table
SELECT * FROM sightings;


--Problem 1 
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');


--Problem 2
SELECT count(DISTINCT species_id) AS unique_species_count FROM sightings;