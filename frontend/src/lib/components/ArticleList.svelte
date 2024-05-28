<script>
  import ArticleCard from "./ArticleCard.svelte";
  import SortingSection from "$lib/components/SortingSection.svelte";
  import { goto } from "$app/navigation";
  import { browser } from "$app/environment";
  export let articles;
  let sortingCategory = "dateDesc";
</script>

<div class="home-articles">
  <div class="sort-bar">
    <p class="article-p">Articles by everyone</p>
    <div class="sortingSectionDiv">
      <p class="sort-p">Sort by:</p>
      <SortingSection bind:sortingCategory />
    </div>
  </div>
  {#if articles.length === 0}
    <p class="none-article">No articles found</p>
  {:else}
    <div class="article-list">
      {#each articles as article (article.articleId)}
        <a class="article" href="/article/{article.articleId}">
          <ArticleCard {article} />
        </a>
      {/each}
    </div>
  {/if}
</div>

<style>
  .home-articles {
    padding: 0 20px;
    width: 95vw;
  }

  .article-list {
    column-count: 3;
    column-gap: 30px;
  }

  .article {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);
    margin-bottom: 20px;
    display: inline-block;
    width: 100%;
    box-sizing: border-box;
  }

  .article:hover {
    box-shadow: 0 4px 8px 0 rgba(56, 0, 18, 0.2), 0 6px 20px 0 rgba(89, 6, 42, 0.19);
    text-decoration: underline;
  }

  .none-article {
    text-align: center;
    font-size: 1.5em;
    color: #555;
  }

  .sort-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 0;
  }

  .sortingSectionDiv {
    display: flex;
    align-items: center;
  }

  .sort-p {
    margin-right: 10px;
    margin-bottom: 5px;
    color: #606060;
  }

  .article-p {
    font-size: 1.5em;
    color: #555;
  }

  @media (max-width: 1200px) {
    .article-list {
      column-count: 2;
    }
  }

  @media (max-width: 600px) {
    .article-list {
      column-count: 1;
    }
    .sort-bar {
      flex-direction: column;
      align-items: flex-start;
    }
  }
</style>
