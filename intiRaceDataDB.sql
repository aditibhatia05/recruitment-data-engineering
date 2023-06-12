-- Use the database
\c postgres;

-- Create the schema for race data
CREATE SCHEMA IF NOT EXISTS race_data;

-- Switch to race_data schema
SET search_path TO race_data;

-- Create the countries table
CREATE TABLE IF NOT EXISTS countries (
    country_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create the drivers table
CREATE TABLE IF NOT EXISTS drivers (
    driver_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    driver_ref VARCHAR(255),
    number INT,
    code VARCHAR(255),
    forename VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    dob DATE,
    nationality INT REFERENCES countries(country_id)
);

-- Create the constructors table
CREATE TABLE IF NOT EXISTS constructors (
    constructor_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country INT REFERENCES countries(country_id)
);

-- Create the status table
CREATE TABLE IF NOT EXISTS status (
    status_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    status VARCHAR(255) NOT NULL
);

-- Create the circuits table
CREATE TABLE IF NOT EXISTS circuits (
    circuit_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    circuit_reference VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    lat FLOAT,
    long FLOAT
);

-- Create the seasons table
CREATE TABLE IF NOT EXISTS seasons (
    year INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL
);

-- Create the races table
CREATE TABLE IF NOT EXISTS races (
    race_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    season INT REFERENCES seasons(year),
    round INT,
    circuit_id INT REFERENCES circuits(circuit_id),
    official_name VARCHAR(255),
    date DATE
);

-- Create the sessions table
CREATE TABLE IF NOT EXISTS sessions (
    session_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    race_id INT NOT NULL REFERENCES races(race_id),
    type VARCHAR(255),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    gmt_offset INT
);

-- Create the results table
CREATE TABLE IF NOT EXISTS results (
    result_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    constructor_id INT REFERENCES constructors(constructor_id),
    number INT,
    grid INT,
    position INT,
    points DECIMAL,
    laps INT,
    time VARCHAR(255),
    fastest_lap_time VARCHAR(255),
    rank INT,
    fastest_lap_speed DECIMAL,
    status_id INT REFERENCES status(status_id)
);