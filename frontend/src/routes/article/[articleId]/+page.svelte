<script>
  import Comments from "./../../../lib/components/Comments.svelte";
  import ArticleCard from "../../../lib/components/ArticleCard.svelte";
  export let data;
  const { article } = data;
  const { userId } = article;
    /**
   * This function will let us "invalidate" any page load functions which depend on a given URL, which will cause
   * them to be reloaded.
   */
  import { invalidate } from "$app/navigation";
  console.log("111", data);
  async function editArticle(e) {
    e.preventDefault();
    console.log("editArticle");
    const newArticle = e.detail;
    const response = await fetch(`${ARTICLES_URL}/${data.articleId}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(newArticle)
    });
    if (response.ok) {
      const newArticle = await response.json();
      console.log("updatedArticle", newArticle);
    }
    if (response.status != 200) {
      alert(`Unexpected status code received: ${response.status}`);
    }
  }

  async function deleteArticle(e) {
    console.log("deleteArticle");
    const article = e.detail;
    const response = await fetch(`${ARTICLES_URL}/${article.articleId}`, {
      method: "DELETE"
    });

    console.log(`${ARTICLES_URL}/${article.id}`);
    console.log(response.status);
    if (response.status === 204) {
      // Invalidating this URL will cause our +page.js load() function to rerun, because that load() function
      // depends on this URL.
      invalidate(ARTICLES_URL);
    } else {
      alert(`Unexpected status code received: ${response.status}`);
    }
  }
</script>

<main>
  <section class="article">// implement article component here</section>
  <Comments authorId={userId} />
</main>

<style>
  main {
    padding: 16px;
    width: 900px;
    margin: 0 auto;
  }

  .article {
    min-height: calc(100vh - 700px);
  }
</style>





  


// display the article with the given ID (reading and editing)
<div class="articleDiv">
  <ArticleCard article={data} />
</div>

// edit button
<button on:click={editArticle}>Edit</button>

// delete button
<button on:click={deleteArticle}>Delete</button>
