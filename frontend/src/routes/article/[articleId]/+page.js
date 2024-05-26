// pre-load article data
import { ARTICLES_URL } from "../lib/js/apiUrls.js";

export async function load({ fetch, params }) {
  const { articleId } = params;
  const response = await fetch(`${ARTICLES_URL}/${articleId}`);
  const article = await response.json();
  if (res.ok) {
    return { props: { article } };
  } else {
    return {
      status: res.status,
      error: new Error(`Could not load article ${articleId}`)
    };
  }
}