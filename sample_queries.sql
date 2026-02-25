USE exercise;

-- Add a workout from today
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

INSERT INTO workouts(workout_date, duration, notes)
VALUES (CURRENT_DATE, '00:15:00', 'Morning routine. Knee pain no legs');
SET @workout_id = LAST_INSERT_ID();
INSERT INTO workout_items(workout_id, exercise_id, reps, sets, distance)
VALUES
    (@workout_id, 2, 7, 1, NULL),
    (@workout_id, @plank_left, 35, 1, NULL),
    (@workout_id, @plank_right, 35, 1, NULL),
    (@workout_id, @plank, 35, 1, NULL),
    (@workout_id, @chair_dips, 10, 1, NULL),
    (@workout_id, @glute_bridges, 15, 3, NULL),
    (@workout_id, @star_jumps, 30, 1, NULL);


-- Add a run / walk
INSERT INTO workouts(workout_date, duration, notes)
VALUES (CURRENT_DATE, '01:07:24', 'Leisurely stroll');
SET @workout_id = LAST_INSERT_ID();
INSERT INTO workout_items(workout_id, exercise_id, reps, sets, distance)
VALUE (@workout_id, @walking, NULL, NULL, 05.3);