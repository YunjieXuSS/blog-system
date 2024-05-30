<script>
  import ArticleCard from "./ArticleCard.svelte";
  import SortingSection from "$lib/components/SortingSection.svelte";
  import LikeCommentButtons from "$lib/components/LikeCommentButtons.svelte";
  export let data;
  export let articles;
  let sortingCategory = "dateDesc";
  import {page} from "$app/stores";
  $: path = $page.url.pathname;
  import {articleInfo} from "$lib/js/store.js";
  function handleClick(articleId) {
    articleInfo.update(info => {
      return { ...info, id: articleId };
    });
  }
</script>

<div class="home-articles">
  <div class="sort-bar">
{#if path ==="/"}
    <p class="article-p">Articles by everyone</p>
    <div class="sortingSectionDiv"><p class="sort-p">Sort by:</p><SortingSection bind:sortingCategory /></div>
{:else} 
    <p class="article-p">Articles <strong>@{path.substring(9).includes("/")?path.substring(9):path.substring(9)}</strong></p>
{/if}
  </div>
  {#if articles.length === 0}
    <p class="none-article">No articles found</p>
  {:else}
    <div class="article-list">
      {#each articles as article (article.articleId)}
      <div class="article">
        <a  href="/article/{article.articleId}" on:click={() => handleClick(article.articleId)}>
          <ArticleCard {data} {article} />
        </a>
        
        <LikeCommentButtons {data} articleId={article.articleId} isLiked={article.isLiked} />
      </div>
        
      {/each}
    </div>
  {/if}
</div>

<style>
  .home-articles {
    padding: 0 20px;
    width:90vw;
  }

  .article-list {
    /* margin: 0 auto; */
    column-count: 3;
    column-gap: 30px;
    /* max-width: 1260px; */
    /* border: solid black 1px; */
  }

  .article {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);
    margin-bottom: 20px;
    padding-bottom: 10px;
    display: inline-block;
    width: 100%;
    /* min-width: 340px;
    max-width: 400px; */
    box-sizing: border-box;
    overflow: hidden;
  }

  .article:hover {
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.46);
    transform: translateY(-5px);
    transition: 0.3s;
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
    margin: 0 auto;
    max-width: 1260px;
  }

  .sortingSectionDiv {
    display: flex;
    align-items: center;
  }

  .sort-p {
    margin: auto 10px;
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

  @media (max-width: 750px) {
    .article-list {
      column-count: 1;
    }
  }
</style>
