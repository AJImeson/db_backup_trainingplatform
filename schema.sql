
-- Project: Athletic & Fitness Journal 
-- Run with: sqlite3 {file}.sql < schema.sql

-- Clean up logic

PRAGMA foreign_keys = OFF;
DROP TABLE IF EXISTS README;
DROP TABLE IF EXISTS discipline_focus;
DROP TABLE IF EXISTS focal_points;
DROP TABLE IF EXISTS discipline;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS exercise_discipline_tags;
DROP TABLE IF EXISTS exercises;
DROP TABLE IF EXISTS session_sets;
DROP TABLE IF EXISTS sessions;
PRAGMA foreign_keys = ON;

-- Documentation

CREATE TABLE README (
	info TEXT,
	instruc TEXT
);

-- Main Tables

CREATE TABLE users (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT NOT NULL UNIQUE
);

CREATE TABLE discipline (
	discipline_id INTEGER PRIMARY KEY AUTOINCREMENT,
	name	TEXT NOT NULL UNIQUE,
	user_id INTEGER,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
); 

CREATE TABLE focal_points (
	focal_id INTEGER PRIMARY KEY AUTOINCREMENT,
	focal_name TEXT NOT NULL UNIQUE
);

-- Bridge/Map tables

CREATE TABLE discipline_focus (
	discipline_id INTEGER,
	focal_id INTEGER,
	PRIMARY KEY (discipline_id, focal_id),
	FOREIGN KEY (discipline_id) REFERENCES discipline(discipline_id) ON DELETE CASCADE,
	FOREIGN KEY (focal_id) REFERENCES focal_points(focal_id) ON DELETE CASCADE
);

CREATE TABLE exercise_discipline_tags (
	exercise_id INTEGER,
	discipline_id INTEGER,
	PRIMARY KEY (exercise_id, discipline_id),
	FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id) ON DELETE CASCADE,
	FOREIGN KEY (discipline_id) REFERENCES discipline(discipline_id) ON DELETE CASCADE

); 

-- Workout Journal Specifics

CREATE TABLE sessions (
	session_id INTEGER PRIMARY KEY,
	user_id INTEGER,
	date TEXT DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE exercises (
	exercise_id INTEGER PRIMARY KEY,
	name TEXT NOT NULL UNIQUE
);

CREATE TABLE session_sets (
	set_id INTEGER PRIMARY KEY,
	session_id INTEGER,
	exercise_id INTEGER,
	weight REAL CHECK(weight >= 0),
	reps INTEGER,
	FOREIGN KEY (session_id) REFERENCES sessions(session_id), 
	FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

-- Readme Insert

INSERT INTO README (info, instruc) VALUES

	('Coach and Athlete Journal ', ' Append to file for usage with SQL');

-- Initial Data Insert

INSERT INTO users (username) VALUES ('Axel');

INSERT INTO focal_points (focal_name) VALUES
	('Bodyweight'),
	('Explosive'),
	('Strength'),
	('Hypertropyhy'),
	('Static-Strength');

INSERT INTO discipline (name, user_id) VALUES ('Calisthenics', 1);

-- Mapping Data

INSERT INTO discipline_focus (discipline_id, focal_id) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 5);


