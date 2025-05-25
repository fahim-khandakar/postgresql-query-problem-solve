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


--Problem 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%'; 


--Problem 4
SELECT name, COUNT(*) AS total_sightings
FROM rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.ranger_id, r.name;


--Problem 5
SELECT common_name
FROM species sp
LEFT JOIN sightings s ON sp.species_id = s.species_id
WHERE s.sighting_id IS NULL;

-- Problem 6
SELECT sp.common_name, s.sighting_time, r.name AS name
FROM sightings s
JOIN rangers r ON s.ranger_id = r.ranger_id
JOIN species sp ON s.species_id = sp.species_id
ORDER BY s.sighting_time DESC
LIMIT 2

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


-- Problem 8
SELECT
  sighting_id,
  CASE
    WHEN CAST(sighting_time AS time) <= '12:00:00' THEN 'Morning'
    WHEN CAST(sighting_time AS time) > '12:00:00' AND CAST(sighting_time AS time) < '17:00:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;
