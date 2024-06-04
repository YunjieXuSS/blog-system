import { ARTICLES_URL } from "$lib/js/apiUrls";

export async function load({ params, fetch }) {
  const articleId  = params.articleId;
  const response = await fetch(`${ARTICLES_URL}/${articleId}/likeStatus`, { credentials: "include" });
  if (response.status === 200) {
    const body = await response.json();
    const isLiked = body.isLiked;
    return {isLiked}
  }
}
