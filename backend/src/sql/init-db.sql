-- This script is used to initialize the database with mock data for testing purposes.
-- It creates tables for users, articles, comments, and likes, and inserts mock data into these tables.
-- Need to be modified later: 
-- 1. user password should be hashed
-- 2. user avatar should be stored in the server and the path should be stored in the database
--testing 
DROP TABLE IF EXISTS like;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS user;

-- Create tables
CREATE TABLE user (
    userId INTEGER PRIMARY KEY,
    userName VARCHAR(64) UNIQUE NOT NULL,
    password VARCHAR(64) NOT NULL,
    email VARCHAR(64) NOT NULL,
    firstName VARCHAR(64) NOT NULL,
    lastName VARCHAR(64) NOT NULL,
    dateOfBirth DATE NOT NULL,
    description TEXT  DEFAULT "I know myself so well." NOT NULL,
    avatar VARCHAR(100),
    isAdmin BOOLEAN NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE NOT NULL
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
INSERT INTO user (userName, password, email, firstName, lastName, dateOfBirth, avatar, isAdmin,isDeleted) VALUES
('john_doe', '$2b$12$Yv/Cb6.FKpK6CNZRvKrCBeTNjFK1pvyHMdcaCvXQBBmp1xZSxDpei', 'john.doe@example.com', 'John', 'Doe', '1985-06-15', '/images/avatar1.jpg', FALSE, FALSE),
('jane_smith', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'jane.smith@example.com', 'Jane', 'Smith', '1990-08-22', '/images/avatar2.jpg', TRUE, FALSE),
('alice_jones', '$2b$12$6Sdre8XSkFpHCp2sso/gLuKx7.ctyXkZc7PP546VlnCg4rCmGRVuq', 'alice.jones@example.com', 'Alice', 'Jones', '1978-12-05', '/images/avatar3.jpg', FALSE, FALSE),
('bob_brown', '$2b$12$9yuOvONQDqm5.YeITAd.L.FsyDhIblipXrl3vddN.BzjM1CWCsgIm', 'bob.brown@example.com', 'Bob', 'Brown', '1995-03-30', '/images/avatar4.jpg', FALSE, FALSE);

-- Insert mock data into article table
INSERT INTO article (title, content, createDate, updateDate, imgUrl, userId) VALUES
('First Article', 'Content of the first article.', '2024-01-01', '2024-01-01', '/images/img1.jpg', 1),
('Second Article', 'Content of the second article.', '2024-01-05', '2024-01-06', '/images/img2.jpg', 2),
('Third Article', 'Content of the third article.', '2024-01-10', '2024-01-11', '/images/img3.jpg', 3),
('Fourth Article', 'Content of the fourth article.', '2024-01-15', '2024-01-15', '/images/img4.jpg', 4);

-- Insert mock data into comment table
INSERT INTO comment (content, createDate, parentCommentId, userId, articleId) VALUES
('First comment on first article.', '2024-01-02', NULL, 2, 1),
('Second comment on first article.', '2024-01-03', 1, 3, 1),
('First comment on second article.', '2024-01-06', NULL, 1, 2),
('First comment on third article.', '2024-01-11', 2, 2, 3);

-- Insert mock data into like table
INSERT INTO like (userId, articleId) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(1, 4),
(2, 3),
(3, 4),
(4, 1);