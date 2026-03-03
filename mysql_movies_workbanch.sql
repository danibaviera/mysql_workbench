CREATE DATABASE IF NOT EXISTS db_movies;
USE db_movies;

CREATE TABLE IF NOT EXISTS tbl_genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- Create index to improve performance in searches by name
CREATE INDEX idx_genre_name ON tbl_genres(name);

INSERT INTO tbl_genres (name, description) VALUES
('Action', 'Movies with intense scenes, fights, and chases'),
('Adventure', 'Stories involving journeys, exploration, and challenges'),
('Animation', 'Animated productions'),
('Biography', 'Based on the life of real people'),
('Comedy', 'Movies focused on humor'),
('Crime', 'Narratives involving crime and investigation'),
('Documentary', 'Based on real facts or historical events'),
('Drama', 'Emotional and realistic narratives'),
('Family', 'Movies suitable for all ages'),
('Fantasy', 'Magical elements and imaginary worlds'),
('Historical', 'Based on historical events'),
('Horror', 'Movies that create fear or tension'),
('Musical', 'Movies featuring music and choreography'),
('Mystery', 'Plots involving investigation and enigmas'),
('Romance', 'Stories focused on romantic relationships'),
('Science Fiction', 'Fiction based on science and technology'),
('Sport', 'Narratives centered around sports'),
('Thriller', 'Psychological suspense and constant tension'),
('War', 'Movies set during wartime'),
('Western', 'Stories set in the American Old West');

CREATE TABLE IF NOT EXISTS tbl_movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    release_year YEAR,
    duration_minutes INT,
    rating DECIMAL(3,1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*
  Junction table to implement the many-to-many (N:N) relationship 
  between movies and genres.

  A movie can have multiple genres.
  A genre can belong to multiple movies.

  The composite primary key (movie_id, genre_id)
  prevents duplicate relationships.
*/
CREATE TABLE IF NOT EXISTS tbl_movie_genres (
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    
    PRIMARY KEY (movie_id, genre_id),
    
    CONSTRAINT fk_movie
        FOREIGN KEY (movie_id) 
        REFERENCES tbl_movies(id)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_genre
        FOREIGN KEY (genre_id) 
        REFERENCES tbl_genres(id)
        ON DELETE CASCADE
);

SHOW TABLES;

SELECT 
    m.title,
    m.release_year,
    m.rating,
    GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
FROM tbl_movies m
JOIN tbl_movie_genres mg ON m.id = mg.movie_id
JOIN tbl_genres g ON g.id = mg.genre_id
WHERE m.title IN (
    'Hooligans',
    'Inglourious Basterds',
    'Requiem for a Dream',
    'Se7en'
)
GROUP BY m.id, m.title, m.release_year, m.rating
ORDER BY m.release_year;

