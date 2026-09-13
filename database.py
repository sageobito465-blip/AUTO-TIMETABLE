"""
Database Connection
--------------------
This file connects the app to the MariaDB database.
app.py imports "connection" and "cursor" from here whenever
it needs to talk to the database.
"""

import mariadb
import os
from dotenv import load_dotenv

load_dotenv()  # reads the .env file and loads its values into the environment

try:
    connection = mariadb.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )

    cursor = connection.cursor()

    print("Database Connected Successfully!")

except mariadb.Error as e:
    print(f"Connection Error: {e}")