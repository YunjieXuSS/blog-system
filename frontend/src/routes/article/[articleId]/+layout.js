import { ARTICLES_URL } from "../../../lib/js/apiUrls";
// pre-load article data
export async function load({ params, fetch }) {
  console.log("i am here");
  const articleId  = params.articleId;
  async function getArticle() {
    const res = await fetch(`${ARTICLES_URL}/${articleId}`);
    if (res.status === 200) {
      const data = await res.json();
      console.log("check article",data);
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
  console.log("article", article);
  return { article };
}
