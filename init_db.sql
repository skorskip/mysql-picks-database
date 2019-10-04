CREATE DATABASE IF NOT EXISTS pickem;

USE pickem;

ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'p1cks4ppDB';
FLUSH PRIVILEGES;

CREATE TABLE teams (
    teamId INT PRIMARY KEY,
    primaryColor VARCHAR(20),
    secondaryColor VARCHAR(20),
    name VARCHAR(20),
    abbreviation VARCHAR(10)
);

CREATE TABLE games (
    gameId INT PRIMARY KEY,
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
    status VARCHAR(20),
    isOn BOOLEAN
);

CREATE TABLE users (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    password VARCHAR(50),
    email VARCHAR(50),

    CONSTRAINT UC_user UNIQUE (name),
    CONSTRAINT UC_email UNIQUE (email)
);

CREATE TABLE picks (
    pickId INT PRIMARY KEY AUTO_INCREMENT,
    season INT,
    week INT,
    gameId INT,
    teamId INT,
    userId INT,
    submitted DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT UC_pick UNIQUE (gameId, week, season),

    INDEX game_ind (gameId),
    INDEX team_ind (teamId),
    INDEX user_ind (userId),

    FOREIGN KEY (teamId)
        REFERENCES teams(teamId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (gameId)
        REFERENCES games(gameId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (userId)
        REFERENCES users(userId)
        ON DELETE CASCADE
        ON UPDATE CASCADE

);

LOAD DATA INFILE '/var/lib/mysql-files/teamData.csv' 
INTO TABLE teams  FIELDS TERMINATED 
BY ','  ENCLOSED 
BY '"' LINES TERMINATED 
BY '\r\n' IGNORE 1 LINES;