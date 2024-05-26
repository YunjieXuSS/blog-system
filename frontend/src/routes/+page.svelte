<script>
  // import { articles, getPasswordHashSalt } from "../lib/js/utils";
  import { articleStore } from "../lib/js/utils.js";
  import ArticleList from "../lib/components/ArticleList.svelte";
  import SortingSection from "../lib/components/SortingSection.svelte";
  import PostArticleButton from "$lib/components/PostArticleButton.svelte";

  export let data;
  articleStore.set(data.articles);

  let sortingCategory = "";
</script>

<PostArticleButton />

<div class="mainBodyDiv">
  <div class="sortingSectionDiv"><SortingSection bind:sortingCategory /></div>
  <p>Articles by everyone</p>
  <div class="articleDiv">
    <ArticleList articles={$articleStore} />
  </div>
</div>
//testing code for hash

<!-- <span>{result}</span>
<span>{salt}</span>
<button on:click={clickBTN}>test</button> -->

<style>
  /* .articleDiv {
    display: flex;
    flex-wrap: wrap;
  } */
</style>
