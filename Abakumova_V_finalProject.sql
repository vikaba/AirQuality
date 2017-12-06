-- create database for storing different demographic values and environmental factors by state
DROP DATABASE IF EXISTS envi_model;
CREATE DATABASE envi_model;

USE envi_model;

-- table for storing poverty percentages by state
CREATE TABLE poverty (
    state CHAR(30) NOT NULL,
    county VARCHAR(60) NOT NULL,
    poverty_percent FLOAT
);

-- table for gender percentages by state
-- only stores male percentage because female percentage is 100 - the male-percentage
CREATE TABLE gender (
    state CHAR(30) NOT NULL,
    county VARCHAR(50) NOT NULL,
    male_percent FLOAT
);

-- table for race percentage breakdowns by state
-- other races exist but the most prominent numbers exist for white, black, and hispanic
-- percentages
CREATE TABLE race (
    state CHAR(30) NOT NULL,
    county VARCHAR(50) NOT NULL,
    white_percent FLOAT,
    black_percent FLOAT,
    hispanic_percent FLOAT,
    asian_percent FLOAT,
    native_percent FLOAT
);

-- table for air quality measurements by state
CREATE TABLE air_quality (
    state CHAR(30) NOT NULL,
    county VARCHAR(50) NOT NULL,
    days_recorded FLOAT NOT NULL,
    good_days FLOAT NOT NULL,
    moderate_days FLOAT NOT NULL,
    unhealthy_days FLOAT NOT NULL,
    very_unhealthy_days FLOAT NOT NULL,
    hazardous_days FLOAT NOT NULL
);

-- join all of existing measuring tables by county and state
SELECT DISTINCT
	air_quality.state,
    air_quality.county,
    poverty.poverty_percent,
    gender.male_percent,
    race.white_percent,
    race.black_percent,
    race.hispanic_percent,
    race.asian_percent,
    race.native_percent,
    air_quality.good_days,
    air_quality.moderate_days,
    air_quality.unhealthy_days,
    air_quality.very_unhealthy_days,
    air_quality.hazardous_days
FROM
    (SELECT DISTINCT * FROM gender) AS gender,
    (SELECT DISTINCT * FROM race) AS race,
    (SELECT DISTINCT * FROM poverty) AS poverty,
    (SELECT DISTINCT * FROM air_quality) AS air_quality
WHERE
	gender.state = gender.state AND
    gender.state = race.state
        AND gender.county = race.county
        AND race.state = poverty.state
		AND race.county = poverty.county
        AND poverty.state = air_quality.state
        AND poverty.county = air_quality.county;