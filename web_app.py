import streamlit as st
import pandas as pd
import datetime as dt
import os
from narwhals.sql import table
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

st.title("Fitness Tracker")

load_dotenv()

HOST = os.getenv("FITNESS_DB_HOST", "127.0.0.1")
PORT = os.getenv("FITNESS_DB_PORT", "3306")
USER = os.getenv("FITNESS_DB_USER", "fitness_app")
PASSWORD = os.getenv("FITNESS_DB_PASS", "")
DB = os.getenv("FITNESS_DB_NAME", "exercise")

# Create engine to access DB
engine = create_engine(
    f"mysql+mysqlconnector://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB}"
)

# Get all tables within the DB
def get_table_names():
    with engine.connect() as conn:
        tables = pd.read_sql("SHOW TABLES;", conn)
        return tables.iloc[:, 0].tolist()
# Get a list of all exercises and their IDs
def get_exercise_options():
    with engine.connect() as conn:
        df = pd.read_sql("SELECT exercise_id, name FROM exercises ORDER BY exercise_id;", conn)
    return list(df.itertuples(index=False, name=None))

table_names = get_table_names()
exercise_options = get_exercise_options()

# Create tabs for viewing data and inputting data
tab1, tab2, tab3 = st.tabs(["View Data", "New Workout", "New Exercise"])

# ~~~ Tab 1 widgets ~~~ #
table = tab1.selectbox("Choose a table", table_names)
with engine.connect() as conn:
    df = pd.read_sql(text(f"SELECT * FROM `{table}`"), conn)
tab1.dataframe(df, height='content', width='stretch')

# ~~~ Tab 2 widgets ~~~ #
exercise_count = tab2.number_input("How many exercises?", 1, 10)
with tab2.form("New Workout", clear_on_submit=True, enter_to_submit=False, border=True, width="stretch", height="content"):
    workout_date = st.date_input("Workout date", value=dt.date.today())
    workout_time = st.time_input("Workout start time")
    workout_duration = st.number_input("Workout duration (Mins)", 1, 600)
    workout_notes = st.text_input("Workout notes")

    st.markdown("### Exercises ###")
    items = []
    for i in range(exercise_count):
        c1, c2, c3, c4 = st.columns([3,1,1,1])

        # Create widgets with a key so they can be distinguised from other widgets in the loop
        exercise = c1.selectbox(f"Exercise {i+1}", exercise_options, format_func=lambda x: x[1], key=f"exercise{i}")
        reps = c2.number_input("Reps", value=0, key=f"reps{i}")
        sets = c3.number_input("Sets", value=0, key=f"sets{i}")
        distance = c4.number_input("Distance (Km)", value=0, key=f"distance{i}")

        items.append({
            "exercise_id": exercise[0],
            "reps": None if reps == 0 else reps,
            "sets": None if sets == 0 else sets,
            "distance": None if distance == 0 else distance
        })

    submitted = st.form_submit_button("Submit")

# ~~~ Tab 3 widgets ~~~ #
