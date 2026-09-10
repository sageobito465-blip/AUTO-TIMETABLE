"""
Database Connection
--------------------
This file connects the app to the MariaDB database.
app.py imports "connection" and "cursor" from here whenever
it needs to talk to the database.

WINDOWS NOTE:
Installing the "mariadb" Python package on Windows sometimes fails
unless MariaDB Connector/C is installed first. If "pip install mariadb"
gives an error, download and install Connector/C from mariadb.com,
then try the pip install again.
"""

import mariadb

try:
    # Try to connect to the database using these details.
    # Update these values to match your own database setup.
    connection = mariadb.connect(
        host="localhost",
        user="flask_user",
        password="flask123",
        database="auto_timetable"
    )

    # The cursor is what we use to actually run SQL commands
    cursor = connection.cursor()

    print("Database Connected Successfully!")

except mariadb.Error as e:
    # If the connection fails, print the error instead of crashing silently
    print(f"Connection Error: {e}")