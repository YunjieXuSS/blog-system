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
INSERT INTO user (userName, password, email, firstName, lastName, dateOfBirth, avatar, isAdmin,description) VALUES
('test01', '$2b$12$JVap/opFunBoaqN77vhcdO1k3o3MffTjKUYt5CZNHN6L7eR5r2xee', 'test01@example.com', 'Chandler', 'Bing', '1967-01-1', '/images/chandler.jpeg', TRUE,"This blog is fxxking awesome! So it seems like this internet thing is here to stay, huh?"),
('test02', '$2b$12$LFtIv9f.9azNHPUxx7aUnuVBxfSywBS1LVklZn.IoMNjPh8BGp0Re', 'test02@example.com', 'Jon', 'Snow', '283-12-31', '/images/jon_snow.png', TRUE,"Winter is Coming! My Watch Is Ended!"),
('test03', '$2b$12$7OnYYy8fB1O14Pfo/Lap4uIKvcN/MOBw40m5/ch6lac4B3.HZi4ge', 'test03@example.com', 'WALL-E', 'Unkown', '1-1-1', '/images/wall-e.png', FALSE,"EVE: EVE! EVE !WALL.E: Eeeee... va?"),
('jane_smith', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'jane.smith@example.com', 'Jane', 'Smith', '1990-08-22', '/images/userDefaultIcon2.png', TRUE,"I know myself so well."),
('john_titor', '$2b$12$6Sdre8XSkFpHCp2sso/gLuKx7.ctyXkZc7PP546VlnCg4rCmGRVuq', 'john_titor@example.com', 'john', 'Titor', '2000-01-01', '/images/userDefaultIcon3.png', FALSE,"I come from the future!"),
('bob_brown', '$2b$12$9yuOvONQDqm5.YeITAd.L.FsyDhIblipXrl3vddN.BzjM1CWCsgIm', 'bob.brown@example.com', 'Bob', 'Brown', '1995-03-30', '/images/userDefaultIcon4.png', FALSE,"I know myself so well."),
('homer_simpson', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'homer.simpson@example.com', 'Homer', 'Simpson', '1956-05-12', '/images/homer.png', FALSE, "D'oh! Time to grab a donut."),
('sherlock_holmes', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'sherlock.holmes@example.com', 'Sherlock', 'Holmes', '1854-01-06', '/images/sherlock.png', FALSE, "Elementary, my dear Watson."),
('tony_stark', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'tony.stark@example.com', 'Tony', 'Stark', '1970-05-29', '/images/tony_stark.png', FALSE, "I am Iron Man."),
('frodo_baggins', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'frodo.baggins@example.com', 'Frodo', 'Baggins', '2980-09-22', '/images/frodo.png', FALSE, "I will take the ring to Mordor."),
('walter_white', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'walter.white@example.com', 'Walter', 'White', '1958-09-07', '/images/walter_white.png', FALSE, "I am the one who knocks."),
('bruce_wayne', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'bruce.wayne@example.com', 'Bruce', 'Wayne', '1939-05-27', '/images/bruce_wayne.jpeg', FALSE, "I am Batman."),
('harry_potter', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'harry.potter@example.com', 'Harry', 'Potter', '1980-07-31', '/images/harry_potter.png', FALSE, "I solemnly swear that I am up to no good."),
('luke_skywalker', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'luke.skywalker@example.com', 'Luke', 'Skywalker', '19BBY-05-24', '/images/luke_skywalker.png', FALSE, "May the Force be with you."),
('hermione_granger', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'hermione.granger@example.com', 'Hermione', 'Granger', '1979-09-19', '/images/hermione_granger.png', FALSE, "It's Leviosa, not Leviosar."),
('gandalf_grey', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'gandalf.grey@example.com', 'Gandalf', 'TheGrey', '2019-07-10', '/images/gandalf.png', FALSE, "You shall not pass."),
('katniss_everdeen', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'katniss.everdeen@example.com', 'Katniss', 'Everdeen', '2010-05-08', '/images/katniss.png', FALSE, "I volunteer as tribute."),
('elsa_frozen', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'elsa.frozen@example.com', 'Elsa', 'Frozen', '2005-12-01', '/images/elsa.jpeg', FALSE, "Let it go."),
('peter_parker', '$2b$12$CtT/UF/YyKgcbYw7DUq8o.15a.etd7RlLHM2AJ.yFEl1G7uuXaPkW', 'peter.parker@example.com', 'Peter', 'Parker', '2001-08-10', '/images/peter_parker.jpeg', FALSE, "With great power comes great responsibility.");




