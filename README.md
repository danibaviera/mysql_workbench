# 🎬 Movies Database Project (MySQL + Docker)

## 📌 Project Overview

This project consists of building a relational movie database using MySQL, with a many-to-many (N:N) relationship between movies and genres.

Before starting the database modeling, it was necessary to configure and run a MySQL server using Docker. The database only became accessible after the container was successfully running.

---

# 🐳 MySQL Setup with Docker Compose

To run MySQL locally, a Docker container was created using Docker Compose.

The following docker-compose.yml configuration was used :

version: "3.8"

services:
  mysql:
    image: mysql:8.0
    container_name: mysql8
    restart: unless-stopped

    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}

    ports:
      - "3306:3306"

    volumes:
      - mysql_data:/var/lib/mysql

    command: >
      --default-authentication-plugin=mysql_native_password
      --bind-address=0.0.0.0

    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}"]
      interval: 10s
      timeout: 5s
      retries: 10

volumes:
  mysql_data:

---

## 🚀 Environment Setup Steps

1. Created a project directory:

bash
mkdir mysql


2. Added the docker-compose.yml file inside the directory.

3. Opened the folder in Visual Studio Code.

4. Started the container with:

bash
docker compose up


5. After the container was running, MySQL became available on port *0000*.

6. Opened MySQL Workbench.

7. Created a new connection using:

   * Host: 127.0.0.1
   * Port: 0000
   * User: root
   * Password: "-"

Only after the Docker container was running was it possible to connect via MySQL Workbench and begin creating the database structure.

---

# 🗄 Database Structure

The project contains three main tables:

* tbl_movies
* tbl_genres
* tbl_movie_genres (junction table for N:N relationship)

## 🔗 Relationship Model

* A movie can have multiple genres.
* A genre can belong to multiple movies.
* Implemented using a composite primary key in the junction table.
---
# 🎬 Movie Catalog

Below is the catalog of the four movies inserted into the database:

| Title                | Release Year | Rating | Genres                          |
| -------------------- | ------------ | ------ | ------------------------------- |
| Se7en                | 1995         | 8.6    | Crime, Drama, Mystery, Thriller |
| Requiem for a Dream  | 2000         | 8.3    | Drama                           |
| Hooligans            | 2005         | 7.4    | Crime, Drama                    |
| Inglourious Basterds | 2009         | 8.3    | Action, Drama, War              |

---

# 🔍 Example Query (JOIN + GROUP_CONCAT)

sql
SELECT 
    m.title,
    m.release_year,
    m.rating,
    GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
FROM tbl_movies m
JOIN tbl_movie_genres mg ON m.id = mg.movie_id
JOIN tbl_genres g ON g.id = mg.genre_id
GROUP BY m.id, m.title, m.release_year, m.rating
ORDER BY m.release_year;


---

# 🧠 Technical Concepts Applied

* Relational database modeling
* Primary Keys
* Foreign Keys
* Many-to-Many (N:N) relationship
* Composite Primary Key
* GROUP_CONCAT aggregation
* Dockerized MySQL environment
* Container healthcheck configuration

---

# 📦 Technologies Used

* Docker
* Docker Compose
* MySQL 8
* MySQL Workbench
* Visual Studio Code

---

# 🎯 Project Purpose

This project demonstrates:

* Database modeling skills
* Understanding of relational integrity
* Practical use of Docker for local development
* SQL querying with JOIN and aggregation
* Clean project organization for version control

---

🚀 

---

*Author:* Danieli Baviera 
*Year:* 2026
