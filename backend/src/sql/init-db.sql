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
    UNIQUE (userId, articleId),
    FOREIGN KEY (userId) REFERENCES user(userId),
    FOREIGN KEY (articleId) REFERENCES article(articleId)
);

-- Insert mock data
INSERT INTO user (userName, password, email, firstName, lastName, dateOfBirth, avatar, isAdmin,isDeleted) VALUES
('john_doe', '$2b$12$Yv/Cb6.FKpK6CNZRvKrCBeTNjFK1pvyHMdcaCvXQBBmp1xZSxDpei', 'john.doe@example.com', 'John', 'Doe', '1985-06-15', '/images/avatar1.jpg', FALSE, FALSE),
('jane_smith', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'jane.smith@example.com', 'Jane', 'Smith', '1990-08-22', '/images/avatar2.jpg', TRUE, FALSE),
('alice_jones', '$2b$12$6Sdre8XSkFpHCp2sso/gLuKx7.ctyXkZc7PP546VlnCg4rCmGRVuq', 'alice.jones@example.com', 'Alice', 'Jones', '1978-12-05', '/images/avatar3.jpg', FALSE, FALSE),
('bob_brown', '$2b$12$9yuOvONQDqm5.YeITAd.L.FsyDhIblipXrl3vddN.BzjM1CWCsgIm', 'bob.brown@example.com', 'Bob', 'Brown', '1995-03-30', '/images/avatar4.jpg', FALSE, FALSE),
('john_snow', '$2b$12$6Sdre8XSkFpHCp2sso/gLuKx7.ctyXkZc7PP546VlnCg4rCmGRVuq', 'john.jones@example.com', 'John', 'Snow', '1978-12-05', '/images/avatar3.jpg', FALSE, FALSE);

