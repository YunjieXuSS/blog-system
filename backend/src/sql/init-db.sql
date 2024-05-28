-- This script is used to initialize the database with mock data for testing purposes.
-- It creates tables for users, articles, comments, and likes, and inserts mock data into these tables.

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
    isAdmin BOOLEAN DEFAULT FALSE NOT NULL
);

CREATE TABLE article(
    articleId INTEGER PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    createDate TIMESTAMP NOT NULL,
    updateDate TIMESTAMP NOT NULL,
    imgUrl VARCHAR(100),
    userId INTEGER NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE
);

CREATE TABLE comment(
    commentId INTEGER PRIMARY KEY,
    content TEXT NOT NULL,
    createDate TIMESTAMP NOT NULL,
    parentCommentId INTEGER,
    userId INTEGER NOT NULL,
    articleId INTEGER NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE,
    FOREIGN KEY (articleId) REFERENCES article(articleId) ON DELETE CASCADE,
    FOREIGN KEY (parentCommentId) REFERENCES comment(commentId) ON DELETE CASCADE
);

CREATE TABLE like(
    likeId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    articleId INTEGER NOT NULL,
    UNIQUE (userId, articleId),
    FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE,
    FOREIGN KEY (articleId) REFERENCES article(articleId) ON DELETE CASCADE
);

-- Insert mock data
INSERT INTO user (userName, password, email, firstName, lastName, dateOfBirth, avatar, isAdmin) VALUES
('john_doe', '$2b$12$Yv/Cb6.FKpK6CNZRvKrCBeTNjFK1pvyHMdcaCvXQBBmp1xZSxDpei', 'john.doe@example.com', 'John', 'Doe', '1985-06-15', '/images/avatar1.jpg', FALSE),
('jane_smith', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'jane.smith@example.com', 'Jane', 'Smith', '1990-08-22', '/images/avatar2.jpg', TRUE),
('alice_jones', '$2b$12$6Sdre8XSkFpHCp2sso/gLuKx7.ctyXkZc7PP546VlnCg4rCmGRVuq', 'alice.jones@example.com', 'Alice', 'Jones', '1978-12-05', '/images/avatar3.jpg', FALSE),
('bob_brown', '$2b$12$9yuOvONQDqm5.YeITAd.L.FsyDhIblipXrl3vddN.BzjM1CWCsgIm', 'bob.brown@example.com', 'Bob', 'Brown', '1995-03-30', '/images/avatar4.jpg', FALSE),
('john_snow', '$2b$12$6Sdre8XSkFpHCp2sso/gLuKx7.ctyXkZc7PP546VlnCg4rCmGRVuq', 'john.jones@example.com', 'John', 'Snow', '1978-12-05', '/images/avatar3.jpg', FALSE);

