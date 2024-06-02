// ---/routes/+page.js
// It requests the articles from the backend and returns them to the frontend.
// API: Get /api/articles
import { ARTICLES_URL, SERVER_URL } from "../lib/js/apiUrls.js";

export async function load({ fetch }) {
  try {
    const response = await fetch(ARTICLES_URL, {credentials: "include"});
    if (!response.ok) {
      throw new Error(`Failed to fetch articles: ${response.statusText}`);
    }

    const articles = await response.json();
    // for (let i = 0; i < articles.length; i++) {
    //   const response = await fetch(`${ARTICLES_URL}/${articles[i].articleId}/likeStatus`, {
    //     credentials: "include"
    //   });
    //   if (response.status === 200) {
    //     const body = await response.json();
    //     const isLiked = body.isLiked;
    //     articles[i].isLiked = isLiked;
    //   }
      return { articles };
    // }
  } catch (error) {
    console.error("Error loading articles:", error);
    return { articles: [] }; // Return an empty array to avoid breaking the app
  }
}
