DROP USER IF EXISTS 'auth_user'@'localhost';
DROP USER IF EXISTS 'auth_user'@'%';
DROP USER IF EXISTS 'auth_user'@'mp3converter.com';

CREATE USER 'auth_user'@'%' IDENTIFIED BY 'auth';
GRANT ALL PRIVILEGES ON auth.* TO 'auth_user'@'%';

-- Specificamente per l'host mp3converter.com
CREATE USER 'auth_user'@'mp3converter.com' IDENTIFIED BY 'auth';
GRANT ALL PRIVILEGES ON auth.* TO 'auth_user'@'mp3converter.com';

-- CREATE DATABASE auth; 

USE auth;

CREATE TABLE user(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

INSERT INTO user (email, password) VALUES
('user@example.com', 'admin');