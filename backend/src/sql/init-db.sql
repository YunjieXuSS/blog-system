-- This script is used to initialize the database with mock data for testing purposes.
-- It creates tables for users, articles, comments, and likes, and inserts mock data into these tables.
-- Need to be modified later: 
-- 1. user password should be hashed
-- 2. user avatar should be stored in the server and the path should be stored in the database

DROP TABLE IF EXISTS like;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS user;

-- Create tables
CREATE TABLE user (
    userId INTEGER PRIMARY KEY,
    userName VARCHAR(64) UNIQUE NOT NULL,
    password VARCHAR(60) NOT NULL,
    email VARCHAR(64) NOT NULL,
    firstName VARCHAR(64) NOT NULL,
    lastName VARCHAR(64) NOT NULL,
    dateOfBirth DATE NOT NULL,
    description TEXT  DEFAULT "I know myself so well." NOT NULL,
    avatar VARCHAR(100),
    isAdmin BOOLEAN NOT NULL
);

CREATE TABLE article(
    articleId INTEGER PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    createDate DATE NOT NULL,
    updateDate DATE NOT NULL,
    imgUrl VARCHAR(100),
    userId INTEGER NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(userId)
);

CREATE TABLE comment(
    commentId INTEGER PRIMARY KEY,
    content TEXT NOT NULL,
    createDate DATE NOT NULL,
    parentCommentId INTEGER,
    userId INTEGER NOT NULL,
    articleId INTEGER NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(userId),
    FOREIGN KEY (articleId) REFERENCES article(articleId),
    FOREIGN KEY (parentCommentId) REFERENCES comment(commentId)
);

CREATE TABLE like(
    likeId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    articleId INTEGER NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(userId),
    FOREIGN KEY (articleId) REFERENCES article(articleId)
);

-- Insert mock data
INSERT INTO user (userId, userName, password, email, firstName, lastName, dateOfBirth, description, avatar, isAdmin) VALUES
(1, 'john_doe', 'hashed_password1', 'john.doe@example.com', 'John', 'Doe', '1985-06-15', 'I know myself so well.', 'avatar1.jpg', FALSE),
(2, 'jane_smith', 'hashed_password2', 'jane.smith@example.com', 'Jane', 'Smith', '1990-08-22', 'I know myself so well.', 'avatar2.jpg', TRUE),
(3, 'alice_jones', 'hashed_password3', 'alice.jones@example.com', 'Alice', 'Jones', '1978-12-05', 'I know myself so well.', 'avatar3.jpg', FALSE),
(4, 'bob_brown', 'hashed_password4', 'bob.brown@example.com', 'Bob', 'Brown', '1995-03-30', 'I know myself so well.', 'avatar4.jpg', FALSE);

-- Insert mock data into article table
INSERT INTO article (articleId, title, content, createDate, updateDate, imgUrl, userId) VALUES
(1, 'First Article', 'Content of the first article.', '2024-01-01', '2024-01-01', 'img1.jpg', 1),
(2, 'Second Article', 'Content of the second article.', '2024-01-05', '2024-01-06', 'img2.jpg', 2),
(3, 'Third Article', 'Content of the third article.', '2024-01-10', '2024-01-11', 'img3.jpg', 3),
(4, 'Fourth Article', 'Content of the fourth article.', '2024-01-15', '2024-01-15', 'img4.jpg', 4);

-- Insert mock data into comment table
INSERT INTO comment (commentId, content, createDate, parentCommentId, userId, articleId) VALUES
(1, 'First comment on first article.', '2024-01-02', NULL, 2, 1),
(2, 'Second comment on first article.', '2024-01-03', 1, 3, 1),
(3, 'First comment on second article.', '2024-01-06', NULL, 1, 2),
(4, 'First comment on third article.', '2024-01-11', 2, 2, 3);

-- Insert mock data into like table
INSERT INTO like (likeId, userId, articleId) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 3),
(5, 1, 4),
(6, 2, 3),
(7, 3, 4),
(8, 4, 1);