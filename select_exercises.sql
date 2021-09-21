-- How many rows are in the albums table?
SELECT COUNT(*) FROM albums;

-- How many unique artist names are in the albums table?
SELECT COUNT(DISTINCT artist) FROM albums;

-- What is the primary key for the albums table? Cmd show "id" id Primary Key
SHOW CREATE TABLE albums; 
SHOW KEYS FROM albums WHERE key_name = 'PRIMARY'

-- What is the oldest release date for any album in the albums table? What is the most recent release date?
SELECT * FROM albums WHERE release_date = (SELECT MIN(release_date) FROM albums);
SELECT * FROM albums WHERE release_date = (SELECT MAX(release_date) FROM albums);
ORDER BY release_date ASC;

-- The name of all albums by Pink Floyd
SELECT artist, name FROM albums WHERE artist = 'Pink Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT name, release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- The genre for the album Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';

-- Which albums were released in the 1990s
SELECT name FROM albums WHERE release_date >= 1990 AND release_date <= 1999;

-- Which albums had less than 20 million certified sales
SELECT name FROM albums WHERE sales < 20;

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?  -- Added "LIKE' instead of '=' and % instead of *.
SELECT name, genre FROM albums WHERE genre LIKE '%Rock%'; 
