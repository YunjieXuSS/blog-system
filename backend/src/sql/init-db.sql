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
    FOREIGN KEY (userId) REFERENCES user(userId)
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
    FOREIGN KEY (parentCommentId) REFERENCES comment(commentId)
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
(1, 'Understanding Flexbox: Everything you need to know', 'Flexbox is a powerful layout module...', 1704103200000, 1704189600000, 'img1.jpg', 1),
(2, 'CSS Grid Layout: A Step-by-Step Guide', 'CSS Grid Layout is a two-dimensional...', 1704276000000, 1704362400000, 'img2.jpg', 2),
(3, 'JavaScript ES6 Features: An Overview', 'ES6 brought many new features to JavaScript...', 1704448800000, 1704535200000, 'img3.jpg', 3),
(4, 'A Comprehensive Guide to HTML5', 'HTML5 is the latest evolution of the standard...', 1704621600000, 1704708000000, 'img4.jpg', 4),
(5, 'Building Responsive Websites with Bootstrap', 'Bootstrap is a popular framework for building...', 1704794400000, 1704880800000, 'img5.jpg', 5),
(6, 'Understanding Asynchronous JavaScript', 'Asynchronous JavaScript allows you to...', 1704967200000, 1705053600000, 'img6.jpg', 1),
(7, 'Mastering Python for Data Science', 'Python is a versatile language used in...', 1705140000000, 1705226400000, 'img7.jpg', 2),
(8, 'A Guide to React Hooks', 'React Hooks provide a way to use state...', 1705312800000, 1705399200000, 'img8.jpg', 3),
(9, 'Introduction to Node.js', 'Node.js is a JavaScript runtime built on...', 1705485600000, 1705572000000, 'img9.jpg', 4),
(10, 'Getting Started with Svelte', 'Svelte is a modern JavaScript framework...', 1705658400000, 1705744800000, 'img10.jpg', 5),
(11, 'Exploring the Vue.js Framework', 'Vue.js is a progressive JavaScript framework...', 1705831200000, 1705917600000, 'img11.jpg', 1),
(12, 'The Basics of TypeScript', 'TypeScript is a typed superset of JavaScript...', 1706004000000, 1706090400000, 'img12.jpg', 2),
(13, 'Understanding the Document Object Model (DOM)', 'The DOM is a programming interface...', 1706176800000, 1706263200000, 'img13.jpg', 3),
(14, 'Building Progressive Web Apps (PWAs)', 'Progressive Web Apps are web applications...', 1706349600000, 1706436000000, 'img14.jpg', 4),
(15, 'An Introduction to GraphQL', 'GraphQL is a query language for APIs...', 1706522400000, 1706608800000, 'img15.jpg', 5),
(16, 'Diving into Docker: A Beginner s Guide', 'Docker is a platform for developing...', 1706781600000, 1706868000000, 'img16.jpg', 1),
(17, 'Microservices Architecture: An Overview', 'Microservices architecture allows...', 1706954400000, 1707040800000, 'img17.jpg', 2),
(18, 'Introduction to Kubernetes', 'Kubernetes is an open-source system for...', 1707127200000, 1707213600000, 'img18.jpg', 3),
(19, 'Building RESTful APIs with Express.js', 'Express.js is a web application framework...', 1707300000000, 1707386400000, 'img19.jpg', 4),
(20, 'Understanding Web Security', 'Web security is a critical aspect of...', 1707472800000, 1707559200000, 'img20.jpg', 5),
(21, 'A Guide to Responsive Web Design', 'Responsive web design is an approach to...', 1707645600000, 1707732000000, 'img21.jpg', 1),
(22, 'Introduction to Machine Learning', 'Machine learning is a field of artificial...', 1707818400000, 1707904800000, 'img22.jpg', 2),
(23, 'Exploring the Django Framework', 'Django is a high-level Python web framework...', 1707991200000, 1708077600000, 'img23.jpg', 3),
(24, 'Getting Started with Angular', 'Angular is a platform for building...', 1708164000000, 1708250400000, 'img24.jpg', 4),
(25, 'The Basics of SQL and Databases', 'SQL is a standard language for managing...', 1708336800000, 1708423200000, 'img25.jpg', 5),
(26, 'Introduction to DevOps', 'DevOps is a set of practices that...', 1708509600000, 1708596000000, 'img26.jpg', 1),
(27, 'Building Mobile Apps with Flutter', 'Flutter is an open-source UI software...', 1708682400000, 1708768800000, 'img27.jpg', 2),
(28, 'Understanding Blockchain Technology', 'Blockchain is a distributed ledger...', 1708855200000, 1708941600000, 'img28.jpg', 3),
(29, 'A Guide to Cybersecurity', 'Cybersecurity involves protecting...', 1709028000000, 1709114400000, 'img29.jpg', 4),
(30, 'Introduction to Artificial Intelligence', 'Artificial intelligence (AI) is the...', 1709290800000, 1709377200000, 'img30.jpg', 5),
(31, 'Exploring the ASP.NET Core Framework', 'ASP.NET Core is a cross-platform...', 1709463600000, 1709550000000, 'img31.jpg', 1),
(32, 'Building Interactive Websites with jQuery', 'jQuery is a fast, small, and...', 1709636400000, 1709722800000, 'img32.jpg', 2),
(33, 'Getting Started with Laravel', 'Laravel is a web application framework...', 1709809200000, 1709895600000, 'img33.jpg', 3),
(34, 'A Comprehensive Guide to CSS Flexbox', 'CSS Flexbox is a layout model...', 1709982000000, 1710068400000, 'img34.jpg', 4),
(35, 'Understanding API Integration', 'API integration is the process of...', 1710154800000, 1710241200000, 'img35.jpg', 5),
(36, 'Introduction to Cloud Computing', 'Cloud computing is the delivery of...', 1710327600000, 1710414000000, 'img36.jpg', 1),
(37, 'Building Scalable Web Applications', 'Scalable web applications are designed...', 1710500400000, 1710586800000, 'img37.jpg', 2),
(38, 'Exploring WebAssembly', 'WebAssembly is a binary instruction...', 1710673200000, 1710759600000, 'img38.jpg', 3),
(39, 'A Guide to Software Testing', 'Software testing is a process of...', 1710846000000, 1710932400000, 'img39.jpg', 4),
(40, 'Understanding Continuous Integration', 'Continuous integration is a practice...', 1711018800000, 1711105200000, 'img40.jpg', 5),
(41, 'Building Serverless Applications', 'Serverless computing allows you...', 1711191600000, 1711278000000, 'img41.jpg', 1),
(42, 'Introduction to Big Data', 'Big data refers to data sets that are...', 1711364400000, 1711450800000, 'img42.jpg', 2),
(43, 'Getting Started with Elasticsearch', 'Elasticsearch is a search engine...', 1711537200000, 1711623600000, 'img43.jpg', 3),
(44, 'A Guide to API Security', 'API security is the practice of...', 1711710000000, 1711796400000, 'img44.jpg', 4),
(45, 'Understanding Agile Development', 'Agile development is a methodology...', 1711882800000, 1711969200000, 'img45.jpg', 5),
(46, 'Building Real-time Applications', 'Real-time applications respond to...', 1712055600000, 1712142000000, 'img46.jpg', 1),
(47, 'Introduction to NoSQL Databases', 'NoSQL databases provide a mechanism...', 1712228400000, 1712314800000, 'img47.jpg', 2),
(48, 'Exploring the Redux Library', 'Redux is a predictable state...', 1712401200000, 1712487600000, 'img48.jpg', 3),
(49, 'A Guide to Data Visualization', 'Data visualization is the graphical...', 1712574000000, 1712660400000, 'img49.jpg', 4),
(50, 'Understanding Event-Driven Architecture', 'Event-driven architecture is a...', 1712746800000, 1712833200000, 'img50.jpg', 5);



