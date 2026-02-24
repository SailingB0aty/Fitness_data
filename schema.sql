DROP DATABASE IF EXISTS exercise;
CREATE DATABASE exercise;
USE exercise;

CREATE TABLE exercises (
    exercise_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    body_part VARCHAR(50) NOT NULL,
    equipment_needed BOOLEAN NOT NULL DEFAULT FALSE,
    notes VARCHAR(255) DEFAULT NULL
);

INSERT INTO exercises (name, category, body_part)
VALUES ('Running', 'Cardio','Legs'),
       ('Pushups', 'Strength','Upper body'),
       ('Left side plank', 'Strength','Core'),
       ('Right side plank', 'Strength','Core'),
       ('Plank', 'Strength','Core'),
       ('Chair dips', 'Strength','Arms'),
       ('Squats', 'Strength','Legs'),
       ('Jumping squats', 'Strength','Legs'),
       ('Glute bridges', 'Strength','Legs'),
       ('Right lunges', 'Strength','Legs'),
       ('Left lunges', 'Strength','Legs'),
       ('Star Jumps', 'Cardio','Legs and Arms'),
       ('Walking', 'Cardio','Legs'),
       ('Rock climbing', 'Strength','Full Body');


CREATE TABLE equipment(
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    notes VARCHAR(255)
);

