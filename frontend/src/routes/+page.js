// ---/routes/+page.js
// It requests the articles from the backend and returns them to the frontend.
// API: Get /api/articles
import { ARTICLES_URL } from "../lib/js/apiUrls.js";

export async function load({ fetch }) {
    console.log("Start Searching Articles");
    try {
      const response = await fetch(ARTICLES_URL);
      if (!response.ok) {
        throw new Error(`Failed to fetch articles: ${response.statusText}`);
      }
  
      const articles = await response.json();
      console.log(articles)
      await Promise.all(
        articles.map(async (article) => {
          try {
            const res = await fetch(`http://localhost:3000/images/${article.imgUrl}`);
            article.isImgExist = res.ok;
          } catch (error) {
            console.error(`Error checking image for article ${article.id}:`, error);
            article.isImgExist = false;
          }
        })
      );
  
      return { articles };
    } catch (error) {
      console.error("Error loading articles:", error);
      return { articles: [] }; // Return an empty array to avoid breaking the app
    }
  }
  