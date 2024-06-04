<script>
  import { articleStore, searchArticles } from "$lib/js/utils.js";
  import { queryStore } from "$lib/js/store.js";
  import { onMount } from "svelte";
  import { get } from "svelte/store";
  import ArticleList from "$lib/components/ArticleList.svelte";
  import PostArticleButton from "$lib/components/PostArticleButton.svelte";

  export let data;

  $: articleStore.set(data.articles);

  let count = 2;
  let loadMore;
  let loadingFlag = false;
  let lastArticleAmount = data.articles.length;

  let isVisible = false;
  let hintShown = false;
  let queryIsChanging = false;

  $: {
    if (!$queryStore.pageSize && $articleStore.length >= 12) {
      hintShown = false;
      queryIsChanging = true;
      count = 2;
      setTimeout(() => {
        queryIsChanging = false;
      }, 50);
    }
  }

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
    window.addEventListener("scroll", loadMore);
    return () => {
      window.removeEventListener("scroll", checkScrollPosition);
      window.removeEventListener("scroll", loadMore);
    };
  });

  loadMore = () => {
    if (loadingFlag || hintShown || queryIsChanging) {
      return;
    }

    if (window.innerHeight + window.scrollY >= document.documentElement.scrollHeight - 10) {
      loadingFlag = true;
      setTimeout(async () => {
        const previousLength = get(articleStore).length;

        queryStore.update((current) => ({ ...current, pageSize: 12 * count }));
        await searchArticles();

        const newLength = get(articleStore).length;
        if (newLength === previousLength) {
          hintShown = true;
        } else {
          lastArticleAmount = newLength;
          count++;
        }

        loadingFlag = false;
      }, 1000);
    }
  };
</script>

<PostArticleButton {data} />

<div class="mainBodyDiv">
  <div class="articleDiv">
    <ArticleList {data} articles={$articleStore} />
  </div>
  {#if loadingFlag}
    <div class="loader-container">
      <div class="loader" />
    </div>
  {/if}
  {#if hintShown}
    <div class="hint-container">
      <p>----That's all----</p>
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
    min-width: 50px;
    background-color: #ccd3ca;
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
    background-color: #aab3a4;
  }

  .back-to-top.isVisible {
    opacity: 1;
  }
  * {
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

  .hint-container {
    text-align: center;
    color: #aab3a4;
    font-size: 1.3em;
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
