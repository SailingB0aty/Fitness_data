import streamlit as st
import pandas as pd
import datetime as dt
from narwhals.sql import table
from sqlalchemy import create_engine, text

st.title("Fitness DB Viewer")

USER = "fitness_app"
PASSWORD = "choose_a_password"
HOST = "127.0.0.1"
PORT = 3306
DB = "exercise"

# Create engine to access DB
engine = create_engine(
    f"mysql+mysqlconnector://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB}"
)

# Get all tables within the DB
with engine.connect() as conn:
    tables = pd.read_sql("SHOW TABLES;", conn)
    table_names = tables.iloc[:, 0].tolist()

# Create tabs for viewing data and inputting data
tab1, tab2, tab3 = st.tabs(["View Data", "Add Workout", "New Exercise"])

# Tab 1 widgets
table = tab1.selectbox("Choose a table", table_names)
with engine.connect() as conn:
    df = pd.read_sql(text(f"SELECT * FROM `{table}`"), conn)
tab1.dataframe(df, height='content', use_container_width=True)

# Tab 2 widgets
exercise_count = tab2.number_input("How many exercises?", 1, 10)
with tab2.form("New Workout", clear_on_submit=True, enter_to_submit=False, border=True, width="stretch", height="content"):
    workout_date = st.date_input("Workout date", value=dt.date.today())
    workout_time = st.time_input("Workout start time")
    workout_duration = st.number_input("Workout duration (Mins)", 1, 600)
    workout_notes = st.text_input("Workout notes")

    st.markdown("### Exercises ###")
    for i in range(exercise_count):
        st.selectbox(f"Exercise {i+1}:", ["dog", "cat"])
    submitted = st.form_submit_button("Add workout")

# Tab 3 widgets