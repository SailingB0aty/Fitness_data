DROP DATABASE IF EXISTS exercise;
CREATE DATABASE exercise;
USE exercise;

CREATE TABLE exercises (
    exercise_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    body_part VARCHAR(50) NOT NULL,
    notes VARCHAR(255) DEFAULT NULL
);

CREATE TABLE workouts(
    workout_id INT AUTO_INCREMENT PRIMARY KEY,
    workout_date DATE NOT NULL,
    workout_time TIME NOT NULL,
    duration TIME NOT NULL,
    notes VARCHAR(255) DEFAULT NULL
);

CREATE TABLE workout_items(
    workout_id INT NOT NULL,
    exercise_id INT NOT NULL,
    reps INT DEFAULT NULL,
    sets INT DEFAULT NULL,
    distance DECIMAL(3, 1) DEFAULT NULL,
    weight DECIMAL(3, 1) DEFAULT 00.0,
    PRIMARY KEY (workout_id, exercise_id),
    FOREIGN KEY (workout_id) REFERENCES workouts(workout_id) ON DELETE CASCADE,
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id) ON DELETE CASCADE

);


SELECT @@datadir;