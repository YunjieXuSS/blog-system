<script>
  import { ARTICLES_URL } from "../lib/js/apiUrls.js";
  import ArticleCard from "../../../lib/components/ArticleCard.svelte";
  /**
   * This function will let us "invalidate" any page load functions which depend on a given URL, which will cause
   * them to be reloaded.
   */
  import { invalidate } from "$app/navigation";
  export let data;
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

// display the article with the given ID (reading and editing)
<div class="articleDiv">
  <ArticleCard article={data} />
</div>

// edit button
<button on:click={editArticle}>Edit</button>

// delete button
<button on:click={deleteArticle}>Delete</button>
