CREATE DATABASE IF NOT EXISTS pickem;

USE pickem;

ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'p1cks4ppDB';
FLUSH PRIVILEGES;

CREATE TABLE teams (
id INT PRIMARY KEY,
primaryColor VARCHAR(20),
secondaryColor VARCHAR(20),
name VARCHAR(20),
abbreviation VARCHAR(10)
);

CREATE TABLE games (
id INT,
lastUpdated DATETIME,
week INTEGER,
season INTEGER,
date DATETIME,
submitDate DATETIME,
homeTeam INT,
awayTeam INT,
homeScore INT,
awayScore INT,
spread INTEGER,
progress VARCHAR(20),
isOn BOOLEAN
);

LOAD DATA INFILE '/var/lib/mysql-files/teamData.csv' 
INTO TABLE teams  FIELDS TERMINATED 
BY ','  ENCLOSED 
BY '"' LINES TERMINATED 
BY '\r\n' IGNORE 1 LINES;