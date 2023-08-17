--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


-- Create the 'constellation' table
CREATE TABLE public.constellation (
    constellation_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    visible_from_earth BOOLEAN,
    UNIQUE(name)
);

ALTER TABLE public.constellation OWNER TO freecodecamp;

-- Create the 'galaxy' table
CREATE TABLE public.galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    age_in_millions_of_years INT,
    constellation_id INT REFERENCES public.constellation(constellation_id),
    UNIQUE(name)
);

ALTER TABLE public.galaxy OWNER TO freecodecamp;

-- Create the 'star' table
CREATE TABLE public.star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    galaxy_id INT REFERENCES public.galaxy(galaxy_id),
    is_spherical BOOLEAN,
    distance_from_earth NUMERIC,
    UNIQUE(name)
);

ALTER TABLE public.star OWNER TO freecodecamp;

-- Create the 'planet' table
CREATE TABLE public.planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    star_id INT REFERENCES public.star(star_id),
    planet_type VARCHAR(50),
    has_life BOOLEAN,
    planet_age_in_millions_of_years INT,
    UNIQUE(name)
);

ALTER TABLE public.planet OWNER TO freecodecamp;

-- Create the 'moon' table
CREATE TABLE public.moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    planet_id INT REFERENCES public.planet(planet_id),
    moon_type VARCHAR(50),
    orbit_period INT,
    UNIQUE(name)
);

ALTER TABLE public.moon OWNER TO freecodecamp;

-- Insert data into 'constellation' table
INSERT INTO public.constellation (name, description, visible_from_earth)
VALUES
    ('Orion', 'A prominent constellation in the winter sky', true),
    ('Ursa Major', 'Known as the Great Bear, it contains the Big Dipper', true),
    ('Cassiopeia', 'Shaped like a "W", visible in the northern sky', true),
    ('Scorpius', 'Resembles a scorpion and is visible in the southern hemisphere', true),
    ('Cygnus', 'Known as the Northern Cross, part of the Milky Way', true);

-- Insert data into 'galaxy' table
INSERT INTO public.galaxy (name, description, age_in_millions_of_years)
VALUES
    ('Andromeda', 'A neighboring galaxy', 20000),
    ('Triangulum', 'A small spiral galaxy', 12000),
    ('Centaurus A', 'An elliptical galaxy with a prominent dust lane', 10000),
    ('Whirlpool', 'A grand-design spiral galaxy interacting with a smaller galaxy', 8000),
    ('Sombrero', 'A spiral galaxy with a large central bulge', 16000),
    ('Cartwheel', 'A galaxy with a distinctive ring structure', 14000);

-- Insert data into 'star' table
INSERT INTO public.star (name, galaxy_id, is_spherical, distance_from_earth)
VALUES
    ('Alpha Centauri', 2, true, 4.37),
    ('Betelgeuse', 2, false, 642),
    ('Sirius', 1, false, 8.6),
    ('Antares', 3, false, 550),
    ('Aldebaran', 4, false, 65),
    ('Arcturus', 5, false, 37);
    
-- Insert data into 'planet' table
INSERT INTO public.planet (name, star_id, planet_type, has_life, planet_age_in_millions_of_years)
VALUES
    ('Earth', 1, 'Terrestrial', true, 4500),
    ('Mars', 1, 'Terrestrial', false, 4000),
    ('Jupiter', 2, 'Gas Giant', false, 4600),
    ('Saturn', 2, 'Gas Giant', false, 4400),
    ('Venus', 1, 'Terrestrial', false, 4200),
    ('Neptune', 2, 'Ice Giant', false, 4700),
    ('Uranus', 2, 'Ice Giant', false, 4100),
    ('Mercury', 1, 'Terrestrial', false, 4300),
    ('Pluto', 1, 'Dwarf Planet', false, 4200),
    ('Europa', 1, 'Moon of Jupiter', false, 4600),
    ('Titan', 2, 'Moon of Saturn', false, 4500),
    ('Triton', 2, 'Moon of Neptune', false, 4300);

-- Insert data into 'moon' table
INSERT INTO public.moon (name, planet_id, moon_type, orbit_period)
VALUES
    ('Moon', 1, 'Natural', 27),
    ('Phobos', 3, 'Natural', 7),
    ('Deimos', 3, 'Natural', 30),
    ('Ganymede', 3, 'Natural', 7),
    ('Io', 3, 'Natural', 2),
    ('Callisto', 3, 'Natural', 16),
    ('Enceladus', 4, 'Natural', 1),
    ('Titan', 4, 'Natural', 16),
    ('Mimas', 4, 'Natural', 0.9),
    ('Tethys', 4, 'Natural', 1.9),
    ('Dione', 4, 'Natural', 2.7),
    ('Rhea', 4, 'Natural', 4.5),
    ('Venus', 5, 'Natural', 0.7),
    ('Triton', 6, 'Natural', 6),
    ('Nereid', 6, 'Natural', 360),
    ('Charon', 8, 'Natural', 6.4),
    ('Styx', 8, 'Natural', 20),
    ('Kerberos', 8, 'Natural', 32),
    ('Hydra', 8, 'Natural', 38),
    ('Miranda', 11, 'Natural', 1.4),
    ('Ariel', 11, 'Natural', 2.5),
    ('Umbriel', 11, 'Natural', 4.1),
    ('Titania', 11, 'Natural', 8.7),
    ('Oberon', 11, 'Natural', 13.5);

--
-- PostgreSQL database dump complete
--