-- Insert mock data into comment table
INSERT INTO comment (content, createDate, parentCommentId, userId, articleId) VALUES
-- First article
('First comment on first article.', 1704189600000, NULL, 2, 1),
('Reply to first comment on first article.', 1704196800000, 1, 3, 1),
('Another reply to first comment on first article.', 1704204000000, 1, 4, 1),
('Reply to the second comment on first article.', 1704276000000, 2, 5, 1),
('Interesting perspective on Flexbox!', 1704193200000, NULL, 4, 1),
('Reply to interesting perspective on Flexbox!', 1704198600000, 5, 3, 1),
('Third level reply on interesting perspective on Flexbox!', 1704200400000, 6, 5, 1),
('More comments on first article.', 1704283200000, NULL, 2, 1),
('Another comment on first article.', 1704342000000, NULL, 3, 1),
('Follow-up comment on first article.', 1704345600000, NULL, 4, 1),
('Reply to follow-up comment.', 1704349200000, 10, 5, 1),
('Another reply to follow-up comment.', 1704352800000, 10, 2, 1),
('Discussion on first article.', 1704393600000, NULL, 3, 1),
('Further discussion on first article.', 1704397200000, NULL, 4, 1),
('Insightful comment on first article.', 1704456000000, NULL, 5, 1),
('Reply to insightful comment.', 1704459600000, 15, 2, 1),
('Question about first article.', 1704463200000, NULL, 3, 1),
('Answer to question about first article.', 1704466800000, 17, 4, 1),
('Another answer to question about first article.', 1704470400000, 17, 5, 1),
('Final comment on first article.', 1704531600000, NULL, 2, 1),

