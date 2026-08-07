import mariadb

try:
    connection = mariadb.connect(
        host="localhost",
        user="flask_user",
        password="flask123",
        database="auto_timetable"
    )

    cursor = connection.cursor()

    print("✅ Database Connected Successfully!")

except mariadb.Error as e:
    print(f"Connection Error: {e}")