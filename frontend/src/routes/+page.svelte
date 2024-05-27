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

  onMount(() => {
    loadMore = () => {
      if (window.innerHeight + window.scrollY >= document.documentElement.scrollHeight) {
        queryStore.update((current) => ({ ...current, ...{ pageSize: 12 * count } }));
        searchArticles();
        count++;
      }
    };
    window.addEventListener("scroll", loadMore);

    onDestroy(() => {
      if (typeof window !== 'undefined') {
      window.removeEventListener('scroll', loadMore);
    }
    });
  });
</script>

<PostArticleButton />

<div class="mainBodyDiv">
  <div class="articleDiv">
    <ArticleList articles={$articleStore} />
  </div>
</div>

<style>
  * {
    background-color: #f0f0f0;
    margin: 10px auto;
    width: 100%;
  }
</style>
