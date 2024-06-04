<script>
  import ArticleCard from "./ArticleCard.svelte";
  import SortingSection from "$lib/components/SortingSection.svelte";
  import LikeCommentButtons from "$lib/components/LikeCommentButtons.svelte";
  import SearchAndSortTool from "$lib/components/SearchAndSortTool.svelte";
  import { goto } from "$app/navigation";
  import { page } from "$app/stores";
  import { articleInfo } from "$lib/js/store.js";
  import { onMount } from "svelte";
  import { afterUpdate } from "svelte";

  export let data;
  export let articles;

  let sortingCategory = "dateDesc";
  $: path = $page.url.pathname;

  function handleClick(articleId) {
    articleInfo.update((info) => {
      return { ...info, id: articleId };
    });
  }

  let numComments = 0;

  async function handleCommentButton(articleId) {
    await goto(`/article/${articleId}`);
    const comments = document.querySelector(".commentsDiv");
    comments.scrollIntoView({ behavior: "smooth" });
  }
  let columns = [];

  function distributeArticles(columnCount) {
    columns = Array.from({ length: columnCount }, () => []);
    articles.forEach((article, index) => {
      columns[index % columnCount].push(article);
    });
  }

  function getColumnCount() {
    const width = window.innerWidth;
    if (width < 790) return 1;
    if (width < 1200) return 2;
    return 3;
  }

  function handleResize() {
    distributeArticles(getColumnCount());
  }

  onMount(() => {
    handleResize();
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  });

  afterUpdate(() => {
    handleResize();
  });
</script>

<div class="home-articles">
  <div class="sort-bar">
    {#if path === "/"}
      <p class="article-p">Articles by everyone</p>
    {:else}
      <p class="article-p">
        Articles by <strong
          >@{path.substring(9).includes("/")
            ? path.substring(9, path.length - 1)
            : path.substring(9)}</strong
        >
      </p>
    {/if}
  </div>
  {#if articles.length === 0}
    <p class="none-article">No articles found</p>
  {:else}
    <div class="article-list">
      {#each columns as column}
        <div class="column">
          {#each column as article (article.articleId)}
            <div class="article">
              <a
                href="/article/{article.articleId}"
                on:click={() => handleClick(article.articleId)}
              >
                <ArticleCard {article} />
              </a>
              <LikeCommentButtons
                {data}
                articleId={article.articleId}
                isLiked={article.isLiked}
                commentButtonFunction={() => {
                  handleCommentButton(article.articleId);
                }}
              />
            </div>
          {/each}
        </div>
      {/each}
    </div>
  {/if}
</div>

<style>
  /* .search-menu-container {
    position: fixed;
    top: 0;
    width: 100%;
    background-color: #fff;
    z-index: 1000;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 10px 20px;
  } */

  .home-articles {
    padding: 0 20px;
    width: 90vw;
    margin: 0 auto;
  }

  .article-list {
    display: flex;
    gap: 10px;
    margin: 0 auto;
    justify-content: center;
  }
  .column {
    margin: 10px 10px;
    display: flex;
    flex-direction: column;
    gap: 16px;
  }

  .article {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);
    margin-bottom: 20px;
    padding-bottom: 10px;
    display: inline-block;
    width: 100%;
    min-width: 340px;
    max-width: 400px;
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
    margin: 0 auto;
  }

  .sort-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: column;
    margin: 40px auto 20px auto;
    max-width: 1260px;
    width: 100%;
  }

  .article-p {
    font-size: 1.5em;
    color: #555;
    min-width: 225px;
    margin: 0;
  }

  @media (max-width: 1200px) {
    .article-list {
      column-count: 2;
      max-width: 800px;
    }
    .sort-bar {
      max-width: 800px;
    }
  }

  @media (max-width: 790px) {
    .article-list {
      column-count: 1;
      max-width: 400px;
    }
    .sort-bar {
      max-width: 400px;
      flex-direction: column;
      margin-bottom: 30px;
    }
    .article-p {
      margin-bottom: 10px;
    }
  }
</style>
