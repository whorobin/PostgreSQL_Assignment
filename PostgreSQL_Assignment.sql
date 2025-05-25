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