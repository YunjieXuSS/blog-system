<script>
  import ArticleCard from "./ArticleCard.svelte";
  import { goto } from "$app/navigation";
  import { browser } from "$app/environment";
  export let articles;
  

  function navigateToArticle(articleId) {
    if (browser) {
      goto(`/article/${articleId}`);
    }
    
  }
</script>

<div class="article-list">
  {#each articles as article (article.articleId)}
    <button class="article" on:click={() => navigateToArticle(article.articleId)}>
      <ArticleCard {article} />
    </button>
  {/each}
</div>

<style>
  .article-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Automatically adjust columns */
    gap: 20px;
    padding: 20px;
    margin: 0 auto;
    max-width: 1200px;
  }

  .article {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    /* overflow: hidden; Ensure consistent appearance */
  }

  button {
    border: none;
    background-color: transparent;
    cursor: pointer;
  }

  @media (max-width: 1200px) {
    .article {
      flex: 0 1 calc(50% - 10px);
    }
  }

  @media (max-width: 900px) {
    .article {
      flex: 0 1 calc(100% - 10px);
    }
  }
</style>
