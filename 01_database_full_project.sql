create database cinetrack_db;
use cinetrack_db;

show tables;

create table movies(
movie_id int primary key auto_increment,
title varchar(200) not null,
release_year int,
genre varchar(50),
rating decimal (3,1) check (rating <=10 and rating >= 0.0),
budget_used decimal (15,2),
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);

create table actors(
actor_id int primary key auto_increment,
first_name varchar(100),
last_name varchar(100),
birth_year int,
nationality varchar(50),
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp
);

create table movie_cast(
movie_id int,
actor_id int,
role_name varchar(100),
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
primary key(movie_id,actor_id),
foreign key (movie_id) references movies(movie_id) on delete cascade,
foreign key (actor_id) references actors(actor_id) on delete cascade
);

select * from actors;
select * from movies;
select * from movie_cast;

-- Section 1 EASY

select * from movies;
select title from movies;
select title, rating from movies;
select * from movies order by budget_used desc limit 5;
select * from movies order by release_year asc limit 10;
select * from movies where genre = "Action";
select * from movies where release_year = 2024;
select * from movies where rating = 10.0; 
select * from movies where budget_used < 1000000;
select * from movies where genre != "Horror";
select * from actors where nationality = 'United States';
select * from actors order by birth_year desc limit 5;
select * from actors where birth_year < 1990;
select distinct nationality from actors;
select * from movies where genre = "Sci-Fi" and release_year > 2020;
select * from movies where genre = "Drama" or genre = "Comedy";
select * from movies where rating > 8.5 and budget_used < 5000000;
select * from movies where genre = "Horror" order by rating desc limit 3;
select * from actors where nationality != "India" and  nationality != "USA";
select * from movies where date(created_at) = current_date();
select * from actors order by updated_at desc limit 5;
select * from movies where budget_used is NULL or budget_used = 0;
select * from movies where length(title) = 10;
select count(*) from movies where Genre = "Documentary";

-- Section 2 Intermediate Questions

select * from movies where title like "%Action%" or title like "%Star%";
select * from movies where title like "The%";
select * from movies where title like "%s";
select first_name,last_name, concat(first_name," ",last_name) as full_name from actors;
select concat(left(title,15), "...") as preview from movies;
select avg(rating) from movies;
select sum(budget_used) from movies;
select max(rating), min(rating) from movies;
select genre, count(*) as total_movies from movies group by genre;
select genre,avg(budget_used) from movies where genre = "Sci-Fi" group by genre;
select * from actors where length(first_name) = 6;
select upper(title) from movies;
select * from movies where release_year between 2015 and 2025;
select * from movies where rating between 6.5 and 8.5;
select last_name,length(last_name) from actors;
select * from movies where (genre = "Action" or genre = "Comedy") and rating > 7.0;
select genre, avg(rating) from movies group by genre;
select genre, sum(budget_used) from movies group by genre having sum(budget_used) > 100000000;
select release_year,count(*) as total_number from movies group by release_year order by total_number desc limit 3;
select replace(genre, "Sci-Fi", "Science Fiction") from movies;
select * from actors where last_name like "%man%";
select title, round(rating) from movies;
select title, (10-rating) as points_to_perfect from movies;
select title, monthname(created_at) from movies;
select genre, max(budget_used) from movies group by genre;

-- Section 3 Advanced Relational Logic

