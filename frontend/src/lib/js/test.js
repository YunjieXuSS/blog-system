import { writable } from "svelte/store";
export const articles =
    [
        {
            articleId: 1,
            title: 'Understanding Flexbox: Everything you need to know',
            content: 'Flexbox is a powerful layout module...',
            createDate: '2024-01-01',
            updateDate: '2024-01-02',
            imgUrl: 'img1.jpg',
            userId: 1
        },
        {
            articleId: 2,
            title: 'CSS Grid Layout: A Step-by-Step Guide',
            content: 'CSS Grid Layout is a two-dimensional...',
            createDate: '2024-01-03',
            updateDate: '2024-01-04',
            imgUrl: 'img2.jpg',
            userId: 2
        },
        {
            articleId: 3,
            title: 'JavaScript ES6 Features: An Overview',
            content: 'ES6 brought many new features to JavaScript...',
            createDate: '2024-01-05',
            updateDate: '2024-01-06',
            imgUrl: 'img3.jpg',
            userId: 3
        },
        {
            articleId: 4,
            title: 'A Comprehensive Guide to HTML5',
            content: 'HTML5 is the latest evolution of the standard...',
            createDate: '2024-01-07',
            updateDate: '2024-01-08',
            imgUrl: 'img4.jpg',
            userId: 4
        },
        {
            articleId: 5,
            title: 'Building Responsive Websites with Bootstrap',
            content: 'Bootstrap is a popular framework for building...',
            createDate: '2024-01-09',
            updateDate: '2024-01-10',
            imgUrl: 'img5.jpg',
            userId: 5
        },
        {
            articleId: 6,
            title: 'Understanding Asynchronous JavaScript',
            content: 'Asynchronous JavaScript allows you to...',
            createDate: '2024-01-11',
            updateDate: '2024-01-12',
            imgUrl: 'img6.jpg',
            userId: 1
        },
        {
            articleId: 7,
            title: 'Mastering Python for Data Science',
            content: 'Python is a versatile language used in...',
            createDate: '2024-01-13',
            updateDate: '2024-01-14',
            imgUrl: 'img7.jpg',
            userId: 2
        },
        {
            articleId: 8,
            title: 'A Guide to React Hooks',
            content: 'React Hooks provide a way to use state...',
            createDate: '2024-01-15',
            updateDate: '2024-01-16',
            imgUrl: 'img8.jpg',
            userId: 3
        },
        {
            articleId: 9,
            title: 'Introduction to Node.js',
            content: 'Node.js is a JavaScript runtime built on...',
            createDate: '2024-01-17',
            updateDate: '2024-01-18',
            imgUrl: 'img9.jpg',
            userId: 4
        },
        {
            articleId: 10,
            title: 'Getting Started with Svelte',
            content: 'Svelte is a modern JavaScript framework...',
            createDate: '2024-01-19',
            updateDate: '2024-01-20',
            imgUrl: 'img10.jpg',
            userId: 5
        },
    ];

export const articleStore = writable(articles);