-- Insert mock data(long article) into article table
INSERT INTO article (title, content, createDate, updateDate, imgUrl, userId) VALUES
('Understanding Flexbox: Everything you need to know.', 'Flexbox is a powerful layout module that allows you to create complex layouts with ease. It is a one-dimensional layout method that can handle both rows and columns, making it a versatile tool for designing responsive web pages. In this article, we will cover the basics of Flexbox, including its properties, how to use it, and some practical examples. Flexbox was introduced in CSS3 to improve upon the limitations of traditional layout methods like float and positioning. The main idea behind Flexbox is to provide a container that automatically arranges its children elements in a predictable way, even when their sizes are unknown or dynamic. One of the core concepts of Flexbox is the flex container, which is an element with the display property set to flex. This container houses flex items, which are the direct children of the container. Flexbox offers several properties that control the layout and alignment of flex items within the container. Some of the key properties include flex-direction, justify-content, align-items, and flex-wrap. The flex-direction property specifies the direction in which the flex items are placed within the container. It can be set to row, column, row-reverse, or column-reverse. The justify-content property aligns the flex items along the main axis, while the align-items property aligns them along the cross axis. Flex-wrap determines whether the flex items should wrap onto multiple lines or stay on a single line. Using these properties, you can create a wide range of layouts with minimal effort. For example, you can center elements both horizontally and vertically, create equal-width columns, or build complex grids. Flexbox also provides a flexible sizing model, allowing you to specify how much space each flex item should take up relative to its siblings. In addition to these core properties, Flexbox offers advanced features like nested flex containers, order property for rearranging items, and the ability to align individual items differently from the rest. By mastering Flexbox, you can create responsive layouts that adapt to different screen sizes and orientations, ensuring a consistent user experience across devices. Whether you are building a simple navigation bar or a complex web application, Flexbox is an essential tool for any web developer.', 1704103200000, 1704189600000, '/images/img1.jpg', 1),
('CSS Grid Layout: A Step-by-Step Guide', 'CSS Grid Layout is a two-dimensional layout system for the web. It lets you lay out items in rows and columns, and has many features that make building complex layouts straightforward. This guide will walk you through the fundamentals of CSS Grid, providing examples and practical tips along the way. <br>CSS Grid is a layout model that enables the creation of complex and flexible web page designs. Unlike Flexbox, which is one-dimensional, CSS Grid is two-dimensional, meaning it can handle both rows and columns simultaneously. This makes it ideal for creating grid-based layouts that require precise control over the positioning and sizing of elements. One of the key features of CSS Grid is the grid container, which is an element with the display property set to grid. The grid container is divided into grid tracks, which are the rows and columns that make up the grid. <br>These tracks are defined using the grid-template-rows and grid-template-columns properties, respectively. Each track can be assigned a specific size or set to auto to adjust based on its content. CSS Grid also introduces the concept of grid items, which are the direct children of the grid container. These items can be placed within the grid using the grid-area property, which specifies the starting and ending row and column lines for each item. Alternatively, you can use the shorthand properties grid-row and grid-column to define the position of grid items. One of the most powerful features of CSS Grid is the ability to create responsive layouts that adapt to different screen sizes. This can be achieved using the fr unit, which represents a fraction of the available space within the grid. <br>By combining the fr unit with media queries, you can create grids that automatically adjust based on the viewport size. Another useful feature of CSS Grid is the ability to create gaps between grid items using the grid-gap property. This property allows you to specify the amount of space between rows and columns, making it easy to create visually appealing layouts with consistent spacing. CSS Grid also supports nested grids, where a grid item itself becomes a grid container. This enables the creation of complex, multi-level layouts that are easy to manage and maintain. By mastering CSS Grid, you can create flexible, responsive, and visually appealing web page designs that are easy to manage and maintain. Whether you are building a simple blog layout or a complex web application, CSS Grid is an essential tool for any web developer.', 1704276000000, 1704362400000, '/images/img2.jpg', 2),
('JavaScript ES6 Features: An Overview', 'ES6, also known as ECMAScript 2015, introduced many new features to JavaScript. These include arrow functions, classes, template literals, let and const, default parameters, and more. This article provides an overview of these new features and how to use them in your JavaScript code. One of the most notable additions in ES6 is the introduction of arrow functions. <br>Arrow functions provide a concise syntax for writing function expressions, making your code more readable and maintainable. They also inherit the this value from the enclosing context, which can be useful when working with callbacks and event handlers. Another significant feature in ES6 is the introduction of classes. Classes provide a more straightforward syntax for creating constructor functions and working with prototypes. They also support inheritance, allowing you to create subclasses that extend the functionality of existing classes. Template literals are another powerful feature introduced in ES6. They allow you to create multi-line strings and embed expressions using a backtick (`) syntax. This makes it easier to work with dynamic content and construct complex strings without the need for concatenation. ES6 also introduces new variable declaration keywords: let and const. The let keyword allows you to declare block-scoped variables, which are only accessible within the block they are defined. <br>This helps to avoid issues with variable hoisting and improves the readability of your code. The const keyword, on the other hand, is used to declare constants, which are variables that cannot be reassigned once they are initialized. Default parameters are another useful addition in ES6. They allow you to specify default values for function parameters, making your functions more flexible and easier to work with. If no argument is provided for a parameter with a default value, the default value will be used instead. ES6 also introduces the spread and rest operators. The spread operator (...) allows you to spread the elements of an array or object into a new array or object, making it easier to work with collections of data. The rest operator, which uses the same syntax, allows you to collect multiple function arguments into a single array. <br>Promises are another significant feature introduced in ES6. Promises provide a cleaner and more manageable way to handle asynchronous operations, such as fetching data from an API. They allow you to chain multiple asynchronous operations together and handle errors more effectively. ES6 also includes many other features and improvements, such as the Map and Set data structures, new methods for arrays and strings, and enhancements to the Math and Number objects. By mastering these new features, you can write more efficient, readable, and maintainable JavaScript code, making your development process more enjoyable and productive.', 1704448800000, 1704535200000, '/images//images/img3.jpg', 3),
('A Comprehensive Guide to HTML5', 'HTML5 is the latest evolution of the standard that defines HTML. It introduces new elements and attributes that reflect typical usage on modern websites. In this comprehensive guide, we will explore the new features of HTML5 and how they can be used to create more interactive and dynamic web pages. One of the most significant changes in HTML5 is the introduction of new semantic elements. These elements provide more meaningful structure to your web pages, making them easier to understand and navigate for both users and search engines. Some of the new semantic elements include header, footer, article, section, and nav. These elements help to define the different parts of a web page, making it clear what each section is for. Another important feature of HTML5 is the support for multimedia elements. <br>HTML5 introduces the audio and video elements, which allow you to embed multimedia content directly into your web pages without the need for external plugins like Flash. These elements provide a more consistent and accessible way to include multimedia content on your website. HTML5 also includes new form elements and attributes that make it easier to create user-friendly forms. Some of the new form elements include date, time, email, and range input types. These elements provide built-in validation and user interface enhancements, making it easier for users to interact with your forms. The canvas element is another powerful feature of HTML5. The canvas element allows you to draw graphics and animations directly onto your web pages using JavaScript. <br>This makes it possible to create interactive and dynamic content, such as games, data visualizations, and custom user interfaces. HTML5 also introduces new APIs that provide enhanced functionality for web applications. Some of the new APIs include the Geolocation API, which allows you to access the user s location, and the Web Storage API, which provides a more secure and flexible way to store data on the client side. Another important aspect of HTML5 is its focus on accessibility. HTML5 includes new attributes and elements that improve the accessibility of web content for users with disabilities. For example, the role attribute allows you to define the purpose of an element, making it easier for screen readers to interpret the content. HTML5 also supports the use of ARIA (Accessible Rich Internet Applications) attributes, which provide additional information about the structure and behavior of web content. <br>By using these attributes, you can create web pages that are more accessible and usable for all users. In addition to these new features, HTML5 also includes many other improvements and enhancements, such as better support for mobile devices, improved performance, and enhanced security. By mastering the new features of HTML5, you can create more interactive, dynamic, and accessible web pages that provide a better user experience for your visitors.', 1704621600000, 1704708000000, '/images/img4.jpg', 4),
('Building Responsive Websites with Bootstrap', 'Bootstrap is a popular framework for building responsive websites. It includes a variety of CSS and JavaScript components that make it easy to create responsive, mobile-first web pages. This article will guide you through the process of building a responsive website using Bootstrap.<br> Bootstrap was developed by Twitter and released as an open-source project in 2011. Since then, it has become one of the most widely used front-end frameworks for web development. Bootstrap provides a set of pre-designed components and utilities that make it easy to create responsive layouts and user interfaces. One of the core features of Bootstrap is its grid system. The grid system allows you to create flexible and responsive layouts by dividing the page into a series of rows and columns. The grid system is based on a 12-column layout, which means you can create layouts that span from 1 to 12 columns. This makes it easy to create complex and flexible designs that adapt to different screen sizes. <br>In addition to the grid system, Bootstrap includes a variety of CSS components that can be used to style your web pages. These components include navigation bars, buttons, forms, cards, and more. Each component is designed to be responsive and can be easily customized using CSS classes. Bootstrap also includes a set of JavaScript plugins that add interactivity to your web pages. These plugins include modals, tooltips, carousels, and more. <br>The JavaScript plugins are built on top of jQuery, making them easy to integrate into your existing codebase. One of the main advantages of using Bootstrap is its mobile-first approach. This means that the framework is designed to work seamlessly on mobile devices, ensuring that your web pages look and function correctly on smaller screens. The responsive design principles built into Bootstrap make it easy to create web pages that adapt to different screen sizes and orientations. Bootstrap also includes a variety of utility classes that make it easy to apply common styles and behaviors to your elements. These utility classes include classes for spacing, alignment, visibility, and more. <br>By using these utility classes, you can quickly and easily apply consistent styles to your web pages. In addition to the core features of Bootstrap, there is also a large and active community of developers who contribute to the project. This means that there are many third-party themes, plugins, and resources available that can help you extend the functionality of Bootstrap and customize it to meet your needs. <br><br>By using Bootstrap, you can save time and effort when building responsive websites. The pre-designed components and utilities make it easy to create consistent and professional-looking web pages, while the responsive design principles ensure that your pages look great on all devices. Whether you are building a simple landing page or a complex web application, Bootstrap is a valuable tool for any web developer.', 1704794400000, 1704880800000, '/images/img5.jpg', 5),
('Understanding Asynchronous JavaScript', 'Asynchronous JavaScript allows you to execute tasks in the background without blocking the main thread. This is essential for building responsive web applications. In this article, we will explore various ways to handle asynchronous operations in JavaScript, including callbacks, promises, and async/await. Asynchronous programming is a key concept in modern web development. It allows you to perform tasks such as fetching data from an API, reading files, or performing complex calculations without freezing the user interface. <br><br>This is achieved by running these tasks in the background, allowing the main thread to continue executing other code. One of the earliest methods for handling asynchronous operations in JavaScript is the use of callbacks. A callback is a function that is passed as an argument to another function and is executed once the asynchronous operation is complete. While callbacks are a simple and effective way to handle asynchronous tasks, they can lead to callback hell, a situation where multiple nested callbacks make the code difficult to read and maintain. To address the limitations of callbacks, JavaScript introduced promises in ES6.<br><br> A promise is an object that represents the eventual completion (or failure) of an asynchronous operation and its resulting value. Promises provide a cleaner and more manageable way to handle asynchronous operations, allowing you to chain multiple operations together and handle errors more effectively. A promise can be in one of three states: pending, fulfilled, or rejected. When a promise is created, it is initially in the pending state. Once the asynchronous operation is complete, the promise is either fulfilled (if the operation was successful) or rejected (if an error occurred). You can use the then() method to specify what should happen when the promise is fulfilled, and the catch() method to handle any errors. Another significant advancement in asynchronous programming is the introduction of async/await in ES8. Async/await is built on top of promises and provides a more readable and synchronous-like syntax for writing asynchronous code.<br><br>The async keyword is used to define a function that returns a promise, while the await keyword is used to pause the execution of the function until the promise is resolved. This allows you to write asynchronous code that looks and behaves like synchronous code, making it easier to read and maintain. In addition to these core concepts, there are several other techniques and libraries available for handling asynchronous operations in JavaScript. For example, you can use the Fetch API to make HTTP requests and handle the responses asynchronously. The Fetch API returns a promise, making it easy to integrate with other asynchronous code. <br><br>Another popular library for managing asynchronous operations is RxJS (Reactive Extensions for JavaScript). RxJS provides a powerful and flexible way to handle asynchronous events and data streams using observables. Observables allow you to work with asynchronous data in a declarative manner, making it easier to compose and manage complex asynchronous workflows. By understanding and mastering these techniques, you can build more responsive and performant web applications that provide a better user experience.', 1704967200000, 1705053600000, '/images/img6.jpg', 1),
('Mastering Python for Data Science', 'Python is a versatile language used in various fields, including data science, web development, automation, and more. Its simplicity, readability, and extensive library support make it an ideal choice for data science. In this article, we will explore how to master Python for data science, covering essential libraries, tools, and best practices. Python has become the de facto language for data science due to its robust ecosystem of libraries and frameworks. Some of the most popular libraries include NumPy, Pandas, Matplotlib, and Scikit-learn.<br><br> These libraries provide powerful tools for data manipulation, analysis, and visualization, making it easier to work with large datasets and extract valuable insights. NumPy is the foundational library for numerical computing in Python. It provides support for arrays, matrices, and a wide range of mathematical functions. NumPy s array-based data structures enable efficient storage and manipulation of large datasets, making it a critical tool for data scientists. Pandas is another essential library for data science. It builds on top of NumPy and provides data structures and functions specifically designed for data analysis. The core data structures in Pandas are Series (one-dimensional) and DataFrame (two-dimensional), which allow you to work with structured data in a flexible and efficient manner.<br><br> Pandas also includes a variety of tools for data cleaning, transformation, and aggregation, making it easier to prepare your data for analysis. Data visualization is a crucial aspect of data science, and Matplotlib is the go-to library for creating static, animated, and interactive visualizations in Python. Matplotlib provides a wide range of plotting functions and customization options, allowing you to create informative and visually appealing charts and graphs. For more advanced visualizations, you can use libraries like Seaborn, which is built on top of Matplotlib and provides higher-level interfaces for creating complex visualizations. Scikit-learn is a powerful library for machine learning in Python. It provides a comprehensive suite of tools for building and evaluating machine learning models, including algorithms for classification, regression, clustering, and more. <br><br>Scikit-learn also includes utilities for data preprocessing, model selection, and evaluation, making it easier to implement machine learning workflows. In addition to these core libraries, there are several other tools and frameworks that can enhance your data science workflow. For example, Jupyter Notebooks provide an interactive environment for writing and running Python code, making it easy to experiment with different analyses and document your findings. Anaconda is a popular distribution of Python that includes many of the essential libraries and tools for data science, simplifying the setup and management of your development environment. To master Python for data science, it is essential to develop a strong foundation in these libraries and tools. This involves not only learning the syntax and functionality of each library but also understanding how to apply them effectively to real-world data science problems. <br><br>Practicing with datasets, participating in online competitions, and collaborating with other data scientists can help you hone your skills and gain practical experience. By mastering Python and its ecosystem of data science libraries, you can unlock the full potential of your data and make more informed, data-driven decisions. Whether you are analyzing trends, building predictive models, or visualizing complex data, Python provides the tools and flexibility you need to succeed in the field of data science.', 1705140000000, 1705226400000, '/images/img7.jpg', 2),
('A Guide to React Hooks', 'React Hooks provide a way to use state and other React features without writing a class. They were introduced in React 16.8 and have since become a fundamental part of React development. This article will guide you through the basics of React Hooks, including how to use them, common hooks, and best practices. One of the most important hooks in React is the useState hook. The useState hook allows you to add state to functional components. <br><br>It returns an array with two elements: the current state and a function to update the state. By calling useState with an initial value, you can create a piece of state that persists across renders. Another essential hook is the useEffect hook. The useEffect hook allows you to perform side effects in functional components, such as fetching data, subscribing to events, or updating the DOM. It takes a function as its argument, which is executed after every render. You can also pass a second argument, an array of dependencies, to control when the effect runs. <br><br>The useContext hook is used to access the value of a React context. Context provides a way to pass data through the component tree without having to pass props down manually at every level. By using the useContext hook, you can access the context value directly from a functional component. The useReducer hook is another powerful hook that can be used for state management. It is similar to useState but is more suitable for managing complex state logic. The useReducer hook takes a reducer function and an initial state as its arguments and returns the current state and a dispatch function. <br><br>The dispatch function can be used to send actions to the reducer, which updates the state based on the action type and payload. Custom hooks are a way to extract and reuse logic from functional components. By creating a custom hook, you can encapsulate common logic and share it across multiple components. Custom hooks follow the same rules as regular hooks and can use other hooks inside them. React also provides several other hooks, such as useRef, useMemo, and useCallback, which can be used for specific use cases. The useRef hook allows you to create a mutable ref object that persists across renders. The useMemo hook is used to memoize expensive calculations, and the useCallback hook is used to memoize functions. When using hooks, it is important to follow the rules of hooks to avoid common pitfalls. The rules of hooks state that hooks should only be called at the top level of a component and not inside loops, conditions, or nested functions. <br><br>This ensures that hooks are called in the same order on every render, preserving the state and behavior of the component. By mastering React Hooks, you can write more concise and maintainable code, reducing the need for class components and simplifying state management. Hooks provide a powerful way to leverage the full potential of functional components, making it easier to build complex and interactive user interfaces in React.', 1705312800000, 1705399200000, '/images/img8.jpg', 3),
('Introduction to Node.js', 'Node.js is a JavaScript runtime built on Chrome s V8 JavaScript engine. It allows you to run JavaScript on the server-side, enabling you to build scalable and high-performance web applications. In this article, we will explore the basics of Node.js, including its architecture, key features, and common use cases. One of the main advantages of Node.js is its non-blocking, event-driven architecture. This means that Node.js can handle multiple requests simultaneously without waiting for one request to complete before starting the next. This makes Node.js particularly well-suited for building real-time applications, such as chat applications, online gaming, and live streaming. <br><br>Node.js uses an event loop to manage asynchronous operations. The event loop continuously checks for new events and executes the corresponding callbacks. This allows Node.js to handle a large number of concurrent connections efficiently, making it ideal for building scalable applications. Another key feature of Node.js is its single-threaded nature. Unlike traditional multi-threaded server architectures, Node.js uses a single thread to handle all incoming requests. This simplifies the development process and reduces the risk of concurrency issues, such as race conditions and deadlocks. Node.js also provides a rich ecosystem of libraries and modules through its package manager, npm. Npm is the largest package registry in the world, with over a million packages available for download. These packages cover a wide range of functionalities, from web frameworks and database drivers to authentication and testing tools. One of the most popular web frameworks for Node.js is Express.js. Express.js provides a simple and flexible way to build web applications and APIs. <br><br>It includes features such as routing, middleware support, and template engines, making it easy to create robust and maintainable applications. In addition to web development, Node.js can be used for a variety of other use cases, such as building command-line tools, developing desktop applications, and creating microservices. Its versatility and performance make it a popular choice for many developers. Node.js also has strong community support, with a large number of tutorials, documentation, and online resources available. This makes it easy for developers to learn and get started with Node.js, regardless of their level of experience. By mastering Node.js, you can build scalable, high-performance web applications that can handle a large number of concurrent connections. Whether you are building a simple API or a complex real-time application, Node.js provides the tools and flexibility you need to succeed.', 1705485600000, 1705572000000, '/images/img9.jpg', 4),
('Getting Started with Svelte', 'Svelte is a modern JavaScript framework for building user interfaces. Unlike traditional frameworks, which do most of their work in the browser, Svelte shifts that work into a compile step that happens when you build your app. This results in highly optimized, framework-less JavaScript code that runs faster and has smaller bundle sizes. In this article, we will explore the basics of Svelte, including its key features, how to get started, and best practices for building Svelte applications. <br><br>One of the main advantages of Svelte is its simplicity and ease of use. Svelte provides a straightforward syntax for building components, making it easy to get started with minimal boilerplate code. The core concepts of Svelte are components, props, and state. Components are the building blocks of a Svelte application, and each component is a self-contained unit that includes its markup, styles, and logic. Props allow you to pass data from a parent component to a child component, while state allows you to manage the internal state of a component. Svelte also provides a reactivity system that automatically updates the DOM when the state changes. This makes it easy to build interactive and dynamic user interfaces without the need for complex state management libraries. <br><br>Another key feature of Svelte is its built-in support for animations and transitions. Svelte provides a simple and intuitive API for creating animations and transitions, making it easy to add visual effects to your applications. Svelte also includes a powerful templating system that allows you to create dynamic and reusable templates. The templating system is based on HTML, making it easy to understand and use for developers who are already familiar with HTML. One of the most powerful features of Svelte is its ability to compile your components into highly optimized JavaScript code. This means that your application will have smaller bundle sizes and faster runtime performance compared to traditional frameworks. <br><br>Svelte also includes a rich ecosystem of tools and libraries that can help you build and manage your applications. For example, SvelteKit is a framework for building server-side rendered applications with Svelte, while Sapper is a framework for building progressive web apps with Svelte. By mastering Svelte, you can build highly optimized, fast, and responsive user interfaces with minimal effort. Whether you are building a small widget or a complex web application, Svelte provides the tools and features you need to succeed.', 1705658400000, 1705744800000, '/images/img10.jpg', 5),
('Exploring the Vue.js Framework', 'Vue.js is a progressive JavaScript framework for building user interfaces and single-page applications. It is designed to be incrementally adoptable, meaning you can use as much or as little of the framework as you need. In this article, we will explore the key concepts and features of Vue.js, including its reactivity system, components, directives, and the Vue CLI. Vue.js is known for its simplicity and flexibility, making it a popular choice among developers.The core of Vue.js is the Vue instance, which serves as the starting point for creating a Vue application. <br><br>The Vue instance provides data and methods that are reactive, meaning any changes to the data automatically update the DOM. This reactivity system is one of the defining features of Vue.js, enabling efficient and intuitive UI updates.Components are another fundamental concept in Vue.js. They are reusable, self-contained units of code that encapsulate HTML, CSS, and JavaScript. Components can be nested within other components, allowing developers to build complex user interfaces from simple building blocks. This component-based architecture promotes code reusability and maintainability.Directives are special tokens in Vue.js templates that provide reactive behavior to the DOM. Some common directives include v-if, v-for, and v-bind, which control conditional rendering, list rendering, and attribute binding, respectively. Directives make it easy to implement dynamic behavior in your templates.The Vue CLI (Command Line Interface) is a powerful tool that helps developers scaffold and manage Vue.js projects. It provides a streamlined development workflow with features like project templates, a development server, and build tools. The Vue CLI also supports plugins and presets, allowing developers to easily extend and customize their projects.Vue.js also offers advanced features like single-file components, which allow you to define a component template, logic, and styles in a single file. <br><br>This approach simplifies the development process and enhances component encapsulation. Additionally, Vue.js supports state management with Vuex and routing with Vue Router, making it a comprehensive solution for building modern web applications.By mastering Vue.js, developers can create high-performance, maintainable, and scalable applications. Whether you are building a small widget or a large-scale application, Vue.js provides the tools and flexibility needed for modern web development. Its gentle learning curve and robust ecosystem make it an excellent choice for both beginners and experienced developers.', 1705831200000, 1705917600000, '/images/img11.jpg', 1),
('The Basics of TypeScript', 'TypeScript is a typed superset of JavaScript that compiles to plain JavaScript. It is designed to improve the development experience by adding static types, which help catch errors early and make the code more robust and maintainable. In this article, we will cover the basics of TypeScript, including its key features, benefits, and how to get started.One of the main advantages of TypeScript is its static typing. By defining types for variables, function parameters, and return values, developers can catch type-related errors during development rather than at runtime. This leads to fewer bugs and a more predictable codebase. TypeScript type system is flexible and allows for gradual adoption, meaning you can start by adding types to only a few parts of your code and progressively type more as needed.TypeScript also introduces modern JavaScript features before they are officially adopted by the ECMAScript standard. This includes features like async/await, decorators, and modules. <br><br>These features make it easier to write clean and efficient code. TypeScript transpiler converts these features into compatible JavaScript code that can run on any browser or JavaScript engine. Another powerful feature of TypeScript is its support for interfaces and classes. Interfaces allow developers to define contracts for objects, ensuring that they have specific structures. Classes provide a way to define blueprints for objects, encapsulating data and behavior. This object-oriented approach helps in organizing and structuring code, especially in large projects. TypeScript tooling is another significant benefit. It offers excellent support for popular code editors like Visual Studio Code, providing features like autocompletion, type checking, and refactoring tools. This enhances productivity and helps developers write better code. TypeScript also integrates seamlessly with modern development frameworks like Angular, React, and Vue, making it a versatile choice for web development. To get started with TypeScript, you need to install it using npm (Node Package Manager). Once installed, you can start writing TypeScript code and compile it to JavaScript using the TypeScript compiler (tsc). <br><br>TypeScript configuration files (tsconfig.json) allow you to customize the compilation process and specify options like target JavaScript version, module system, and more. By learning TypeScript, developers can improve their JavaScript codebase with better type safety, modern features, and enhanced tooling. Whether you are working on a small project or a  large-scale application, TypeScript provides the tools and features needed to build maintainable and scalable software. Its popularity and adoption are growing rapidly, making it an essential skill for modern web development.', 1706004000000, 1706090400000, '/images/img12.jpg', 2),
('Understanding the Document Object Model (DOM)', 'The DOM is a programming interface that represents the structure of a web page as a tree-like structure of nodes. It provides a way for programs to interact with the content and structure of HTML and XML documents. In this article, we will delve into the details of the Document Object Model, including its structure, manipulation methods, and event handling. <br><br>The DOM represents each element of a web page as a node in a tree structure. The top-level node is called the document node, which represents the entire HTML document. Each element, attribute, and text node in the document is represented by a corresponding node in the tree. Nodes can have parent-child relationships, siblings, and other connections that reflect the structure of the document. One of the main purposes of the DOM is to provide a way to manipulate the content and structure of web pages dynamically. This includes tasks like adding, removing, or modifying elements, attributes, and text content. JavaScript is commonly used to interact with the DOM, using methods like getElementById, querySelector, and createElement to access and modify specific parts of the document. Event handling is another important aspect of the DOM. Events like clicks, mouse movements, and keyboard inputs trigger actions in web pages. JavaScript can be used to register event listeners on DOM elements, which execute specified code when events occur. <br><br>This allows for interactive and dynamic user experiences on the web.The DOM is divided into different levels and modules, each providing specific functionalities and features. The Core DOM Level 1 provides basic functionality for accessing and manipulating document structure. Subsequent levels, like DOM Level 2 and DOM Level 3, introduce additional features like XML support, event handling, and improved access to document elements. Understanding the Document Object Model is essential for web developers as it forms the foundation for client-side web development. By mastering DOM manipulation techniques and event handling, developers can create interactive and dynamic web applications. Whether you are building simple websites or complex web applications, a solid understanding of the DOM is crucial for success.', 1706176800000, 1706263200000, '/images/img13.jpg', 3),
('Building Progressive Web Apps (PWAs)', 'Progressive Web Apps are web applications that provide a native app-like experience to users while being built using web technologies such as HTML, CSS, and JavaScript. They offer features like offline support, push notifications, and the ability to install them on the user device, making them fast, reliable, and engaging. <br><br>In this article, we will explore the key concepts and techniques for building Progressive Web Apps (PWAs) and their benefits.PWAs leverage modern web capabilities to deliver a better user experience across different devices and platforms. They use responsive design principles to ensure that the app looks and works well on various screen sizes, from smartphones to desktops. PWAs are also designed to be fast and reliable, even on slow or unreliable networks. This is achieved through techniques like caching resources, pre-fetching data, and using service workers to manage network requests.<br><br>One of the key features of PWAs is offline support, which allows users to access the app even when they are offline or have a poor internet connection. This is achieved by caching resources and data when the user first visits the app, so they can be accessed later without an internet connection. Service workers play a crucial role in enabling offline support by intercepting network requests and serving cached responses.<br><br>Another important feature of PWAs is the ability to receive push notifications, which allows the app to engage with users even when they are not actively using it. Push notifications can be used to notify users about new content, updates, or important events, keeping them engaged and informed.

PWAs can also be installed on the user device, providing a more app-like experience. This is achieved through the web app manifest, a JSON file that provides metadata about the app, such as its name, icon, and theme color. When users install a PWA, it appears on their device home screen and can be launched like a native app, without the need for a web browser.<br><br>Building Progressive Web Apps (PWAs) offers several benefits for developers and users alike. They are fast, reliable, and engaging, providing a native app-like experience without the need for app stores or downloads. PWAs also offer improved discoverability and shareability, as they can be accessed via a URL and shared easily with others. By adopting PWA principles and best practices, developers can create high-quality web applications that deliver a superior user experience across different devices and platforms.', 1706349600000, 1706436000000, '/images/img14.jpg', 4),

('An Introduction to GraphQL', 'GraphQL is a query language for APIs and a runtime for executing those queries by using a type system you define for your data. It was developed by Facebook in 2012 and released as an open-source project in 2015. Unlike REST APIs, which expose a fixed set of endpoints that return predefined data structures, GraphQL allows clients to request only the data they need, in the format they specify. In this article, we will provide an overview of GraphQL, its core concepts, and how it differs from traditional REST APIs.<br><br>The key concept of GraphQL is the schema, which defines the types of data that can be queried and the relationships between them. Types include objects, scalars, enums, interfaces, unions, and input objects. With GraphQL, you define a single endpoint that accepts queries describing the data you want, rather than multiple endpoints for different resources. This enables clients to request nested data, avoiding issues like over-fetching and under-fetching.<br><br>Queries in GraphQL are hierarchical and follow the shape of the data you want to retrieve. Clients can specify which fields they want to fetch and traverse related objects in a single request. This reduces the number of round trips between the client and server, resulting in more efficient data fetching. Additionally, GraphQL supports aliases, fragments, variables, and directives to enhance query flexibility and reusability.<br><br>Mutations are used in GraphQL to modify data on the server. Similar to queries, mutations are defined in the schema and can accept arguments to specify the data to be modified. Mutations can create, update, or delete objects, and they can return any data type, including custom object types. GraphQL also supports subscriptions, which allow clients to receive real-time updates from the server when specific events occur.<br><br>Compared to REST APIs, GraphQL offers several advantages, including improved performance, reduced network overhead, and greater flexibility for clients. With GraphQL, clients can fetch data more efficiently and tailor responses to their specific requirements, leading to a better user experience. Additionally, GraphQL simplifies API evolution by allowing you to introduce changes to the schema without breaking existing clients.<br><br>In summary, GraphQL is a powerful alternative to traditional REST APIs for building flexible and efficient APIs. By defining a schema that describes your data types and relationships, you can enable clients to query and manipulate data in a more intuitive and efficient way. Whether you are building a web or mobile application, GraphQL provides a modern approach to data fetching and manipulation that can simplify your development workflow and improve overall performance.', 1706522400000, 1706608800000, '/images/img15.jpg', 5),

('Diving into Docker:  Guide for A Beginner', 'Docker  a platform for developing, shipping, and running applications in containers. It provides a way to package applications and their dependencies into isolated environments called containers, which can run on any operating system without modification. In this article, we will provide a comprehensive introduction to Docker, its core concepts, and how it revolutionizes the way software is built and deployed.<br><br>The key concept of Docker is the container, which encapsulates an application and its dependencies, including libraries, binaries, and configuration files. Containers are lightweight, portable, and self-sufficient, making them ideal for deploying applications in various environments, from development to production. Docker images serve as blueprints for containers, providing a snapshot of the applications filesystem and runtime configuration.<br><br>Docker uses a client-server architecture, where the Docker client interacts with the Docker daemon to manage containers, images, networks, and volumes. The Dockerfile is a text file that contains instructions for building a Docker image. It specifies the base image, environment variables, commands, and other configuration settings needed to create the image.<br><br>To run a Docker container, you use the docker run command, which pulls the specified image from a registry (e.g., Docker Hub) and creates a container instance based on that image. Docker containers can communicate with each other and with the outside world using networking and port mapping. They can also share data with the host system or other containers using volumes.<br><br>Docker Compose is a tool for defining and running multi-container Docker applications. It uses a YAML file (docker-compose.yml) to define services, networks, and volumes for the application, simplifying the process of managing complex application stacks.<br><br>Docker Swarm and Kubernetes are container orchestration platforms that automate the deployment, scaling, and management of containerized applications. They provide features like service discovery, load balancing, rolling updates, and high availability, making it easier to manage containers in production environments.<br><br>Docker has revolutionized the way software is developed, shipped, and deployed by providing a consistent and efficient way to package and run applications. By using containers, developers can build applications that are portable, scalable, and easy to manage. Whether you are a developer, system administrator, or DevOps engineer, Docker offers a powerful platform for modern application development and deployment.', 1706781600000, 1706868000000, '/images/img16.jpg', 1),

('Microservices Architecture: An Overview', 'Microservices architecture allows developers to build and maintain large, complex applications as a collection of smaller, independent services. Each service is responsible for a specific business function and can be developed, deployed, and scaled independently. In this article, we will provide an overview of microservices architecture, its benefits, challenges, and key principles.<br><br>

The key concept of microservices architecture is decomposition, which involves breaking down a monolithic application into smaller, loosely coupled services. Each service is designed around a specific business domain and communicates with other services through well-defined APIs. This allows developers to work on different services simultaneously and deploy changes without affecting the entire application.<br><br>

Microservices architecture offers several benefits, including improved scalability, agility, and resilience. Because services are independent, they can be scaled individually based on demand, leading to better resource utilization and cost efficiency. Microservices also enable faster development cycles and continuous delivery, as changes to one service can be deployed independently of others. Additionally, microservices promote fault isolation, as failures in one service are less likely to impact the entire application.<br><br>

However, microservices architecture also introduces challenges, such as increased complexity, operational overhead, and distributed system issues. Managing a large number of services requires robust infrastructure and tooling for deployment, monitoring, and orchestration. Communication between services can be complex and may require additional effort to ensure reliability and consistency. Additionally, microservices may introduce latency and network overhead, especially in distributed environments.<br><br>

Despite these challenges, microservices architecture offers a flexible and scalable approach to building modern applications. By breaking down monolithic systems into smaller, more manageable components, developers can create applications that are easier to understand, maintain, and scale. Whether you are building a new application from scratch or migrating an existing monolith, microservices architecture provides a powerful framework for building resilient and adaptable software systems.', 1706954400000, 1707040800000, '/images/img17.jpg', 2),
('Introduction to Kubernetes', 'Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications. Originally developed by Google, Kubernetes has become the de facto standard for container orchestration, providing a platform-agnostic solution for managing containerized workloads. In this article, we will provide an introduction to Kubernetes, its architecture, features, and benefits.<br><br>

At its core, Kubernetes is designed to abstract away the underlying infrastructure and provide a consistent API for deploying and managing applications. It organizes containers into logical units called pods, which are the smallest deployable units in Kubernetes. Pods can contain one or more containers that share resources and network namespaces, making them easy to deploy and manage.<br><br>

Kubernetes uses a declarative model for specifying desired state, where users define the desired state of their applications using YAML or JSON manifests. The Kubernetes control plane continuously monitors the actual state of the cluster and reconciles it with the desired state, ensuring that applications are always running as expected.<br><br>

One of the key features of Kubernetes is its ability to scale applications dynamically based on demand. Kubernetes can automatically scale the number of replicas of a deployment or stateful set based on metrics like CPU utilization or custom metrics, ensuring that applications have the resources they need to handle incoming traffic.<br><br>

Kubernetes also provides advanced features for managing application lifecycle, such as rolling updates, blue-green deployments, and canary deployments. These features allow users to update applications with zero downtime and minimize the risk of introducing bugs or regressions.<br><br>

In addition to deployment and scaling, Kubernetes provides built-in support for service discovery, load balancing, and storage orchestration. It offers a pluggable architecture with a rich ecosystem of add-ons and extensions, allowing users to customize and extend Kubernetes to meet their specific requirements.<br><br>

Overall, Kubernetes provides a powerful platform for building, deploying, and managing modern applications at scale. Whether you are running a small cluster on-premises or managing a large-scale deployment in the cloud, Kubernetes offers the tools and capabilities needed to streamline your operations and accelerate your development workflow.', 1707127200000, 1707213600000, '/images/img18.jpg', 3),

('Building RESTful APIs with Express.js', 'Express.js is a web application framework for Node.js that simplifies the process of building web servers and APIs. It provides a robust set of features for handling HTTP requests, routing, middleware, and more. In this article, we will explore how to build RESTful APIs with Express.js, including routing, request handling, data validation, and error handling.<br><br>

The core of any Express.js application is the server, which listens for incoming HTTP requests and routes them to the appropriate handler functions. Routing in Express.js is defined using HTTP methods (GET, POST, PUT, DELETE) and URL patterns, allowing developers to create RESTful endpoints for different resources. Middleware functions can be used to perform common tasks like parsing request bodies, authenticating users, and handling errors.<br><br>

Express.js provides built-in middleware and third-party middleware packages to extend its functionality. Some common middleware include body-parser for parsing request bodies, morgan for logging HTTP requests, and cors for enabling cross-origin resource sharing. Middleware can be applied globally to all routes or selectively to specific routes or route groups.<br><br>

When building RESTful APIs with Express.js, it is essential to follow best practices for request handling and data validation. Express.js supports various libraries and techniques for validating request data, such as express-validator for validating request parameters, body, and query strings. Error handling middleware can be used to catch errors and return appropriate HTTP responses with error details.<br><br>

In addition to request handling and validation, Express.js allows developers to integrate with databases, third-party services, and other resources. It provides a flexible architecture for organizing code into controllers, services, and models, making it easy to manage complex applications and scale as needed.<br><br>

Overall, Express.js is a powerful framework for building RESTful APIs and web servers with Node.js. Its simplicity, flexibility, and robust feature set make it a popular choice among developers for building modern web applications. Whether you are building a simple API or a complex microservices architecture, Express.js provides the tools and flexibility needed to get the job done.', 1707300000000, 1707386400000, '/images/img19.jpg', 4),

('Understanding Web Security', 'Web security is a critical aspect of building and maintaining web applications, as it protects sensitive data, prevents unauthorized access, and ensures the integrity and availability of services. In this article, we will explore the fundamentals of web security, common threats and vulnerabilities, and best practices for securing web applications.<br><br>

One of the fundamental principles of web security is the concept of the CIA triad: confidentiality, integrity, and availability. Confidentiality ensures that sensitive information is only accessible to authorized users, while integrity guarantees that data remains unchanged and trustworthy. Availability ensures that services are accessible and operational when needed.<br><br>

To achieve these goals, web developers need to implement various security measures and best practices. These include using HTTPS to encrypt data transmitted between clients and servers, implementing strong authentication and authorization mechanisms, and validating and sanitizing user input to prevent injection attacks.<br><br>

Common threats and vulnerabilities that web applications face include cross-site scripting (XSS), SQL injection, cross-site request forgery (CSRF), and insecure deserialization. XSS attacks occur when attackers inject malicious scripts into web pages viewed by other users, while SQL injection attacks exploit vulnerabilities in database queries to gain unauthorized access to data.<br><br>

To mitigate these threats, developers can use security headers like Content Security Policy (CSP) to prevent XSS attacks, parameterized queries to prevent SQL injection, and CSRF tokens to prevent CSRF attacks. Regular security audits and penetration testing can help identify and remediate vulnerabilities before they can be exploited by attackers.<br><br>

In addition to technical measures, web security also involves educating users about security best practices and raising awareness about potential threats. This includes promoting the use of strong, unique passwords, enabling multi-factor authentication, and teaching users to recognize phishing attempts and other social engineering attacks.<br><br>

Overall, web security is a multi-faceted discipline that requires a combination of technical controls, best practices, and user education. By understanding the principles of web security and implementing appropriate measures, developers can build web applications that are resilient to attacks and provide a safe and secure user experience.', 1707472800000, 1707559200000, '/images/img20.jpg', 5),

('A Guide to Responsive Web Design', 'Responsive web design is an approach to building websites that ensures a seamless user experience across devices of all sizes, from desktop computers to smartphones and tablets. It involves using flexible grids, layouts, and media queries to adapt the layout and content of a website to the dimensions and capabilities of the device being used. In this article, we will provide a comprehensive guide to responsive web design, including its principles, techniques, and best practices.<br><br>

The key principle of responsive web design is fluidity, which involves designing websites with flexible and proportion-based layouts that adapt to different screen sizes and orientations. This allows content to flow and resize dynamically, ensuring that users can access and interact with the website regardless of the device they are using.<br><br>

To achieve fluidity, web designers use a combination of techniques such as flexible grids, CSS media queries, and fluid images. Flexible grids use relative units like percentages or ems to define column widths and spacing, allowing them to adapt to the viewport size. Media queries allow designers to apply different styles based on factors like screen width, resolution, and device orientation.<br><br>

In addition to fluid layouts, responsive web design also involves optimizing images and media for different devices. This includes using responsive images that adapt to the size and resolution of the viewport, as well as optimizing file sizes and formats to minimize loading times and bandwidth usage.<br><br>

Another important aspect of responsive web design is usability, which involves ensuring that websites are easy to navigate and interact with on touchscreens and small screens. This includes optimizing touch targets, minimizing the need for scrolling and zooming, and prioritizing content based on importance and relevance.<br><br>

Responsive web design offers several benefits, including improved user experience, increased reach and accessibility, and simplified maintenance and updates. By designing websites that adapt to different devices, designers can ensure that users have a consistent and seamless experience regardless of how they access the website.<br><br>

Overall, responsive web design is essential for building modern websites that meet the needs and expectations of users in an increasingly mobile and diverse digital landscape. By following responsive design principles and techniques, designers can create websites that are flexible, accessible, and user-friendly, ensuring a positive experience for all users.', 1707645600000, 1707732000000, '/images/img21.jpg', 1),

('Introduction to Machine Learning', 'Machine learning is a field of artificial intelligence that enables computers to learn from data and improve their performance on specific tasks without being explicitly programmed. It involves building models and algorithms that can analyze data, identify patterns, and make predictions or decisions based on that data. In this article, we will provide an introduction to machine learning, its key concepts, algorithms, and applications.<br><br>

The core concept of machine learning is learning from data, which involves training a model on a dataset to recognize patterns and relationships. This process typically involves three main components: input data, a learning algorithm, and a model. The input data consists of features or attributes that describe the characteristics of the data, while the learning algorithm processes the data and adjusts the models parameters to minimize errors or optimize performance.<br><br>

There are several types of machine learning algorithms, including supervised learning, unsupervised learning, and reinforcement learning. In supervised learning, the model is trained on labeled data, where each example is associated with a target or outcome. The model learns to predict the target variable based on the input features. In unsupervised learning, the model is trained on unlabeled data and must learn to identify patterns or clusters in the data without explicit guidance. Reinforcement learning involves training an agent to interact with an environment and learn to take actions that maximize some notion of cumulative reward.<br><br>

Machine learning has numerous applications across various domains, including image and speech recognition, natural language processing, recommendation systems, autonomous vehicles, and healthcare. In image recognition, for example, machine learning models can analyze images and classify objects or detect anomalies. In natural language processing, machine learning models can process and understand human language, enabling applications like chatbots and language translation.<br><br>

To build machine learning models, developers and data scientists typically use libraries and frameworks like TensorFlow, PyTorch, and scikit-learn. These tools provide high-level APIs and pre-built algorithms for tasks like classification, regression, clustering, and dimensionality reduction. They also offer tools for data preprocessing, model evaluation, and deployment, making it easier to build and deploy machine learning applications.<br><br>

Overall, machine learning is a powerful tool for solving complex problems and extracting insights from data. By leveraging machine learning techniques and algorithms, developers and data scientists can build intelligent systems that can learn from experience and improve over time, enabling a wide range of applications and innovations in various fields.', 1707818400000, 1707904800000, '/images/img22.jpg', 2),

('Exploring the Django Framework', 'Django is a high-level Python web framework that enables rapid development of secure and scalable web applications. It follows the "do not repeat yourself" (DRY) principle and emphasizes the use of reusable components, clean design, and rapid development. In this article, we will explore the Django framework, its key features, architecture, and best practices.<br><br>

At the heart of Django is its design philosophy, which revolves around simplicity, flexibility, and scalability. Django provides a set of built-in components and conventions for common web development tasks, such as URL routing, template rendering, form handling, authentication, and database management. This allows developers to focus on building application logic rather than dealing with low-level details.<br><br>

One of the key features of Django is its ORM (Object-Relational Mapping) layer, which abstracts away the complexity of database management and allows developers to interact with databases using high-level Python objects. Django supports multiple database backends, including PostgreSQL, MySQL, SQLite, and Oracle, and provides tools for database migrations, schema management, and query optimization.<br><br>

Django also comes with a powerful administrative interface, known as the Django Admin, which allows developers to create, read, update, and delete data from the database without writing any code. The Django Admin is highly customizable and can be extended to support custom data models, filters, and actions, making it a valuable tool for managing web applications.<br><br>

In addition to built-in features, Django offers a rich ecosystem of third-party packages and extensions, known as Django apps, that extend the frameworks functionality. These apps cover a wide range of use cases, including user authentication, content management, e-commerce, and API development, allowing developers to leverage existing solutions and accelerate development.<br><br>

Django follows a Model-View-Template (MVT) architecture, where models represent the data structure, views handle the business logic and user interactions, and templates define the presentation layer. This separation of concerns makes Django applications easy to maintain, test, and scale, as each component is responsible for a specific aspect of the application.<br><br>

Overall, Django is a powerful framework for building web applications with Python. Its clean design, built-in features, and vibrant ecosystem make it a popular choice for developers looking to build secure, scalable, and maintainable web applications. Whether you are building a simple blog or a complex enterprise application, Django provides the tools and conventions needed to streamline development and deliver high-quality software.', 1707991200000, 1708077600000, '/images/img23.jpg', 3),
('Getting Started with Angular', 'Angular is a platform for building client-side web applications with TypeScript, HTML, and CSS. Developed and maintained by Google, Angular provides a comprehensive framework for building modern, scalable, and maintainable web applications. In this article, we will cover the basics of Angular, including its key features, architecture, and how to get started with building Angular applications.<br><br>

One of the key features of Angular is its use of TypeScript, a statically typed superset of JavaScript, which adds features like static typing, interfaces, and decorators to JavaScript. TypeScript enhances developer productivity and code maintainability by catching errors at compile-time and providing better tooling and code organization.<br><br>

Angular follows the component-based architecture, where applications are built by composing reusable components that encapsulate HTML templates, CSS styles, and application logic. Components are the building blocks of Angular applications and can be nested and composed to create complex user interfaces.<br><br>

Angular provides a powerful and declarative template syntax that allows developers to bind data to HTML elements, handle user events, and create dynamic views. Directives like ngIf, ngFor, and ngClass enable conditional rendering, iteration, and styling of HTML elements, while pipes allow for data transformation and formatting.<br><br>

Angular applications are organized into modules, which are collections of related components, directives, services, and other Angular constructs. Modules provide a way to organize and encapsulate application functionality, making it easier to manage large applications and promote code reusability.<br><br>

In addition to components and modules, Angular provides services, which are reusable classes that encapsulate shared functionality, such as data fetching, authentication, and logging. Services are singleton objects that can be injected into components and other Angular constructs using dependency injection.<br><br>

To get started with Angular, developers can use the Angular CLI (Command Line Interface), a powerful tool for generating, building, and testing Angular applications. The Angular CLI provides commands for creating new projects, generating components, services, and modules, and running development and production builds.<br><br>

Overall, Angular is a comprehensive framework for building modern web applications with TypeScript. Its use of components, modules, and services promotes code reusability, maintainability, and scalability, making it an ideal choice for building large-scale and enterprise-grade applications. Whether you are building a simple SPA (Single Page Application) or a complex enterprise application, Angular provides the tools and conventions needed to streamline development and deliver high-quality software.', 1708164000000, 1708250400000, '/images/img24.jpg', 4),

('The Basics of SQL and Databases', 'SQL is a standard language for managing relational databases and performing various operations such as querying, updating, and manipulating data. It stands for Structured Query Language and is widely used in the development of database-driven applications. In this article, we will cover the fundamentals of SQL and databases, including basic SQL syntax, database concepts, and common operations.<br><br>

SQL operates on relational databases, which organize data into tables consisting of rows and columns. Each table represents an entity or concept, and each row represents a single record or instance of that entity. Columns define the attributes or properties of the entity, and each cell in the table holds a single value.<br><br>

The basic operations in SQL include querying data with SELECT statements, inserting new data with INSERT statements, updating existing data with UPDATE statements, and deleting data with DELETE statements. SELECT statements are used to retrieve data from one or more tables based on specified criteria, while INSERT statements are used to add new records to a table. UPDATE statements modify existing records, and DELETE statements remove records from a table.<br><br>

SQL also supports filtering and sorting data using WHERE and ORDER BY clauses, respectively. The WHERE clause allows you to specify conditions that must be met for a row to be included in the result set, while the ORDER BY clause allows you to specify the order in which rows should be returned.<br><br>

In addition to querying and modifying data, SQL provides various other features such as creating and modifying database schemas, defining relationships between tables using foreign keys, and creating indexes to improve query performance. SQL also supports transactions, which allow you to group multiple operations into a single unit of work that is executed atomically and ensures data consistency.<br><br>

Common database management systems (DBMS) that support SQL include MySQL, PostgreSQL, SQLite, Microsoft SQL Server, and Oracle Database. Each DBMS has its own dialect of SQL, but the core syntax and concepts are generally consistent across different implementations.<br><br>

Overall, SQL is a powerful and versatile language for working with relational databases. Whether you are a beginner learning the basics of database management or an experienced developer building complex database-driven applications, SQL provides the tools and capabilities needed to manage and manipulate data effectively.', 1708336800000, 1708423200000, '/images/img25.jpg', 5),

('Introduction to DevOps', 'DevOps is a set of practices that combines software development (Dev) and IT operations (Ops) to shorten the systems development life cycle and provide continuous delivery of high-quality software. It aims to automate and streamline the processes of building, testing, deploying, and monitoring applications, allowing organizations to deliver value to customers faster and more efficiently. In this article, we will provide an introduction to DevOps, its principles, key practices, and benefits.<br><br>

The core principle of DevOps is collaboration between development and operations teams throughout the software development lifecycle. By breaking down silos and fostering cross-functional teams, DevOps encourages collaboration, communication, and shared responsibility for delivering and maintaining software.<br><br>

DevOps practices emphasize automation at every stage of the development lifecycle, from code commit to production deployment. Continuous integration (CI) involves automatically building, testing, and integrating code changes into a shared repository whenever a developer commits code. Continuous delivery (CD) extends CI by automatically deploying code changes to production-like environments for further testing and validation.<br><br>

Infrastructure as code (IaC) is another key practice in DevOps, which involves managing infrastructure using code and automation tools like Terraform, Ansible, or Puppet. By treating infrastructure as code, organizations can version control infrastructure configurations, provision resources dynamically, and ensure consistency across environments.<br><br>

DevOps also promotes a culture of measurement and feedback, where teams collect and analyze data to identify bottlenecks, inefficiencies, and areas for improvement. By monitoring key performance indicators (KPIs) and user feedback, teams can make data-driven decisions to optimize processes and improve software quality.<br><br>

One of the primary benefits of DevOps is increased agility and responsiveness to customer needs. By automating manual tasks, reducing cycle times, and improving collaboration, DevOps enables organizations to deliver features and updates to customers faster and more frequently, leading to higher customer satisfaction and retention.<br><br>

DevOps also promotes reliability and stability by emphasizing practices like infrastructure automation, automated testing, and continuous monitoring. By detecting and addressing issues early in the development lifecycle, organizations can minimize downtime, reduce the risk of outages, and improve the overall reliability of their systems.<br><br>

Overall, DevOps is a transformative approach to software development and delivery that emphasizes collaboration, automation, and continuous improvement. By adopting DevOps practices and principles, organizations can accelerate their digital transformation journey, increase innovation, and deliver value to customers more effectively.', 1708509600000, 1708596000000, '/images/img26.jpg', 1),

('Building Mobile Apps with Flutter', 'Flutter is an open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase. It provides a fast, expressive, and flexible framework for building beautiful and native user interfaces using the Dart programming language. In this article, we will explore how to build mobile apps with Flutter, its key features, and advantages.<br><br>

One of the key features of Flutter is its reactive framework, which allows developers to create UI components that automatically update in response to changes in data or user interactions. Flutter uses a declarative syntax for building UIs, where widgets describe the desired state of the UI, and Flutter handles the rendering and updating of the UI automatically.<br><br>

Flutter provides a rich set of pre-built widgets for building complex UIs, including material design and Cupertino widgets for Android and iOS respectively. These widgets are highly customizable and can be easily composed to create custom UI elements and layouts. Flutters hot reload feature allows developers to make changes to their code and see the results instantly, making the development process fast and efficient.<br><br>

Another key advantage of Flutter is its platform independence, which allows developers to write once and deploy to multiple platforms. Flutter apps are compiled to native machine code, which ensures high performance and native-like user experiences on each platform. This eliminates the need for separate codebases and reduces development time and effort.<br><br>

Flutter also provides a rich ecosystem of packages and plugins for integrating with native platform features and third-party services. Developers can easily add features like camera access, location services, push notifications, and in-app purchases using Flutter plugins, saving time and effort in development.<br><br>

In addition to mobile apps, Flutter can also be used to build web and desktop applications using the same codebase. Flutter for web allows developers to compile Flutter apps to JavaScript and run them in web browsers, while Flutter for desktop enables building native desktop applications for Windows, macOS, and Linux.<br><br>

Overall, Flutter is a powerful and versatile framework for building mobile apps that offers high performance, expressive UIs, and platform independence. Whether you are a beginner getting started with mobile app development or an experienced developer building cross-platform applications, Flutter provides the tools and capabilities needed to create beautiful and performant apps.', 1708682400000, 1708768800000, '/images/img27.jpg', 2),
('Understanding Blockchain Technology', 'Blockchain is a distributed ledger technology that enables secure, transparent, and tamper-proof recording of transactions across a network of computers. It operates as a decentralized database, where data is stored in blocks that are linked together in a chronological and immutable chain. In this article, we will explore the fundamentals of blockchain technology, its key components, and real-world applications.<br><br>

At its core, blockchain consists of a chain of blocks, each containing a list of transactions. These blocks are linked together using cryptographic hashes, which ensure the integrity and immutability of the data. Once a block is added to the blockchain, it becomes part of a permanent and unalterable record of transactions.<br><br>

Blockchain operates on a peer-to-peer network of computers, known as nodes, which participate in the validation and consensus process. Transactions are verified and validated by nodes through a process called consensus, which ensures that all copies of the blockchain are synchronized and consistent across the network.<br><br>

One of the key features of blockchain is its transparency and auditability, which allows anyone to view the entire history of transactions on the blockchain. This transparency fosters trust and accountability, as it eliminates the need for intermediaries and central authorities to validate and record transactions.<br><br>

Blockchain technology enables a wide range of applications beyond cryptocurrency, including supply chain management, identity verification, voting systems, and smart contracts. In supply chain management, blockchain can track the provenance and movement of goods from the point of origin to the end consumer, ensuring transparency and accountability throughout the supply chain.<br><br>

Identity verification systems built on blockchain allow individuals to securely store and manage their digital identities, reducing the risk of identity theft and fraud. Blockchain-based voting systems provide a secure and transparent way to conduct elections, ensuring the integrity and fairness of the voting process.<br><br>

Smart contracts are self-executing contracts with the terms of the agreement directly written into code. They run on blockchain platforms like Ethereum and automatically enforce the terms of the contract when predefined conditions are met, without the need for intermediaries or third parties.<br><br>

Overall, blockchain technology has the potential to revolutionize various industries by providing a secure, transparent, and decentralized platform for recording and verifying transactions. Whether you are interested in finance, supply chain, healthcare, or governance, understanding blockchain technology is essential for navigating the future of digital innovation.', 1708855200000, 1708941600000, '/images/img28.jpg', 3),

('A Guide to Cybersecurity', 'Cybersecurity involves protecting computer systems, networks, and data from unauthorized access, cyberattacks, and other security threats. With the increasing reliance on technology in our personal and professional lives, cybersecurity has become a critical concern for individuals, organizations, and governments worldwide. In this article, we will provide a comprehensive guide to cybersecurity, including its importance, key principles, best practices, and emerging trends.<br><br>

The importance of cybersecurity cannot be overstated, as cyberattacks can have severe consequences, including data breaches, financial losses, reputational damage, and even legal liabilities. Cybersecurity aims to mitigate these risks by implementing measures to prevent, detect, and respond to security incidents and breaches.<br><br>

One of the key principles of cybersecurity is defense in depth, which involves implementing multiple layers of security controls to protect against different types of threats. This includes measures such as firewalls, antivirus software, intrusion detection systems, encryption, and access controls, among others.<br><br>

Cybersecurity best practices encompass a wide range of areas, including network security, endpoint security, data protection, incident response, and security awareness training. Network security measures aim to protect the organizations network infrastructure from unauthorized access and malicious activities, while endpoint security focuses on securing individual devices like computers, smartphones, and tablets.<br><br>

Data protection involves safeguarding sensitive information from unauthorized access, disclosure, or modification. This includes measures such as encryption, data masking, access controls, and regular data backups. Incident response plans outline the steps to be taken in the event of a security incident or breach, including detection, containment, eradication, and recovery.<br><br>

Security awareness training is essential for educating employees and users about cybersecurity risks and best practices. This includes training on topics such as phishing awareness, password security, social engineering, and safe browsing habits.<br><br>

Emerging trends in cybersecurity include the rise of artificial intelligence and machine learning for threat detection and response, the adoption of zero-trust security models, the proliferation of cloud-based security solutions, and the increasing importance of data privacy and compliance regulations such as GDPR and CCPA.<br><br>

Overall, cybersecurity is a dynamic and evolving field that requires ongoing vigilance, investment, and collaboration to stay ahead of emerging threats and protect against cyberattacks. By implementing robust cybersecurity measures, organizations can safeguard their assets, maintain trust and confidence among stakeholders, and ensure the integrity, confidentiality, and availability of their systems and data.', 1709028000000, 1709114400000, '/images/img29.jpg', 4),

('Introduction to Artificial Intelligence', 'Artificial intelligence (AI) is the simulation of human intelligence processes by machines, especially computer systems. It encompasses various techniques and approaches that enable machines to perform tasks that typically require human intelligence, such as learning, reasoning, problem-solving, perception, and natural language understanding. In this article, we will provide an introduction to artificial intelligence, its key concepts, techniques, and applications.<br><br>

AI can be broadly classified into two categories: narrow AI and general AI. Narrow AI, also known as weak AI, is designed to perform specific tasks within a limited domain, such as playing chess, recognizing speech, or driving a car. General AI, also known as strong AI, refers to machines with the ability to understand, learn, and apply intelligence across a wide range of tasks, similar to human intelligence.<br><br>

One of the key techniques used in AI is machine learning, which involves training algorithms on large datasets to recognize patterns and make predictions or decisions without being explicitly programmed. Machine learning algorithms can be categorized into supervised learning, unsupervised learning, and reinforcement learning, depending on the type of data and feedback used for training.<br><br>

Supervised learning involves training a model on labeled data, where each example is associated with a target or outcome. The model learns to predict the target variable based on the input features. Unsupervised learning involves training a model on unlabeled data and learning to identify patterns or clusters in the data without explicit guidance. Reinforcement learning involves training an agent to interact with an environment and learn to take actions that maximize some notion of cumulative reward.<br><br>

AI has numerous applications across various domains, including healthcare, finance, autonomous vehicles, natural language processing, computer vision, and gaming, among others. In healthcare, AI can be used for disease diagnosis, personalized treatment planning, drug discovery, and medical image analysis. In finance, AI can be used for fraud detection, algorithmic trading, risk assessment, and customer service automation.<br><br>

In addition to machine learning, AI encompasses other techniques such as expert systems, knowledge representation, natural language processing, and computer vision. Expert systems use rules and logical reasoning to solve problems within a specific domain, while knowledge representation techniques enable machines to represent and reason about knowledge in a structured format.<br><br>

Overall, artificial intelligence is a rapidly evolving field with the potential to transform industries, drive innovation, and improve human lives. Whether you are a beginner learning the basics of AI or an experienced practitioner exploring advanced techniques, understanding artificial intelligence is essential for navigating the future of technology and innovation.', 1709290800000, 1709377200000, '/images/img30.jpg', 5),

('Exploring the ASP.NET Core Framework', 'ASP.NET Core is a cross-platform, open-source framework for building modern, cloud-based web applications and services. It is the next generation of Microsoft ASP.NET framework and offers a fast, modular, and scalable platform for developing web applications using C# and .NET. In this article, we will explore the ASP.NET Core framework, its key features, architecture, and how to get started with building web applications.<br><br>

One of the key features of ASP.NET Core is its cross-platform support, which allows developers to build and run applications on Windows, macOS, and Linux. This makes ASP.NET Core ideal for building cloud-native and containerized applications that can run on any platform and scale easily with demand.<br><br>

ASP.NET Core follows a modular and lightweight architecture, where the framework is divided into smaller, self-contained packages known as NuGet packages. This modular architecture allows developers to include only the components they need, reducing the size and complexity of applications and improving performance and startup time.<br><br>

ASP.NET Core supports multiple development models, including MVC (Model-View-Controller), Razor Pages, Web APIs, and SignalR for real-time web functionality. MVC is a popular design pattern for building web applications, where models represent the applications data, views display the data to users, and controllers handle user requests and update the model and view accordingly.<br><br>

Razor Pages is a lightweight alternative to MVC that allows developers to build web pages with minimal ceremony and configuration. It simplifies the development of CRUD (Create, Read, Update, Delete) interfaces and is well-suited for building simple, data-driven web applications.<br><br>

Web APIs enable developers to build RESTful services for exposing data and functionality to client applications using standard HTTP methods and protocols. ASP.NET Core provides built-in support for JSON serialization, content negotiation, routing, and authentication, making it easy to build secure and scalable APIs.<br><br>

SignalR is a library for adding real-time functionality to web applications, allowing server-side code to push content to connected clients in real-time. It enables scenarios such as chat applications, live updates, and notifications without the need for polling or constant refreshes.<br><br>

To get started with ASP.NET Core development, developers can use Visual Studio, Visual Studio Code, or the .NET CLI (Command Line Interface). Visual Studio provides a rich set of tools for building, debugging, and deploying ASP.NET Core applications, while Visual Studio Code offers a lightweight and cross-platform IDE with support for extensions and plugins.<br><br>

Overall, ASP.NET Core is a versatile and powerful framework for building modern web applications and services. Whether you are a beginner getting started with web development or an experienced developer building enterprise-grade applications, ASP.NET Core provides the tools and capabilities needed to build scalable, secure, and high-performance web applications.', 1709463600000, 1709550000000, '/images/img31.jpg', 1),

('Building Interactive Websites with jQuery', 'jQuery is a fast, small, and feature-rich JavaScript library that simplifies HTML document traversing, event handling, animating, and Ajax interactions for rapid web development. It provides a concise and expressive API for manipulating the DOM (Document Object Model) and adding interactivity to websites with less code and better cross-browser compatibility. In this article, we will explore how to leverage jQuery to build interactive and dynamic websites.<br><br>

One of the key features of jQuery is its ability to simplify DOM manipulation and traversal. jQuery allows developers to select elements from the DOM using CSS-like selectors and perform actions on them using methods like .html(), .text(), .css(), .addClass(), .removeClass(), and .toggle(). This makes it easy to update the content, style, and structure of web pages dynamically in response to user interactions or events.<br><br>

jQuery also provides powerful event handling capabilities, allowing developers to attach event handlers to DOM elements and respond to user actions such as clicks, mouse movements, keypresses, and form submissions. Event handling in jQuery is simple and intuitive, using methods like .on(), .click(), .hover(), .keypress(), and .submit() to bind event handlers to elements.<br><br>

Another key feature of jQuery is its support for animations and effects, which allows developers to create smooth transitions, fades, slides, and other visual effects to enhance the user experience. jQuery provides methods like .fadeIn(), .fadeOut(), .slideDown(), .slideUp(), .animate(), and .toggle() for creating animations and effects with ease.<br><br>

jQuerys Ajax (Asynchronous JavaScript and XML) capabilities enable developers to perform asynchronous HTTP requests and update parts of a web page without reloading the entire page. jQuery provides methods like .ajax(), .get(), .post(), .load(), and .getJSON() for making Ajax requests and handling responses from the server.<br><br>

To get started with jQuery development, developers can include the jQuery library in their HTML documents using a <script> tag or link to it from a CDN (Content Delivery Network). They can then write jQuery code inside a <script> tag or in an external JavaScript file to manipulate the DOM, handle events, create animations, and perform Ajax interactions.<br><br>

Overall, jQuery is a versatile and powerful tool for building interactive and dynamic websites with JavaScript. Whether you are a beginner learning the basics of web development or an experienced developer looking to streamline your workflow and improve productivity, jQuery provides the tools and capabilities needed to create engaging and responsive web experiences.', 1709636400000, 1709722800000, '/images/img32.jpg', 2),

('Getting Started with Laravel', 'Laravel is a web application framework that provides an elegant and expressive syntax for writing code and building modern PHP applications. It follows the model-view-controller (MVC) architectural pattern and includes features such as routing, middleware, authentication, and database ORM (Object-Relational Mapping) out of the box. In this article, we will explore how to get started with Laravel, its key features, and best practices for building web applications.<br><br>

One of the key features of Laravel is its expressive and intuitive syntax, which simplifies common tasks such as routing, templating, and database access. Laravel uses the Blade templating engine for generating dynamic HTML content, allowing developers to write clean and readable template files with minimal overhead.<br><br>

Laravels routing system allows developers to define application routes using a simple and expressive syntax. Routes can respond to different HTTP request methods (GET, POST, PUT, DELETE) and parameters, making it easy to create RESTful APIs and web interfaces with clean and semantic URLs.<br><br>

Middleware in Laravel provides a convenient mechanism for filtering HTTP requests entering the application. Middleware can perform tasks such as authentication, authorization, logging, and input validation, allowing developers to encapsulate cross-cutting concerns and apply them to specific routes or groups of routes.<br><br>

Laravel includes built-in support for authentication and authorization, making it easy to implement user authentication, registration, and access control in web applications. Laravels authentication system provides drivers for popular authentication methods such as database, OAuth, and LDAP, as well as support for multi-factor authentication and API token authentication.<br><br>

Laravels Eloquent ORM provides a simple and expressive ActiveRecord implementation for working with databases in PHP. Eloquent allows developers to define database models using PHP classes and interact with database records using a fluent and expressive API. It supports relationships, eager loading, query scopes, and other advanced features for working with relational databases.<br><br>

To get started with Laravel development, developers can install Laravel using Composer, a dependency manager for PHP, and use the Laravel CLI (Command Line Interface) to generate a new Laravel project. Laravels documentation provides comprehensive guides and tutorials for learning Laravel and building web applications with Laravel.<br><br>

Overall, Laravel is a powerful and versatile framework for building modern web applications with PHP. Its expressive syntax, rich feature set, and vibrant ecosystem of packages make it a popular choice for developers looking to build scalable, maintainable, and feature-rich web applications.', 1709809200000, 1709895600000, '/images/img33.jpg', 3),

('A Comprehensive Guide to CSS Flexbox', 'CSS Flexbox is a layout model that provides a more efficient way to design and structure web pages, allowing for flexible and dynamic layouts without relying on floats or positioning. It simplifies the process of building complex layouts by providing a set of properties for distributing space, aligning items, and controlling their flow within a container. In this article, we will provide a comprehensive guide to CSS Flexbox, covering its key concepts, properties, and practical examples.<br><br>

Flexbox operates on a one-dimensional layout model, allowing for flexible arrangement of elements along a single axis (either horizontally or vertically). It consists of flex containers, which contain flex items, and provides properties for controlling the layout, alignment, and spacing of these items within the container.<br><br>

One of the key concepts of Flexbox is the main axis and cross axis, which determine the direction in which flex items are laid out within the container. The main axis is defined by the flex-direction property and can be horizontal (row) or vertical (column), while the cross axis is perpendicular to the main axis.<br><br>

Flexbox provides several properties for controlling the layout and alignment of flex items within the container. The justify-content property aligns items along the main axis, allowing for distribution of space between and around items. The align-items property aligns items along the cross axis, controlling their alignment within the container.<br><br>

Flexbox also offers properties for controlling the sizing and spacing of flex items. The flex-grow property specifies how flex items should grow relative to one another to fill available space, while the flex-shrink property specifies how items should shrink when there is not enough space available. The flex-basis property defines the initial size of flex items before they are distributed in the container.<br><br>

Using these properties, developers can create a wide range of layouts with Flexbox, including equal-height columns, vertically centering content, and creating responsive grids. Flexbox also provides support for nesting flex containers and ordering flex items, allowing for greater flexibility and control over layout.<br><br>

In addition to its layout capabilities, Flexbox also provides features for handling overflow, wrapping, and alignment of flex items within the container. The flex-wrap property controls whether flex items should wrap onto multiple lines or remain on a single line, while the align-content property aligns flex lines within the container when there is extra space available.<br><br>

Overall, CSS Flexbox is a powerful and versatile layout model that simplifies the process of building complex web layouts. Whether you are a beginner learning the basics of web design or an experienced developer looking to streamline your layout workflow, mastering Flexbox is essential for creating modern, responsive web designs.', 1709982000000, 1710068400000, '/images/img34.jpg', 4),

('Understanding API Integration', 'API integration is the process of connecting different software applications or systems through their APIs (Application Programming Interfaces) to enable them to communicate and share data with each other. APIs define the methods and protocols for interacting with a software application or service, allowing developers to access its functionality and data programmatically. In this article, we will explore the concept of API integration, its benefits, common use cases, and best practices.<br><br>

API integration plays a crucial role in modern software development, enabling interoperability between disparate systems and applications. It allows developers to leverage the functionality and data of external services and platforms, such as social media networks, payment gateways, cloud storage providers, and third-party APIs, to enhance the capabilities of their own applications.<br><br>

One of the key benefits of API integration is the ability to streamline business processes and workflows by automating data exchange and synchronization between different systems. For example, an e-commerce website may integrate with a payment gateway API to process online payments, a shipping API to calculate shipping costs and track shipments, and a customer relationship management (CRM) API to synchronize customer data.<br><br>

API integration also enables the creation of seamless user experiences by allowing applications to access and share data across platforms and devices. For example, a mobile app may integrate with social media APIs to allow users to sign in with their social media accounts, share content, and retrieve user data, providing a personalized and integrated experience.<br><br>

Common use cases for API integration include:

1. Payment processing: Integrating with payment gateway APIs to securely process online payments and manage transactions.<br>
2. Data synchronization: Synchronizing data between different applications or databases to ensure consistency and accuracy.<br>
3. Social media integration: Integrating with social media APIs to enable social login, sharing, and access to user data.<br>
4. Third-party services: Integrating with third-party APIs for accessing services such as mapping, weather, messaging, and analytics.
5. Webhooks: Using webhooks to receive real-time notifications and trigger actions in response to events from external systems or services.<br>

When implementing API integration, it`''`s important to follow best practices to ensure security, reliability, and scalability. This includes using secure authentication mechanisms such as OAuth or API keys, implementing rate limiting and error handling mechanisms to handle traffic spikes and prevent service disruptions, and documenting APIs properly to facilitate integration and development.<br><br>

Overall, API integration is a fundamental aspect of modern software development, enabling applications to communicate, share data, and work together seamlessly. Whether you`''`re building a web application, mobile app, or enterprise system, understanding API integration is essential for creating connected and interoperable software solutions.', 1710154800000, 1710241200000, '/images/img35.jpg', 5),

('Introduction to Cloud Computing', 'Cloud computing is the delivery of computing services over the internet, providing access to a shared pool of resources, including servers, storage, databases, networking, software, and applications, on-demand. It offers a flexible and cost-effective alternative to traditional on-premises infrastructure, allowing organizations to scale resources up or down based on demand and pay only for what they use. In this article, we will provide an introduction to cloud computing, its key concepts, deployment models, and benefits.<br><br>

Cloud computing is based on the concept of virtualization, where physical hardware resources are abstracted and pooled together to create virtualized computing environments that can be dynamically provisioned and managed. This allows organizations to achieve greater efficiency, agility, and scalability compared to traditional IT infrastructure.<br><br>

One of the key benefits of cloud computing is its scalability, allowing organizations to rapidly scale resources up or down based on demand. Cloud providers offer elastic computing resources that can automatically adjust to accommodate fluctuations in workload, ensuring optimal performance and cost efficiency.<br><br>

Cloud computing offers several deployment models, including public cloud, private cloud, hybrid cloud, and multi-cloud. Public cloud services are provided by third-party cloud providers and made available to the general public over the internet. Private cloud infrastructure is dedicated to a single organization and can be hosted on-premises or in a third-party data center. Hybrid cloud combines public and private cloud environments, allowing organizations to leverage the benefits of both. Multi-cloud refers to the use of multiple cloud providers to avoid vendor lock-in and improve redundancy and resilience.<br><br>

Cloud computing services are typically categorized into three main service models: Infrastructure as a Service (IaaS), Platform as a Service (PaaS), and Software as a Service (SaaS). IaaS provides virtualized computing resources, such as virtual machines, storage, and networking, allowing organizations to build and manage their own infrastructure. PaaS provides a platform for developing, deploying, and managing applications without the complexity of infrastructure management. SaaS delivers software applications over the internet on a subscription basis, eliminating the need for installation and maintenance.<br><br>

Some of the key benefits of cloud computing include:

1. Cost savings: Cloud computing eliminates the need for upfront capital investments in hardware and infrastructure, allowing organizations to pay only for what they use on a pay-as-you-go basis.<br>
2. Scalability: Cloud computing allows organizations to rapidly scale resources up or down based on demand, ensuring optimal performance and cost efficiency.<br>
3. Agility: Cloud computing enables faster deployment of applications and services, reducing time-to-market and improving business agility and innovation.<br>
4. Accessibility: Cloud computing provides access to computing resources from anywhere with an internet connection, enabling remote work and collaboration.<br><br>

Overall, cloud computing is a transformative technology that offers organizations the flexibility, scalability, and cost-efficiency needed to innovate and compete in today`''`s digital economy.', 1710327600000, 1710414000000, '/images/img36.jpg', 1),

('Building Scalable Web Applications', 'Scalable web applications are designed to handle growing amounts of traffic, data, and users while maintaining performance, reliability, and availability. Building scalable web applications requires careful planning, architecture, and design to ensure that the application can scale horizontally and vertically to meet increasing demand. In this article, we will explore the principles, strategies, and best practices for building scalable web applications.<br><br>

One of the key principles of building scalable web applications is designing for scalability from the outset. This involves breaking down the application into smaller, independent components or services that can be scaled independently. By decoupling components and services, developers can scale specific parts of the application as needed without affecting the entire system.<br><br>

Horizontal scaling involves adding more instances of the application or service to distribute the load across multiple servers or resources. This can be achieved using techniques such as load balancing, auto-scaling, and containerization. Load balancers distribute incoming traffic across multiple instances of the application, ensuring that no single server becomes overwhelmed. Auto-scaling automatically adjusts the number of instances based on demand, allowing the application to scale up or down dynamically. Containerization technologies like Docker and Kubernetes provide a lightweight and scalable approach to deploying and managing applications in containers.<br><br>

Vertical scaling involves increasing the resources (such as CPU, memory, and storage) of individual servers to handle increased demand. While vertical scaling can provide immediate capacity increases, it may eventually reach limitations in terms of hardware capacity and cost-effectiveness.<br><br>

Scalable web applications also require efficient data management strategies to handle growing amounts of data. This includes using scalable databases and data storage solutions, caching frequently accessed data, and optimizing database queries and indexing. NoSQL databases like MongoDB, Cassandra, and Redis are often used for their ability to scale horizontally and handle large volumes of data.<br><br>

Another important consideration in building scalable web applications is fault tolerance and resilience. This involves designing the application to gracefully handle failures and recover from errors without impacting the user experience. Techniques such as replication, redundancy, and graceful degradation can help ensure high availability and reliability.<br><br>

Monitoring and performance testing are essential aspects of building scalable web applications. Continuous monitoring allows developers to identify performance bottlenecks, resource utilization, and scalability issues in real-time and take proactive measures to address them. Performance testing helps validate the scalability and performance of the application under different loads and conditions.<br><br>

Overall, building scalable web applications requires a combination of architectural best practices, scalable infrastructure, efficient data management, fault tolerance, and performance optimization. By following these principles and strategies, developers can create web applications that can scale to meet the demands of growing traffic, data, and users.', 1710500400000, 1710586800000, '/images/img37.jpg', 2),

('Exploring WebAssembly', 'WebAssembly is a binary instruction format that enables high-performance execution of code on the web. It is designed to complement JavaScript and provide a more efficient and secure runtime environment for running web applications. WebAssembly allows developers to compile code written in languages such as C, C++, and Rust into a compact binary format that can be executed in web browsers at near-native speeds. In this article, we will explore WebAssembly, its key features, benefits, and use cases.<br><br>

One of the key features of WebAssembly is its performance. By providing a low-level, close-to-the-metal execution environment, WebAssembly enables web applications to achieve near-native performance, making it suitable for computationally intensive tasks such as gaming, multimedia processing, and scientific simulations. WebAssembly leverages hardware capabilities such as multi-core processors, SIMD (Single Instruction, Multiple Data) instructions, and efficient memory management to optimize performance.<br><br>

WebAssembly is designed to be portable and platform-independent, allowing code compiled to WebAssembly to run consistently across different devices and architectures. This makes it easier for developers to build cross-platform web applications that work seamlessly on desktops, laptops, tablets, and mobile devices, without the need for platform-specific optimizations or modifications.<br><br>

Another key benefit of WebAssembly is its security. WebAssembly runs in a sandboxed environment within the web browser, providing a layer of isolation and protection against malicious code. It enforces strict security policies such as memory safety and type safety, preventing common security vulnerabilities such as buffer overflows, null pointer dereferences, and code injection attacks.<br><br>

WebAssembly can be used in conjunction with JavaScript to enhance the capabilities of web applications. Developers can use WebAssembly to offload performance-critical tasks to optimized native code modules, while still using JavaScript for high-level application logic, user interface interactions, and DOM manipulation. This allows developers to leverage the strengths of both languages and create more efficient and responsive web applications.<br><br>

WebAssembly has a wide range of use cases across various domains, including gaming, multimedia, virtual reality, augmented reality, CAD (Computer-Aided Design), scientific computing, and more. It is particularly well-suited for applications that require high-performance computation, low-level access to hardware, or integration with existing native code libraries.<br><br>

In summary, WebAssembly is a powerful and versatile technology that enables high-performance execution of code on the web. Whether you`''`re building a web game, multimedia application, or scientific simulation, WebAssembly provides the performance, portability, and security needed to push the boundaries of what`''`s possible on the web.', 1710673200000, 1710759600000, '/images/img38.jpg', 3),

('A Guide to Software Testing', 'Software testing is a process of evaluating and verifying that a software application or system meets the specified requirements and quality standards. It is an essential part of the software development lifecycle and helps identify defects, errors, and vulnerabilities early in the development process. Effective software testing ensures that the software meets the needs of users, functions as expected, and delivers a high-quality user experience. In this article, we will provide a comprehensive guide to software testing, covering its key concepts, types, techniques, and best practices.<br><br>

Software testing involves various activities and techniques aimed at uncovering defects and ensuring the quality and reliability of software applications. Some of the key activities in software testing include:<br><br>

1. Test planning: Developing a test plan that outlines the objectives, scope, resources, and timeline for the testing process.<br>
2. Test design: Creating test cases and test scenarios based on the requirements and specifications of the software.<br>
3. Test execution: Running the test cases and executing the tests to verify the functionality and behavior of the software.<br>
4. Defect tracking: Identifying and documenting defects or issues discovered during testing and tracking their resolution.<br>
5. Test reporting: Generating test reports that summarize the results of the testing process, including test coverage, defect metrics, and quality metrics.<br><br>

Software testing can be broadly categorized into two main types: manual testing and automated testing. Manual testing involves human testers manually executing test cases and verifying the behavior of the software. It is suitable for exploratory testing, usability testing, and ad-hoc testing scenarios where human judgment and intuition are required. Automated testing involves using automated testing tools and scripts to execute test cases and validate the functionality of the software. It is suitable for regression testing, performance testing, and repetitive testing tasks that can be automated.<br><br>

There are various techniques and approaches to software testing, including:<br><br>

1. Black-box testing: Testing the functionality of the software without knowledge of its internal implementation.<br>
2. White-box testing: Testing the internal structure, logic, and code of the software to ensure completeness and correctness.<br>
3. Unit testing: Testing individual units or components of the software in isolation to verify their behavior and functionality.<br>
4. Integration testing: Testing the interaction and integration between different modules or components of the software.<br>
5. System testing: Testing the entire system as a whole to verify that it meets the specified requirements and works as expected.<br>
6. Acceptance testing: Testing the software from the end user`''`s perspective to ensure that it meets their needs and expectations.<br><br>

Best practices for software testing include:<br><br>

1. Start testing early in the software development lifecycle to identify defects and issues as soon as possible.<br>
2. Develop clear and concise test cases that cover all aspects of the software`''`s functionality and behavior.<br>
3. Use a combination of manual and automated testing techniques to maximize test coverage and efficiency.<br>
4. Continuously monitor and update test cases to reflect changes in requirements, code, and functionality.<br>
5. Collaborate closely with developers, stakeholders, and end users to ensure that testing efforts align with business goals and user needs.<br><br>

Overall, software testing is a critical aspect of software development that ensures the quality, reliability, and performance of software applications. By following best practices and leveraging appropriate testing techniques and tools, organizations can deliver high-quality software products that meet the needs of users and stakeholders.', 1710846000000, 1710932400000, '/images/img39.jpg', 4),
('Understanding Continuous Integration', 'Continuous integration is a practice in software development where developers frequently integrate their code changes into a shared repository, often multiple times a day. Each integration is automatically verified by building the project and running automated tests to detect and fix integration errors early in the development process. Continuous integration aims to improve the quality, efficiency, and speed of software development by promoting collaboration, early feedback, and rapid iteration. In this article, we will explore the concept of continuous integration, its benefits, principles, and best practices.<br> <br>

Continuous integration (CI) is based on the principle of frequent integration of code changes into a shared codebase, combined with automated testing and verification to ensure that the software remains in a working state at all times. CI systems automatically build the project, run tests, and provide immediate feedback to developers about the status of their code changes, allowing them to detect and fix integration issues quickly and prevent regressions.<br><br>

One of the key benefits of continuous integration is improved software quality. By integrating code changes frequently and running automated tests, CI helps identify defects, errors, and inconsistencies early in the development process when they are easier and less costly to fix. This leads to fewer bugs, higher code quality, and a more stable and reliable software product.<br><br>

Continuous integration also promotes collaboration and communication among team members by providing a shared platform for integrating and testing code changes. CI systems provide visibility into the status of the codebase, allowing developers to see which changes have been integrated, which tests have passed or failed, and who made the changes. This encourages transparency, accountability, and teamwork within the development team.<br><br>

Another benefit of continuous integration is increased productivity and efficiency. By automating the build and test process, CI eliminates manual, repetitive tasks and reduces the time and effort required for integration and testing. This allows developers to focus on writing code and implementing features rather than troubleshooting integration issues or dealing with broken builds.<br><br>

Continuous integration follows several key principles and best practices, including:<br><br>

1. Maintain a single source code repository: Use a version control system like Git or SVN to store all code changes and ensure that developers are always working with the latest version of the codebase.<br>
2. Automate the build process: Use build automation tools like Jenkins, Travis CI, or CircleCI to automatically build the project and generate executable artifacts whenever code changes are pushed to the repository.<br>
3. Run automated tests: Implement a comprehensive suite of automated tests, including unit tests, integration tests, and end-to-end tests, to validate the functionality and behavior of the software.<br>
4. Fix broken builds immediately: If a build or test fails, developers should prioritize fixing the issue and restoring the build to a working state as soon as possible to prevent integration problems.<br>
5. Monitor and analyze build metrics: Track key metrics such as build success rate, test coverage, build duration, and code quality metrics to identify areas for improvement and optimize the CI process.<br><br>

Overall, continuous integration is a foundational practice in modern software development that promotes collaboration, quality, and efficiency. By integrating code changes frequently, running automated tests, and providing immediate feedback, CI helps teams deliver high-quality software faster and with fewer defects.', 1711018800000, 1711105200000, '/images/img40.jpg', 5);

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
('Reply to first comment on second article.', 1704459600000, NULL, 2, 2),
('I found this guide very helpful. Thanks!', 1704347400000, NULL, 5, 2),
('Reply to helpful guide comment.', 1704349200000, NULL, 1, 2),
('Great overview of ES6 features.', 1704390300000, NULL, 2, 3),
('Reply to ES6 overview.', 1704392100000, NULL, 3, 3),
('I had trouble with HTML5 forms, but this helped.', 1704456000000, NULL, 3, 4),
('Bootstrap is my go-to framework for responsive design.', 1704480600000, NULL, 1, 5),
('Reply to Bootstrap comment.', 1704482700000, NULL, 4, 5),
('Asynchronous JavaScript can be tricky, but this article simplifies it.', 1704555900000, NULL, 2, 6),
('Python is indeed versatile. Great read!', 1704585300000, NULL, 3, 7),
('Hooks make React so much easier to manage.', 1704711000000, NULL, 4, 8),
('Reply to React Hooks comment.', 1704712800000, NULL, 5, 8),
('Node.js is powerful for server-side development.', 1704783600000, NULL, 5, 9),
('Svelte is an interesting framework. Need to try it out.', 1704852600000, NULL, 1, 10),
('Reply to Svelte comment.', 1704854100000, NULL, 2, 10),
('Vue.js has been great for my projects.', 1704926400000, NULL, 2, 11),
('TypeScript has improved my code quality significantly.', 1705012800000, NULL, 3, 12),
('Understanding the DOM is crucial for web development.', 1705092600000, NULL, 4, 13),
('Reply to DOM understanding comment.', 1705094400000, NULL, 5, 13),
('PWAs are the future of mobile web apps.', 1705160100000, NULL, 5, 14),
('GraphQL looks promising for API development.', 1705230000000, NULL, 1, 15),
('Docker has revolutionized my deployment process.', 1705353000000, NULL, 2, 16),
('Reply to Docker comment.', 1705356000000, NULL, 3, 16),
('Microservices architecture is complex but worth it.', 1705419600000, NULL, 3, 17),
('Kubernetes is powerful but has a steep learning curve.', 1705492800000, NULL, 4, 18),
('Reply to Kubernetes comment.', 1705494900000, NULL, 5, 18),
('Express.js makes building APIs straightforward.', 1705571100000, NULL, 5, 19),
('Web security is more important than ever.', 1705643700000, NULL, 1, 20),
('Reply to web security comment.', 1705645500000, NULL, 2, 20),
('Responsive design is a must for modern websites.', 1705725900000, NULL, 2, 21),
('Machine learning is a fascinating field.', 1705800900000, NULL, 3, 22),
('Django is a robust framework for web development.', 1705884600000, NULL, 4, 23),
('Reply to Django comment.', 1705886400000, NULL, 5, 23),
('Angular offers great tooling for large projects.', 1705960500000, NULL, 5, 24),
('SQL knowledge is fundamental for any developer.', 1706031900000, NULL, 1, 25),
('DevOps practices have streamlined my workflow.', 1706106000000, NULL, 2, 26),
('Reply to DevOps comment.', 1706107800000, NULL, 3, 26),
('Flutter is excellent for cross-platform app development.', 1706182200000, NULL, 3, 27),
('Blockchain technology has many potential applications.', 1706259900000, NULL, 4, 28),
('Cybersecurity is a growing concern for businesses.', 1706332800000, NULL, 5, 29),
('Reply to Cybersecurity comment.', 1706334600000, NULL, 1, 29),
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
('Continuous integration improves development efficiency.', 1707149700000, NULL, 1, 40);



-- Insert mock data into like table
INSERT INTO like (userId, articleId) VALUES
(6, 18),
(10, 34),
(1, 31),
(18, 26),
(15, 39),
(8, 9),
(5, 19),
(11, 14),
(11, 23),
(5, 37),
(7, 1),
(1, 24),
(15, 23),
(6, 20),
(15, 32),
(2, 32),
(17, 5),
(12, 18),
(17, 23),
(9, 28),
(15, 7),
(16, 6),
(18, 3),
(7, 3),
(10, 20),
(18, 12),
(1, 26),
(13, 37),
(16, 33),
(18, 30),
(14, 8),
(9, 3),
(3, 17),
(6, 34),
(5, 23),
(4, 25),
(9, 21),
(13, 3),
(14, 35),
(4, 34),
(8, 25),
(18, 5),
(10, 31),
(18, 14),
(16, 35),
(6, 27),
(3, 19),
(4, 18),
(4, 27),
(1, 3),
(3, 37),
(14, 37),
(10, 15),
(15, 11),
(8, 27),
(1, 21),
(2, 20),
(17, 39),
(19, 36),
(16, 28),
(3, 12),
(6, 29),
(14, 21),
(10, 8),
(13, 7),
(4, 38),
(19, 20),
(6, 1),
(15, 13),
(16, 12),
(1, 23),
(19, 38),
(10, 35),
(18, 18),
(9, 37),
(12, 8),
(3, 5),
(6, 22),
(3, 14),
(9, 9),
(3, 23),
(12, 26),
(18, 39),
(4, 22),
(14, 23),
(12, 35),
(10, 1),
(14, 32),
(8, 13),
(1, 7),
(13, 9),
(15, 6),
(18, 2),
(16, 14),
(18, 11),
(10, 28),
(19, 31),
(8, 40),
(9, 39),
(12, 10),
(14, 7),
(14, 16),
(4, 15),
(13, 11),
(17, 27),
(8, 24),
(7, 4),
(6, 8),
(10, 39),
(12, 3),
(2, 35),
(13, 32),
(12, 12),
(4, 8),
(12, 30),
(8, 8),
(11, 13),
(16, 9),
(1, 20),
(11, 22),
(11, 40),
(14, 2),
(7, 18),
(13, 34),
(6, 28),
(3, 11),
(15, 40),
(6, 37),
(19, 1),
(17, 13),
(19, 10),
(5, 20),
(10, 16),
(17, 40),
(2, 30),
(18, 20),
(12, 16),
(17, 24),
(19, 21),
(10, 18),
(9, 20),
(2, 14),
(5, 40),
(2, 23),
(6, 14),
(7, 13),
(14, 6),
(1, 36),
(15, 35),
(16, 34),
(18, 40),
(10, 11),
(5, 24),
(17, 26),
(14, 36),
(11, 19),
(15, 10),
(15, 28),
(6, 25),
(4, 7),
(17, 1),
(17, 19),
(19, 16),
(2, 9),
(19, 25),
(17, 28),
(3, 38),
(15, 3),
(13, 15),
(18, 8),
(13, 24);