-- Insert mock data into article table
INSERT INTO article (articleId, title, content, createDate, updateDate, imgUrl, userId) VALUES
(1, 'Understanding Flexbox: Everything you need to know', 'Flexbox is a powerful layout module...', '2024-01-01 10:00:00', '2024-01-02 10:00:00', 'img1.jpg', 1),
(2, 'CSS Grid Layout: A Step-by-Step Guide', 'CSS Grid Layout is a two-dimensional...', '2024-01-03 10:00:00', '2024-01-04 10:00:00', 'img2.jpg', 2),
(3, 'JavaScript ES6 Features: An Overview', 'ES6 brought many new features to JavaScript...', '2024-01-05 10:00:00', '2024-01-06 10:00:00', 'img3.jpg', 3),
(4, 'A Comprehensive Guide to HTML5', 'HTML5 is the latest evolution of the standard...', '2024-01-07 10:00:00', '2024-01-08 10:00:00', 'img4.jpg', 4),
(5, 'Building Responsive Websites with Bootstrap', 'Bootstrap is a popular framework for building...', '2024-01-09 10:00:00', '2024-01-10 10:00:00', 'img5.jpg', 5),
(6, 'Understanding Asynchronous JavaScript', 'Asynchronous JavaScript allows you to...', '2024-01-11 10:00:00', '2024-01-12 10:00:00', 'img6.jpg', 1),
(7, 'Mastering Python for Data Science', 'Python is a versatile language used in...', '2024-01-13 10:00:00', '2024-01-14 10:00:00', 'img7.jpg', 2),
(8, 'A Guide to React Hooks', 'React Hooks provide a way to use state...', '2024-01-15 10:00:00', '2024-01-16 10:00:00', 'img8.jpg', 3),
(9, 'Introduction to Node.js', 'Node.js is a JavaScript runtime built on...', '2024-01-17 10:00:00', '2024-01-18 10:00:00', 'img9.jpg', 4),
(10, 'Getting Started with Svelte', 'Svelte is a modern JavaScript framework...', '2024-01-19 10:00:00', '2024-01-20 10:00:00', 'img10.jpg', 5),
(11, 'Exploring the Vue.js Framework', 'Vue.js is a progressive JavaScript framework...', '2024-01-21 10:00:00', '2024-01-22 10:00:00', 'img11.jpg', 1),
(12, 'The Basics of TypeScript', 'TypeScript is a typed superset of JavaScript...', '2024-01-23 10:00:00', '2024-01-24 10:00:00', 'img12.jpg', 2),
(13, 'Understanding the Document Object Model (DOM)', 'The DOM is a programming interface...', '2024-01-25 10:00:00', '2024-01-26 10:00:00', 'img13.jpg', 3),
(14, 'Building Progressive Web Apps (PWAs)', 'Progressive Web Apps are web applications...', '2024-01-27 10:00:00', '2024-01-28 10:00:00', 'img14.jpg', 4),
(15, 'An Introduction to GraphQL', 'GraphQL is a query language for APIs...', '2024-01-29 10:00:00', '2024-01-30 10:00:00', 'img15.jpg', 5),
(16, 'Diving into Docker: A Beginner s Guide', 'Docker is a platform for developing...', '2024-02-01 10:00:00', '2024-02-02 10:00:00', 'img16.jpg', 1),
(17, 'Microservices Architecture: An Overview', 'Microservices architecture allows...', '2024-02-03 10:00:00', '2024-02-04 10:00:00', 'img17.jpg', 2),
(18, 'Introduction to Kubernetes', 'Kubernetes is an open-source system for...', '2024-02-05 10:00:00', '2024-02-06 10:00:00', 'img18.jpg', 3),
(19, 'Building RESTful APIs with Express.js', 'Express.js is a web application framework...', '2024-02-07 10:00:00', '2024-02-08 10:00:00', 'img19.jpg', 4),
(20, 'Understanding Web Security', 'Web security is a critical aspect of...', '2024-02-09 10:00:00', '2024-02-10 10:00:00', 'img20.jpg', 5),
(21, 'A Guide to Responsive Web Design', 'Responsive web design is an approach to...', '2024-02-11 10:00:00', '2024-02-12 10:00:00', 'img21.jpg', 1),
(22, 'Introduction to Machine Learning', 'Machine learning is a field of artificial...', '2024-02-13 10:00:00', '2024-02-14 10:00:00', 'img22.jpg', 2),
(23, 'Exploring the Django Framework', 'Django is a high-level Python web framework...', '2024-02-15 10:00:00', '2024-02-16 10:00:00', 'img23.jpg', 3),
(24, 'Getting Started with Angular', 'Angular is a platform for building...', '2024-02-17 10:00:00', '2024-02-18 10:00:00', 'img24.jpg', 4),
(25, 'The Basics of SQL and Databases', 'SQL is a standard language for managing...', '2024-02-19 10:00:00', '2024-02-20 10:00:00', 'img25.jpg', 5),
(26, 'Introduction to DevOps', 'DevOps is a set of practices that...', '2024-02-21 10:00:00', '2024-02-22 10:00:00', 'img26.jpg', 1),
(27, 'Building Mobile Apps with Flutter', 'Flutter is an open-source UI software...', '2024-02-23 10:00:00', '2024-02-24 10:00:00', 'img27.jpg', 2),
(28, 'Understanding Blockchain Technology', 'Blockchain is a distributed ledger...', '2024-02-25 10:00:00', '2024-02-26 10:00:00', 'img28.jpg', 3),
(29, 'A Guide to Cybersecurity', 'Cybersecurity involves protecting...', '2024-02-27 10:00:00', '2024-02-28 10:00:00', 'img29.jpg', 4),
(30, 'Introduction to Artificial Intelligence', 'Artificial intelligence (AI) is the...', '2024-03-01 10:00:00', '2024-03-02 10:00:00', 'img30.jpg', 5),
(31, 'Exploring the ASP.NET Core Framework', 'ASP.NET Core is a cross-platform...', '2024-03-03 10:00:00', '2024-03-04 10:00:00', 'img31.jpg', 1),
(32, 'Building Interactive Websites with jQuery', 'jQuery is a fast, small, and...', '2024-03-05 10:00:00', '2024-03-06 10:00:00', 'img32.jpg', 2),
(33, 'Getting Started with Laravel', 'Laravel is a web application framework...', '2024-03-07 10:00:00', '2024-03-08 10:00:00', 'img33.jpg', 3),
(34, 'A Comprehensive Guide to CSS Flexbox', 'CSS Flexbox is a layout model...', '2024-03-09 10:00:00', '2024-03-10 10:00:00', 'img34.jpg', 4),
(35, 'Understanding API Integration', 'API integration is the process of...', '2024-03-11 10:00:00', '2024-03-12 10:00:00', 'img35.jpg', 5),
(36, 'Introduction to Cloud Computing', 'Cloud computing is the delivery of...', '2024-03-13 10:00:00', '2024-03-14 10:00:00', 'img36.jpg', 1),
(37, 'Building Scalable Web Applications', 'Scalable web applications are designed...', '2024-03-15 10:00:00', '2024-03-16 10:00:00', 'img37.jpg', 2),
(38, 'Exploring WebAssembly', 'WebAssembly is a binary instruction...', '2024-03-17 10:00:00', '2024-03-18 10:00:00', 'img38.jpg', 3),
(39, 'A Guide to Software Testing', 'Software testing is a process of...', '2024-03-19 10:00:00', '2024-03-20 10:00:00', 'img39.jpg', 4),
(40, 'Understanding Continuous Integration', 'Continuous integration is a practice...', '2024-03-21 10:00:00', '2024-03-22 10:00:00', 'img40.jpg', 5),
(41, 'Building Serverless Applications', 'Serverless computing allows you...', '2024-03-23 10:00:00', '2024-03-24 10:00:00', 'img41.jpg', 1),
(42, 'Introduction to Big Data', 'Big data refers to data sets that are...', '2024-03-25 10:00:00', '2024-03-26 10:00:00', 'img42.jpg', 2),
(43, 'Getting Started with Elasticsearch', 'Elasticsearch is a search engine...', '2024-03-27 10:00:00', '2024-03-28 10:00:00', 'img43.jpg', 3),
(44, 'A Guide to API Security', 'API security is the practice of...', '2024-03-29 10:00:00', '2024-03-30 10:00:00', 'img44.jpg', 4),
(45, 'Understanding Agile Development', 'Agile development is a methodology...', '2024-03-31 10:00:00', '2024-04-01 10:00:00', 'img45.jpg', 5),
(46, 'Building Real-time Applications', 'Real-time applications respond to...', '2024-04-02 10:00:00', '2024-04-03 10:00:00', 'img46.jpg', 1),
(47, 'Introduction to NoSQL Databases', 'NoSQL databases provide a mechanism...', '2024-04-04 10:00:00', '2024-04-05 10:00:00', 'img47.jpg', 2),
(48, 'Exploring the Redux Library', 'Redux is a predictable state...', '2024-04-06 10:00:00', '2024-04-07 10:00:00', 'img48.jpg', 3),
(49, 'A Guide to Data Visualization', 'Data visualization is the graphical...', '2024-04-08 10:00:00', '2024-04-09 10:00:00', 'img49.jpg', 4),
(50, 'Understanding Event-Driven Architecture', 'Event-driven architecture is a...', '2024-04-10 10:00:00', '2024-04-11 10:00:00', 'img50.jpg', 5);




