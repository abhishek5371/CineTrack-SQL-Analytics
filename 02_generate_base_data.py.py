import csv
from faker import Faker
import random

fake = Faker()

# 1. Generate movies.csv
# Columns: title, release_year, genre, rating, budget_used
with open('movies.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['title', 'release_year', 'genre', 'rating', 'budget_used'])
    genres = ['Action', 'Sci-Fi', 'Drama', 'Comedy', 'Horror', 'Documentary', 'Thriller']
    
    for _ in range(1000):
        writer.writerow([
            fake.catch_phrase(),             
            random.randint(1980, 2026),      
            random.choice(genres),           
            round(random.uniform(1.0, 10.0), 1), 
            random.randint(500000, 300000000) 
        ])

# 2. Generate actors.csv
# Columns: first_name, last_name, birth_year, nationality
with open('actors.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['first_name', 'last_name', 'birth_year', 'nationality'])
    
    for _ in range(500):
        writer.writerow([
            fake.first_name(),
            fake.last_name(),
            random.randint(1950, 2010),
            fake.country()
        ])

print("Success: 'movies.csv' and 'actors.csv' created in your folder!")