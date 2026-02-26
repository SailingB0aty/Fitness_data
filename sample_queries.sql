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