-- Insert mock data into comment table
INSERT INTO comment (content, createDate, parentCommentId, userId, articleId) VALUES
-- First article
('First comment on first article.', '2024-01-02 10:00:00', NULL, 2, 1),
('Reply to first comment on first article.', '2024-01-02 12:00:00', 1, 3, 1),
('Another reply to first comment on first article.', '2024-01-02 14:00:00', 1, 4, 1),
('Reply to the second comment on first article.', '2024-01-03 10:00:00', 2, 5, 1),
('Interesting perspective on Flexbox!', '2024-01-02 11:00:00', NULL, 4, 1),
('Reply to interesting perspective on Flexbox!', '2024-01-02 12:30:00', 5, 3, 1),
('Third level reply on interesting perspective on Flexbox!', '2024-01-02 13:00:00', 6, 5, 1),
('More comments on first article.', '2024-01-03 14:00:00', NULL, 2, 1),
('Another comment on first article.', '2024-01-04 09:00:00', NULL, 3, 1),
('Follow-up comment on first article.', '2024-01-04 10:00:00', NULL, 4, 1),
('Reply to follow-up comment.', '2024-01-04 11:00:00', 10, 5, 1),
('Another reply to follow-up comment.', '2024-01-04 12:00:00', 10, 2, 1),
('Discussion on first article.', '2024-01-05 08:00:00', NULL, 3, 1),
('Further discussion on first article.', '2024-01-05 09:00:00', NULL, 4, 1),
('Insightful comment on first article.', '2024-01-06 10:00:00', NULL, 5, 1),
('Reply to insightful comment.', '2024-01-06 11:00:00', 15, 2, 1),
('Question about first article.', '2024-01-06 12:00:00', NULL, 3, 1),
('Answer to question about first article.', '2024-01-06 13:00:00', 17, 4, 1),
('Another answer to question about first article.', '2024-01-06 14:00:00', 17, 5, 1),
('Final comment on first article.', '2024-01-07 09:00:00', NULL, 2, 1),

