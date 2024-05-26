import { ARTICLES_URL } from "../../../lib/js/apiUrls";

// pre-load article data
export async function load({ params }) {
  const articleId  = params.articleId;
  console.log("fetching....");
  async function getArticle() {
    const res = await fetch(`${ARTICLES_URL}/${articleId}`);
    if (res.status === 200) {
      const data = await res.json();

      return data;
    } else {
      throw Error("Failed to fetch article");
    }
  }

  let article = {};
  try {
    article = await getArticle();
    
  } catch (error) {

    console.error(error);
  }
  return { article };
}
