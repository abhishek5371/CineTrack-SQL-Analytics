import mysql.connector
import random

# 1. Connect to your local MySQL
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="jB4uVktcVB@22",
    database="cinetrack_db"
)

cursor = db.cursor()

try:
    # 2. Get valid IDs from your database
    cursor.execute("SELECT movie_id FROM movies")
    movie_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT actor_id FROM actors")
    actor_ids = [row[0] for row in cursor.fetchall()]

    # 3. Create the "Casting" logic
    roles = ['Lead', 'Supporting', 'Cameo', 'Villain', 'Extra']
    cast_data = []

    for m_id in movie_ids:
        # Every movie gets 3-5 random actors
        num_actors = random.randint(3, 5)
        chosen_actors = random.sample(actor_ids, num_actors)
        
        for a_id in chosen_actors:
            role = random.choice(roles)
            cast_data.append((m_id, a_id, role))

    # 4. Insert into movie_cast
    # INSERT IGNORE ensures no duplicate (Movie, Actor) pairs are added
    sql = "INSERT IGNORE INTO movie_cast (movie_id, actor_id, role_name) VALUES (%s, %s, %s)"
    cursor.executemany(sql, cast_data)
    
    db.commit()
    print(f"Success! Linked {cursor.rowcount} actor-movie pairs.")

except Exception as e:
    print(f"Error: {e}")
finally:
    cursor.close()
    db.close()