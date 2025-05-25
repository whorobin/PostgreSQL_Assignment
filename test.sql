-- Active: 1747565100035@@127.0.0.1@5432@first_table


-- Table 1 
CREATE TABLE rangers1 (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL
);

INSERT INTO rangers1 (ranger_id, name, region) VALUES
(1, 'Meera', 'Coastal Plains'),
(2, 'Eva Stone', 'Rainforest Edge'),
(3, 'Felix Hart', 'Savannah Basin'),
(4, 'Grace Moon', 'Desert Frontier');


SELECT * FROM rangers1;


-- Table 2
CREATE TABLE species1 (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL
);

INSERT INTO species1 (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species1;


-- Table 3

CREATE TABLE sightings1 (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL,
    location TEXT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT,

    FOREIGN KEY (species_id) REFERENCES species1(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers1(ranger_id)
);

INSERT INTO sightings1 (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 2, 'Elephant Crossing', '2024-06-01 06:15:00', 'Group of 3 spotted near waterhole'),
(2, 2, 3, 'Golden Cliff', '2024-06-03 14:50:00', 'Observed grooming behavior'),
(3, 3, 4, 'Pangolin Hollow', '2024-06-05 20:30:00', 'Nocturnal activity recorded'),
(4, 2, 1, 'Bustard Plains', '2024-06-07 08:25:00', 'Solo bird walking across field');


SELECT * FROM sightings1;


-- Question 1
INSERT INTO rangers1 (name, region) VALUES
('Derek Fox', 'Coastal Plains');


-- Question 2 (problem)

SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings1;


-- Question 3
SELECT *
FROM sightings1
WHERE location LIKE '%Cliff%';

-- Question 4

SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers1 r
LEFT JOIN sightings1 s ON r.ranger_id = s.ranger_id
GROUP BY r.name;

-- Question 5
SELECT sp.common_name, sp.scientific_name
FROM species1 sp
LEFT JOIN sightings1 s ON sp.species_id = s.species_id
WHERE s.sighting_id IS NULL;


-- Question 6
SELECT *
FROM sightings1
ORDER BY sighting_time DESC
LIMIT 2;

-- Question 7
UPDATE species1
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


-- Question 8
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
FROM sightings1;



-- Question 9
DELETE FROM rangers1
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id
  FROM sightings1
);







