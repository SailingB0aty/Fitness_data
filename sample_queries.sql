USE exercise;

SET @running = 1;
SET @pushups = 2;
SET @plank_left = 3;
SET @plank_right = 4;
SET @plank = 5;
SET @chair_dips = 6;
SET @squats = 7;
SET @jumping_squats = 8;
SET @glute_bridges = 9;
SET @right_lunges = 10;
SET @left_lunges = 11;
SET @star_jumps = 12;
SET @walking = 13;
SET @rock_climbing = 14;

-- Add a workout from today
INSERT INTO workouts(workout_date, duration, notes)
VALUES (CURRENT_DATE, '00:15:00', 'Morning routine. Knee pain (2/10), no squats, no lunges');
SET @workout_id = LAST_INSERT_ID();
INSERT INTO workout_items(workout_id, exercise_id, reps, sets, distance)
VALUES
    (@workout_id, @pushups, 7, 1, NULL),
    (@workout_id, @plank_left, 40, 1, NULL),
    (@workout_id, @plank_right, 40, 1, NULL),
    (@workout_id, @plank, 40, 1, NULL),
    (@workout_id, @chair_dips, 10, 1, NULL),
    (@workout_id, @glute_bridges, 20, 2, NULL);
    -- (@workout_id, @star_jumps, 30, 1, NULL);


-- Add a run / walk
INSERT INTO workouts(workout_date, duration, notes)
VALUES (CURRENT_DATE, '00:28:31', 'Started as run, turned into walk after knee pain(2/10)');
SET @workout_id = LAST_INSERT_ID();
INSERT INTO workout_items(workout_id, exercise_id, reps, sets, distance)
VALUE (@workout_id, @walking, NULL, NULL, 03.0);

-- Retroactively added workout_time column
ALTER TABLE workouts
ADD COLUMN workout_time TIME NOT NULL;

-- Retroactively added weight column
ALTER TABLE workout_items
ADD COLUMN weight DECIMAL(3, 1) DEFAULT 00.0;



-- Replace Left Lunges and Right Lunges with one column, Lunges.
-- Check how symetrical the Right and Left entries are (They are perfectly symetrical)
SELECT e.exercise_id, e.name, wi.reps, wi.sets, w.workout_date
FROM workout_items wi
JOIN exercises e USING(exercise_id)
JOIN workouts w USING(workout_id)
WHERE e.name IN ("Left Lunges", "Right Lunges");

-- Add lunges exercise
INSERT INTO exercises(name, category, body_part, notes)
VALUE("Lunges", "Strength", "Legs", DEFAULT);

-- Get the ID of new lunges exercise
SELECT exercises.exercise_id INTO @lunges_id
FROM exercises
WHERE name = "Lunges";

-- Insert new Lunges exercise item for each appearance of lunges already there
INSERT INTO workout_items(workout_id, exercise_id, reps, sets, distance, weight)
SELECT
    wi.workout_id,
@lunges_id,
    wi.reps,
    wi.sets,
    wi.distance,
    wi.weight
FROM workout_items wi
JOIN exercises e USING(exercise_id)
WHERE e.name = "Left Lunges";

-- Remove old instances of left and right lunges
DELETE wi
FROM workout_items wi
JOIN exercises e USING(exercise_id)
WHERE e.name IN ("Left Lunges", "Right Lunges");

-- Remove right and left lunges from exercises
DELETE e
FROM exercises e
WHERE e.name IN ("Left Lunges", "Right Lunges");


-- Remove test workouts
DELETE w
FROM workouts w
WHERE w.workout_id IN (5, 7, 14, 15, 16, 17, 18, 19);
DELETE wi
FROM workout_items wi
WHERE wi.workout_id IN (5, 7, 14, 15, 16, 17, 18, 19);