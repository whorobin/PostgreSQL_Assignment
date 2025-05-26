-- Active: 1747565100035@@127.0.0.1@5432@first_table

-- Table - 1 : Rangers
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL
);

INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Meera', 'Coastal Plains'),
(2, 'Eva Stone', 'Rainforest Edge'),
(3, 'Felix Hart', 'Savannah Basin'),
(4, 'Grace Moon', 'Desert Frontier');

SELECT * FROM rangers;

-- Table - 2 : species

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL
);

INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species;

-- Table - 3 : sightings 

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL,
    location TEXT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT,

    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);

INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 2, 'Elephant Crossing', '2024-06-01 06:15:00', 'Group of 3 spotted near waterhole'),
(2, 2, 3, 'Golden Cliff Pass', '2024-06-03 14:50:00', 'Observed grooming behavior'),
(3, 3, 4, 'Pangolin Hollow', '2024-06-05 20:30:00', 'Nocturnal activity recorded'),
(4, 2, 1, 'Bustard Plains', '2024-06-07 08:25:00', 'Solo bird walking across field');

SELECT * FROM sightings;


-- Question 1 : Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'

INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains');


-- Question 2 : Count unique species ever sighted.

SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings1;


-- Question 3 : Find all sightings where the location includes "Pass".

SELECT *
FROM sightings
WHERE location LIKE '%Pass%';


-- Question 4 : List each ranger's name and their total number of sightings.

SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;


-- Question 5 : List species that have never been sighted.

SELECT sp.common_name, sp.scientific_name
FROM species sp
LEFT JOIN sightings s ON sp.species_id = s.species_id
WHERE s.sighting_id IS NULL;


-- Question 6 : Show the most recent 2 sightings.

SELECT *
FROM sightings
ORDER BY sighting_time DESC
LIMIT 2;


-- Question 7 : Update all species discovered before year 1800 to have status 'Historic'.

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


-- Question 8 : Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.

SELECT 
  sighting_id,
  species_id,
  ranger_id,
  location,
  sighting_time,
  notes,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;


-- Question 9 :  Delete rangers who have never sighted any species

DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id
  FROM sightings
);