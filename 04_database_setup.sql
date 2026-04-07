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