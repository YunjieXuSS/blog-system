<script>
  import { articleStore, searchArticles } from "../lib/js/utils.js";
  import ArticleList from "../lib/components/ArticleList.svelte";
  import PostArticleButton from "$lib/components/PostArticleButton.svelte";
  import { queryStore } from "../lib/js/store.js";
  import { onDestroy, onMount } from "svelte";

  export let data;
  articleStore.set(data.articles);

  let count = 2;

  let loadMore;
  let loadingFlag = false;
  let lastArticleAmount = 0;

  let isVisible = false;

  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  function checkScrollPosition() {
    if (window.scrollY > 300) {
      isVisible = true;
    } else {
      isVisible = false;
    }
  }
  onMount(() => {
    window.addEventListener("scroll", checkScrollPosition);
    return () => {
      window.removeEventListener("scroll", checkScrollPosition);
    };
  });

  onMount(() => {
    loadMore = () => {
      if (loadingFlag || lastArticleAmount === $articleStore.length) return;
      loadingFlag = true;
      setTimeout(() => {
        if (window.innerHeight + window.scrollY >= document.documentElement.scrollHeight) {
          queryStore.update((current) => ({ ...current, ...{ pageSize: 12 * count } }));
          searchArticles();
          lastArticleAmount = $articleStore.length;
          count++;
        }
        loadingFlag = false;
      }, 2000);
    };
    window.addEventListener("scroll", loadMore);
  });

  onDestroy(() => {
    if (typeof window !== "undefined") {
      window.removeEventListener("scroll", loadMore);
    }
  });
</script>

<PostArticleButton  {data}/>

<div class="mainBodyDiv">
  <div class="articleDiv">
    <ArticleList articles={$articleStore} />
  </div>
  {#if loadingFlag}
    <div class="loader-container">
      <div class="loader" />
    </div>
  {/if}
</div>
<button class="back-to-top" on:click={scrollToTop} class:isVisible> ↑ </button>

<style>
  .back-to-top {
    position: fixed;
    bottom: 40px;
    right: 40px;
    width: 50px;
    height: 50px;
    background-color: #bbb;
    color: white;
    border: none;
    border-radius: 50%;
    font-size: 24px;
    cursor: pointer;
    opacity: 0;
    transition: opacity 0.3s ease-in-out;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .back-to-top:hover {
    background-color: #606060;
  }

  .back-to-top.isVisible {
    opacity: 1;
  }
  * {
    background-color: #f0f0f0;
    margin: 10px auto;
    width: 100%;
  }
  .loader-container {
    padding: 10px 0;
  }

  .loader {
    border: 16px solid #f3f3f3;
    border-top: 16px solid #606060;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    animation: spin 2s linear infinite;
    margin: 50px auto;
  }

  @keyframes spin {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
</style>