-- other articles
('First comment on second article.', 1704456000000, NULL, 1, 2),
('Reply to first comment on second article.', 1704459600000, 21, 2, 2),
('I found this guide very helpful. Thanks!', 1704347400000, NULL, 5, 2),
('Reply to helpful guide comment.', 1704349200000, 23, 1, 2),
('Great overview of ES6 features.', 1704390300000, NULL, 2, 3),
('Reply to ES6 overview.', 1704392100000, 25, 3, 3),
('I had trouble with HTML5 forms, but this helped.', 1704456000000, NULL, 3, 4),
('Bootstrap is my go-to framework for responsive design.', 1704480600000, NULL, 1, 5),
('Reply to Bootstrap comment.', 1704482700000, 29, 4, 5),
('Asynchronous JavaScript can be tricky, but this article simplifies it.', 1704555900000, NULL, 2, 6),
('Python is indeed versatile. Great read!', 1704585300000, NULL, 3, 7),
('Hooks make React so much easier to manage.', 1704711000000, NULL, 4, 8),
('Reply to React Hooks comment.', 1704712800000, 35, 5, 8),
('Node.js is powerful for server-side development.', 1704783600000, NULL, 5, 9),
('Svelte is an interesting framework. Need to try it out.', 1704852600000, NULL, 1, 10),
('Reply to Svelte comment.', 1704854100000, 39, 2, 10),
('Vue.js has been great for my projects.', 1704926400000, NULL, 2, 11),
('TypeScript has improved my code quality significantly.', 1705012800000, NULL, 3, 12),
('Understanding the DOM is crucial for web development.', 1705092600000, NULL, 4, 13),
('Reply to DOM understanding comment.', 1705094400000, 43, 5, 13),
('PWAs are the future of mobile web apps.', 1705160100000, NULL, 5, 14),
('GraphQL looks promising for API development.', 1705230000000, NULL, 1, 15),
('Docker has revolutionized my deployment process.', 1705353000000, NULL, 2, 16),
('Reply to Docker comment.', 1705356000000, 47, 3, 16),
('Microservices architecture is complex but worth it.', 1705419600000, NULL, 3, 17),
('Kubernetes is powerful but has a steep learning curve.', 1705492800000, NULL, 4, 18),
('Reply to Kubernetes comment.', 1705494900000, 51, 5, 18),
('Express.js makes building APIs straightforward.', 1705571100000, NULL, 5, 19),
('Web security is more important than ever.', 1705643700000, NULL, 1, 20),
('Reply to web security comment.', 1705645500000, 55, 2, 20),
('Responsive design is a must for modern websites.', 1705725900000, NULL, 2, 21),
('Machine learning is a fascinating field.', 1705800900000, NULL, 3, 22),
('Django is a robust framework for web development.', 1705884600000, NULL, 4, 23),
('Reply to Django comment.', 1705886400000, 59, 5, 23),
('Angular offers great tooling for large projects.', 1705960500000, NULL, 5, 24),
('SQL knowledge is fundamental for any developer.', 1706031900000, NULL, 1, 25),
('DevOps practices have streamlined my workflow.', 1706106000000, NULL, 2, 26),
('Reply to DevOps comment.', 1706107800000, 63, 3, 26),
('Flutter is excellent for cross-platform app development.', 1706182200000, NULL, 3, 27),
('Blockchain technology has many potential applications.', 1706259900000, NULL, 4, 28),
('Cybersecurity is a growing concern for businesses.', 1706332800000, NULL, 5, 29),
('Reply to Cybersecurity comment.', 1706334600000, 67, 1, 29),
('AI is transforming various industries.', 1706411700000, NULL, 1, 30),
('ASP.NET Core is versatile and powerful.', 1706493000000, NULL, 2, 31),
('jQuery still has its place in modern web development.', 1706566200000, NULL, 3, 32),
('Laravel has made PHP development enjoyable.', 1706640000000, NULL, 4, 33),
('Flexbox simplifies CSS layout tasks.', 1706713200000, NULL, 5, 34),
('API integration is essential for modern applications.', 1706786100000, NULL, 1, 35),
('Cloud computing has changed how we develop applications.', 1706859900000, NULL, 2, 36),
('Scalability is key for web applications.', 1706932200000, NULL, 3, 37),
('WebAssembly opens new possibilities for web development.', 1707003900000, NULL, 4, 38),
('Software testing is critical for quality assurance.', 1707076500000, NULL, 5, 39),
('Continuous integration improves development efficiency.', 1707149700000, NULL, 1, 40),
('Serverless architecture simplifies deployment.', 1707222900000, NULL, 2, 41),
('Big data analytics provide valuable insights.', 1707295500000, NULL, 3, 42),
('Elasticsearch is great for search functionality.', 1707369300000, NULL, 4, 43);



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