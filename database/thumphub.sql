-- Create Users table
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL
);

-- Insert sample data into Users
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan1', 'bass1@email.com', 'hashedpass1');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan2', 'bass2@email.com', 'hashedpass2');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan3', 'bass3@email.com', 'hashedpass3');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan4', 'bass4@email.com', 'hashedpass4');
INSERT INTO Users (username, email, password_hash) VALUES ('bassfan5', 'bass5@email.com', 'hashedpass5');