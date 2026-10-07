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

load_dotenv()


def connect_database():

    try:

        connection_options = {
            "host": os.getenv("DB_HOST"),
            "port": int(os.getenv("DB_PORT", "3306")),
            "user": os.getenv("DB_USER"),
            "password": os.getenv("DB_PASSWORD"),
            "database": os.getenv("DB_NAME")
        }

        ssl_ca = os.getenv("DB_SSL_CA")

        if ssl_ca:
            connection_options.update({
                "ssl_ca": ssl_ca,
                "ssl_verify_cert": True,
                "ssl_verify_identity": True
            })

        connection = mariadb.connect(**connection_options)

        print("Database Connected Successfully!")

        return connection

    except mariadb.Error as e:

        print(f"Connection Error: {e}")

        return None


connection = connect_database()
cursor = connection.cursor()
