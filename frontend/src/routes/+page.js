import { PUBLIC_API_BASE_URL } from "$env/static/public";
import { ARTICLES_URL } from "../lib/js/apiUrls.js";


export async function load({ fetch }) {
    console.log("Start Searching Articles");
    // console.log("refresh page start");
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/`);
    if (!response) return;//have to add some solution here
    const articles = await response.json();

    // await Promise.all(articles.map(async (article) => {
    //     try {
    //         const res = await fetch(`http://localhost:3000/images/${article.imgUrl}`);
    //         article.isImgExist = res.status === 200;
    //     } catch (error) {
    //         article.isImgExist = false;
    //     }
    // }));

    // anther way to do the same thing
    for (let article of articles) {
        try {
            const res = await fetch(`http://localhost:3000/images/${article.imgUrl}`);
            article.isImgExist = res.status === 200;
        } catch (error) {
            article.isImgExist = false;
        }
    }

    return { articles };
}