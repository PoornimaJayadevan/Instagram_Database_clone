CREATE DATABASE INSTA;
USE INSTA;

CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
    username varchar(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
    );
    
CREATE TABLE photos(
		id INT PRIMARY KEY AUTO_INCREMENT,
        image_url VARCHAR(255) NOT NULL,
        user_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        FOREIGN KEY (user_id) REFERENCES users(id)
        );
CREATE TABLE comments(
			id INT PRIMARY KEY AUTO_INCREMENT,
            comment_text VARCHAR(255) NOT NULL,
            user_id INT NOT NULL,
            photo_id INT NOT NULL,
            created_at TIMESTAMP DEFAULT NOW(),
            FOREIGN KEY (user_id) REFERENCES users(id),
            FOREIGN KEY (photo_id) REFERENCES photos(id)
            );
CREATE TABLE likes(
                user_id INT NOT NULL,
                photo_id INT NOT NULL,
                created_at TIMESTAMP DEFAULT NOW(),
                FOREIGN KEY (user_id) REFERENCES users(id),
				FOREIGN KEY (photo_id) REFERENCES photos(id),
                PRIMARY KEY(user_id, photo_id) #making sure the combiantion is unique
                );
CREATE TABLE follows(
					follower_id INT,
                    followee_id INT,
                    created_at TIMESTAMP DEFAULT NOW(),
                    FOREIGN KEY (follower_id) REFERENCES users(id),
					FOREIGN KEY (followee_id) REFERENCES users(id),
                    PRIMARY KEY(follower_id, followee_id)
                    );
CREATE TABLE tags(
				id INT PRIMARY KEY AUTO_INCREMENT,
                tag_name VARCHAR(255) UNIQUE,
                created_at TIMESTAMP DEFAULT NOW()
                );
CREATE TABLE photo_tags(
					photo_id INT NOT NULL,
                    tag_id INT NOT NULL,
                    FOREIGN KEY (photo_id) REFERENCES photos(id),
                    FOREIGN KEY (tag_id) REFERENCES tags(id),
                    PRIMARY KEY(photo_id, tag_id)
                    );
                    
                
                