-- other articles
('First comment on second article.', '2024-01-06 10:00:00', NULL, 1, 2),
('Reply to first comment on second article.', '2024-01-06 11:00:00', 21, 2, 2),
('I found this guide very helpful. Thanks!', '2024-01-04 14:30:00', NULL, 5, 2),
('Reply to helpful guide comment.', '2024-01-04 15:00:00', 23, 1, 2),
('Great overview of ES6 features.', '2024-01-05 12:45:00', NULL, 2, 3),
('Reply to ES6 overview.', '2024-01-05 13:15:00', 25, 3, 3),
('I had trouble with HTML5 forms, but this helped.', '2024-01-08 09:20:00', NULL, 3, 4),
('Bootstrap is my go-to framework for responsive design.', '2024-01-10 16:10:00', NULL, 1, 5),
('Reply to Bootstrap comment.', '2024-01-10 16:45:00', 29, 4, 5),
('Asynchronous JavaScript can be tricky, but this article simplifies it.', '2024-01-12 18:05:00', NULL, 2, 6),
('Python is indeed versatile. Great read!', '2024-01-13 13:55:00', NULL, 3, 7),
('Hooks make React so much easier to manage.', '2024-01-16 15:30:00', NULL, 4, 8),
('Reply to React Hooks comment.', '2024-01-16 16:00:00', 35, 5, 8),
('Node.js is powerful for server-side development.', '2024-01-18 17:40:00', NULL, 5, 9),
('Svelte is an interesting framework. Need to try it out.', '2024-01-20 11:50:00', NULL, 1, 10),
('Reply to Svelte comment.', '2024-01-20 12:15:00', 39, 2, 10),
('Vue.js has been great for my projects.', '2024-01-22 14:20:00', NULL, 2, 11),
('TypeScript has improved my code quality significantly.', '2024-01-24 19:00:00', NULL, 3, 12),
('Understanding the DOM is crucial for web development.', '2024-01-26 10:10:00', NULL, 4, 13),
('Reply to DOM understanding comment.', '2024-01-26 10:40:00', 43, 5, 13),
('PWAs are the future of mobile web apps.', '2024-01-28 14:55:00', NULL, 5, 14),
('GraphQL looks promising for API development.', '2024-01-30 16:20:00', NULL, 1, 15),
('Docker has revolutionized my deployment process.', '2024-02-02 09:30:00', NULL, 2, 16),
('Reply to Docker comment.', '2024-02-02 10:00:00', 47, 3, 16),
('Microservices architecture is complex but worth it.', '2024-02-04 17:00:00', NULL, 3, 17),
('Kubernetes is powerful but has a steep learning curve.', '2024-02-06 14:40:00', NULL, 4, 18),
('Reply to Kubernetes comment.', '2024-02-06 15:15:00', 51, 5, 18),
('Express.js makes building APIs straightforward.', '2024-02-08 10:25:00', NULL, 5, 19),
('Web security is more important than ever.', '2024-02-10 12:15:00', NULL, 1, 20),
('Reply to web security comment.', '2024-02-10 12:45:00', 55, 2, 20),
('Responsive design is a must for modern websites.', '2024-02-12 15:45:00', NULL, 2, 21),
('Machine learning is a fascinating field.', '2024-02-14 18:55:00', NULL, 3, 22),
('Django is a robust framework for web development.', '2024-02-16 20:30:00', NULL, 4, 23),
('Reply to Django comment.', '2024-02-16 21:00:00', 59, 5, 23),
('Angular offers great tooling for large projects.', '2024-02-18 13:35:00', NULL, 5, 24),
('SQL knowledge is fundamental for any developer.', '2024-02-20 11:45:00', NULL, 1, 25),
('DevOps practices have streamlined my workflow.', '2024-02-22 16:20:00', NULL, 2, 26),
('Reply to DevOps comment.', '2024-02-22 16:50:00', 63, 3, 26),
('Flutter is excellent for cross-platform app development.', '2024-02-24 14:10:00', NULL, 3, 27),
('Blockchain technology has many potential applications.', '2024-02-26 19:25:00', NULL, 4, 28),
('Cybersecurity is a growing concern for businesses.', '2024-02-28 10:00:00', NULL, 5, 29),
('Reply to Cybersecurity comment.', '2024-02-28 10:30:00', 67, 1, 29),
('AI is transforming various industries.', '2024-03-02 15:15:00', NULL, 1, 30),
('ASP.NET Core is versatile and powerful.', '2024-03-04 18:30:00', NULL, 2, 31),
('jQuery still has its place in modern web development.', '2024-03-06 10:50:00', NULL, 3, 32),
('Laravel has made PHP development enjoyable.', '2024-03-08 13:40:00', NULL, 4, 33),
('Flexbox simplifies CSS layout tasks.', '2024-03-10 17:20:00', NULL, 5, 34),
('API integration is essential for modern applications.', '2024-03-12 12:35:00', NULL, 1, 35),
('Cloud computing has changed how we develop applications.', '2024-03-14 14:45:00', NULL, 2, 36),
('Scalability is key for web applications.', '2024-03-16 16:50:00', NULL, 3, 37),
('WebAssembly opens new possibilities for web development.', '2024-03-18 11:05:00', NULL, 4, 38),
('Software testing is critical for quality assurance.', '2024-03-20 13:15:00', NULL, 5, 39),
('Continuous integration improves development efficiency.', '2024-03-22 15:25:00', NULL, 1, 40),
('Serverless architecture simplifies deployment.', '2024-03-24 18:35:00', NULL, 2, 41),
('Big data analytics provide valuable insights.', '2024-03-26 10:45:00', NULL, 3, 42),
('Elasticsearch is great for search functionality.', '2024-03-28 13:55:00', NULL, 4, 43);


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