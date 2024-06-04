import { ARTICLES_URL, SERVER_URL } from "$lib/js/apiUrls.js";

export async function load({ fetch }) {
  try {
    const response = await fetch(ARTICLES_URL, { credentials: "include" });
    if (!response.ok) {
      throw new Error(`Failed to fetch articles: ${response.statusText}`);
    }
    const articles = await response.json();
    return { articles };
  } catch (error) {
    console.error("Error loading articles:", error);
    return { articles: [] };
  }
}
