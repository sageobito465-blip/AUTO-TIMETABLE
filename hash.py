from database import connection, cursor
from werkzeug.security import generate_password_hash

# Get every user currently in the database
cursor.execute("SELECT id, password FROM users")
all_users = cursor.fetchall()

for user in all_users:
    user_id = user[0]
    current_password = user[1]

    # Hash whatever is currently stored (assumed to be plain text at this point)
    hashed = generate_password_hash(current_password)

    # Save the hashed version back into the same row
    cursor.execute("UPDATE users SET password = ? WHERE id = ?", (hashed, user_id))

connection.commit()
print("All existing passwords have been hashed.")