-- Insert mock data into article table
INSERT INTO article (articleId, title, content, createDate, updateDate, imgUrl, userId) VALUES
(1, 'Understanding Flexbox: Everything you need to know', 'Flexbox is a powerful layout module...', '2024-01-01', '2024-01-02', 'img1.jpg', 1),
(2, 'CSS Grid Layout: A Step-by-Step Guide', 'CSS Grid Layout is a two-dimensional...', '2024-01-03', '2024-01-04', 'img2.jpg', 2),
(3, 'JavaScript ES6 Features: An Overview', 'ES6 brought many new features to JavaScript...', '2024-01-05', '2024-01-06', 'img3.jpg', 3),
(4, 'A Comprehensive Guide to HTML5', 'HTML5 is the latest evolution of the standard...', '2024-01-07', '2024-01-08', 'img4.jpg', 4),
(5, 'Building Responsive Websites with Bootstrap', 'Bootstrap is a popular framework for building...', '2024-01-09', '2024-01-10', 'img5.jpg', 5),
(6, 'Understanding Asynchronous JavaScript', 'Asynchronous JavaScript allows you to...', '2024-01-11', '2024-01-12', 'img6.jpg', 1),
(7, 'Mastering Python for Data Science', 'Python is a versatile language used in...', '2024-01-13', '2024-01-14', 'img7.jpg', 2),
(8, 'A Guide to React Hooks', 'React Hooks provide a way to use state...', '2024-01-15', '2024-01-16', 'img8.jpg', 3),
(9, 'Introduction to Node.js', 'Node.js is a JavaScript runtime built on...', '2024-01-17', '2024-01-18', 'img9.jpg', 4),
(10, 'Getting Started with Svelte', 'Svelte is a modern JavaScript framework...', '2024-01-19', '2024-01-20', 'img10.jpg', 5),
(11, 'Exploring the Vue.js Framework', 'Vue.js is a progressive JavaScript framework...', '2024-01-21', '2024-01-22', 'img11.jpg', 1),
(12, 'The Basics of TypeScript', 'TypeScript is a typed superset of JavaScript...', '2024-01-23', '2024-01-24', 'img12.jpg', 2),
(13, 'Understanding the Document Object Model (DOM)', 'The DOM is a programming interface...', '2024-01-25', '2024-01-26', 'img13.jpg', 3),
(14, 'Building Progressive Web Apps (PWAs)', 'Progressive Web Apps are web applications...', '2024-01-27', '2024-01-28', 'img14.jpg', 4),
(15, 'An Introduction to GraphQL', 'GraphQL is a query language for APIs...', '2024-01-29', '2024-01-30', 'img15.jpg', 5),
(16, 'Diving into Docker: A Beginner s Guide', 'Docker is a platform for developing...', '2024-02-01', '2024-02-02', 'img16.jpg', 1),
(17, 'Microservices Architecture: An Overview', 'Microservices architecture allows...', '2024-02-03', '2024-02-04', 'img17.jpg', 2),
(18, 'Introduction to Kubernetes', 'Kubernetes is an open-source system for...', '2024-02-05', '2024-02-06', 'img18.jpg', 3),
(19, 'Building RESTful APIs with Express.js', 'Express.js is a web application framework...', '2024-02-07', '2024-02-08', 'img19.jpg', 4),
(20, 'Understanding Web Security', 'Web security is a critical aspect of...', '2024-02-09', '2024-02-10', 'img20.jpg', 5),
(21, 'A Guide to Responsive Web Design', 'Responsive web design is an approach to...', '2024-02-11', '2024-02-12', 'img21.jpg', 1),
(22, 'Introduction to Machine Learning', 'Machine learning is a field of artificial...', '2024-02-13', '2024-02-14', 'img22.jpg', 2),
(23, 'Exploring the Django Framework', 'Django is a high-level Python web framework...', '2024-02-15', '2024-02-16', 'img23.jpg', 3),
(24, 'Getting Started with Angular', 'Angular is a platform for building...', '2024-02-17', '2024-02-18', 'img24.jpg', 4),
(25, 'The Basics of SQL and Databases', 'SQL is a standard language for managing...', '2024-02-19', '2024-02-20', 'img25.jpg', 5),
(26, 'Introduction to DevOps', 'DevOps is a set of practices that...', '2024-02-21', '2024-02-22', 'img26.jpg', 1),
(27, 'Building Mobile Apps with Flutter', 'Flutter is an open-source UI software...', '2024-02-23', '2024-02-24', 'img27.jpg', 2),
(28, 'Understanding Blockchain Technology', 'Blockchain is a distributed ledger...', '2024-02-25', '2024-02-26', 'img28.jpg', 3),
(29, 'A Guide to Cybersecurity', 'Cybersecurity involves protecting...', '2024-02-27', '2024-02-28', 'img29.jpg', 4),
(30, 'Introduction to Artificial Intelligence', 'Artificial intelligence (AI) is the...', '2024-03-01', '2024-03-02', 'img30.jpg', 5),
(31, 'Exploring the ASP.NET Core Framework', 'ASP.NET Core is a cross-platform...', '2024-03-03', '2024-03-04', 'img31.jpg', 1),
(32, 'Building Interactive Websites with jQuery', 'jQuery is a fast, small, and...', '2024-03-05', '2024-03-06', 'img32.jpg', 2),
(33, 'Getting Started with Laravel', 'Laravel is a web application framework...', '2024-03-07', '2024-03-08', 'img33.jpg', 3),
(34, 'A Comprehensive Guide to CSS Flexbox', 'CSS Flexbox is a layout model...', '2024-03-09', '2024-03-10', 'img34.jpg', 4),
(35, 'Understanding API Integration', 'API integration is the process of...', '2024-03-11', '2024-03-12', 'img35.jpg', 5),
(36, 'Introduction to Cloud Computing', 'Cloud computing is the delivery of...', '2024-03-13', '2024-03-14', 'img36.jpg', 1),
(37, 'Building Scalable Web Applications', 'Scalable web applications are designed...', '2024-03-15', '2024-03-16', 'img37.jpg', 2),
(38, 'Exploring WebAssembly', 'WebAssembly is a binary instruction...', '2024-03-17', '2024-03-18', 'img38.jpg', 3),
(39, 'A Guide to Software Testing', 'Software testing is a process of...', '2024-03-19', '2024-03-20', 'img39.jpg', 4),
(40, 'Understanding Continuous Integration', 'Continuous integration is a practice...', '2024-03-21', '2024-03-22', 'img40.jpg', 5),
(41, 'Building Serverless Applications', 'Serverless computing allows you...', '2024-03-23', '2024-03-24', 'img41.jpg', 1),
(42, 'Introduction to Big Data', 'Big data refers to data sets that are...', '2024-03-25', '2024-03-26', 'img42.jpg', 2),
(43, 'Getting Started with Elasticsearch', 'Elasticsearch is a search engine...', '2024-03-27', '2024-03-28', 'img43.jpg', 3),
(44, 'A Guide to API Security', 'API security is the practice of...', '2024-03-29', '2024-03-30', 'img44.jpg', 4),
(45, 'Understanding Agile Development', 'Agile development is a methodology...', '2024-03-31', '2024-04-01', 'img45.jpg', 5),
(46, 'Building Real-time Applications', 'Real-time applications respond to...', '2024-04-02', '2024-04-03', 'img46.jpg', 1),
(47, 'Introduction to NoSQL Databases', 'NoSQL databases provide a mechanism...', '2024-04-04', '2024-04-05', 'img47.jpg', 2),
(48, 'Exploring the Redux Library', 'Redux is a predictable state...', '2024-04-06', '2024-04-07', 'img48.jpg', 3),
(49, 'A Guide to Data Visualization', 'Data visualization is the graphical...', '2024-04-08', '2024-04-09', 'img49.jpg', 4),
(50, 'Understanding Event-Driven Architecture', 'Event-driven architecture is a...', '2024-04-10', '2024-04-11', 'img50.jpg', 5);


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