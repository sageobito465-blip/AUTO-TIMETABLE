"""
ONE-TIME MIGRATION SCRIPT - DO NOT RUN AGAIN
----------------------------------------------
This script was used once to convert existing plain-text passwords
into secure hashes, after password hashing was added to the app.

Running this again would re-hash already-hashed passwords, breaking
every user's login. It is kept here only as a reference for how the
original migration was done.
"""

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