select m.title, a.first_name, a.last_name from movies as m join movie_cast as mc on m.movie_id = mc.movie_id join actors as a on mc.actor_id = a.actor_id;
select distinct a.first_name, a.last_name from actors a join movie_cast mc on a.actor_id = mc.actor_id where mc.role_name = 'lead';
select m.title, count(mc.actor_id) as cast_count from movies m left join movie_cast mc on m.movie_id = mc.movie_id group by m.movie_id, m.title;
select distinct a.first_name, a.last_name from actors a join movie_cast mc on a.actor_id = mc.actor_id join movies m on mc.movie_id = m.movie_id where m.genre = 'action';
select distinct m.title from movies m join movie_cast mc on m.movie_id = mc.movie_id join actors a on mc.actor_id = a.actor_id where a.last_name = 'smith';
select sum(m.budget_used) from movies m join movie_cast mc on m.movie_id = mc.movie_id where mc.actor_id = 10;
select m.title from movies m join movie_cast mc on m.movie_id = mc.movie_id group by m.movie_id, m.title having count(mc.actor_id) > 5;
select a.first_name, a.last_name from actors a join movie_cast mc on a.actor_id = mc.actor_id join movies m on mc.movie_id = m.movie_id where m.genre in ('sci-fi', 'drama') group by a.actor_id, a.first_name, a.last_name having count(distinct m.genre) = 2;
select m.title, mc.role_name from movies m join movie_cast mc on m.movie_id = mc.movie_id join actors a on mc.actor_id = a.actor_id where a.first_name = 'john' and a.last_name = 'doe';
select avg(m.rating) from movies m join movie_cast mc on m.movie_id = mc.movie_id where mc.role_name = 'supporting';
select first_name, last_name from actors where actor_id not in (select mc.actor_id from movie_cast mc join movies m on mc.movie_id = m.movie_id where m.genre = 'comedy');
select role_name, count(*) as role_frequency from movie_cast group by role_name order by role_frequency desc limit 3;
select title, genre, budget_used from movies where (genre, budget_used) in (select genre, max(budget_used) from movies group by genre);
select a.first_name, a.last_name from actors a join movie_cast mc on a.actor_id = mc.actor_id group by a.actor_id, a.first_name, a.last_name having count(mc.movie_id) > 5;
select m.title, min(a.birth_year) as oldest_actor_birth_year from movies m join movie_cast mc on m.movie_id = mc.movie_id join actors a on mc.actor_id = a.actor_id group by m.movie_id, m.title;
select distinct m.title from movies m join movie_cast mc on m.movie_id = mc.movie_id where m.release_year > 2020 and mc.role_name = 'villain';
select a.first_name, a.last_name, avg(m.budget_used) from actors a join movie_cast mc on a.actor_id = mc.actor_id join movies m on mc.movie_id = m.movie_id group by a.actor_id, a.first_name, a.last_name;
select m.title from movies m left join movie_cast mc on m.movie_id = mc.movie_id where mc.movie_id is null;
select distinct concat(a.first_name, ' ', a.last_name) as full_name from actors a join movie_cast mc on a.actor_id = mc.actor_id join movies m on mc.movie_id = m.movie_id where m.rating > 9.0;
select count(distinct mc.actor_id) as horror_actor_count from movie_cast mc join movies m on mc.movie_id = m.movie_id where m.genre = 'horror';
select distinct m.title from movies m join movie_cast mc on m.movie_id = mc.movie_id join actors a on mc.actor_id = a.actor_id where a.birth_year > 2001;
select m.genre, count(*) as genre_count from movies m join movie_cast mc on m.movie_id = mc.movie_id where mc.actor_id = 50 group by m.genre order by genre_count desc limit 1;
select m.title, a.first_name, a.last_name from movies m join movie_cast mc on m.movie_id = mc.movie_id join actors a on mc.actor_id = a.actor_id where mc.role_name = 'cameo';
select a.first_name, a.last_name, sum(m.rating) as star_power from actors a join movie_cast mc on a.actor_id = mc.actor_id join movies m on mc.movie_id = m.movie_id group by a.actor_id, a.first_name, a.last_name;
select distinct a.first_name, a.last_name from actors a join movie_cast mc on a.actor_id = mc.actor_id where mc.movie_id in (select movie_id from movie_cast where actor_id = 1) and a.actor_id != 1;

-- Section 4 Maintenance and business intelligence 

update movies set rating = 9.5 where movie_id = 1;
update movies set budget_used = budget_used * 1.10 where genre = 'action';
delete from movies where rating < 2.0;
select title, rating, case when rating > 7.0 then 'hit' else 'flop' end as status from movies;
select first_name, last_name, case when birth_year < 1980 then 'veteran' else 'newcomer' end as actor_type from actors;
select count(*) from movies where budget_used is null or budget_used = 0;
select title, case when budget_used < 1000000 then 'low' when budget_used between 1000000 and 10000000 then 'medium' else 'high' end as budget_tier from movies;
select * from actors order by created_at desc limit 5;
select first_name, last_name, (2026 - birth_year) as current_age from actors;
select release_year, avg(rating) from movies group by release_year;
select genre, avg(budget_used) from movies group by genre having avg(budget_used) > 50000000;
delete from movie_cast where actor_id = 500;
select nationality, count(*) as count from actors group by nationality order by count desc;
select title, length(title) from movies;
select * from movies order by rating desc limit 1 offset 1;
select m.title, group_concat(concat(a.first_name, ' ', a.last_name)) as cast_list from movies m join movie_cast mc on m.movie_id = mc.movie_id join actors a on mc.actor_id = a.actor_id group by m.movie_id;
select sum(budget_used) from movies where release_year >= 2021;
update movies set genre = 'science fiction' where genre = 'sci-fi';
select * from actors where left(first_name, 1) = right(first_name, 1);
select (count(*) * 100.0 / (select count(*) from movies)) as horror_percentage from movies where genre = 'horror';
select * from movies where title like '% % % %';
select title as film_name, release_year as debut_year from movies;
select (max(budget_used) - min(budget_used)) as budget_gap from movies where genre = 'drama';
select * from actors where actor_id % 2 != 0;
select 'movies' as table_name, count(*) as total from movies union select 'actors', count(*) from actors union select 'movie_cast', count(*);
