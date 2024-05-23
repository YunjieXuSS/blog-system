<script>
  import { getPasswordHashSalt } from "../lib/js/utils";
  //testcode
  import { articleStore } from "../lib/js/test.js";
  import ArticleCard from "../lib/components/ArticleCard.svelte";
  import SortingSection from "../lib/components/SortingSection.svelte";
  import PostArticleButton from "$lib/components/PostArticleButton.svelte";


  //testing code for hash
  /*   let result = {};
  let salt, hash;
  async function clickBTN() {
    const response = await getPasswordHashSalt("password");
    result = await response.json();
    console.log(response);
    console.log(result);
    salt = result.password_salt;
    hash = result.password_hash;
    console.log(hash);
  } */

  // $: console.log($articleStore);

  let sortingCategory = ""; 
  // $: console.log(sortingCategory);
  // $: console.log("+page",$articleStore);

</script>

  <PostArticleButton />

<div class="mainBodyDiv">
  <div class="sortingSectionDiv"><SortingSection bind:sortingCategory /></div>
  <div class="articleDiv">
    {#each $articleStore as article}
      <ArticleCard {article} />
    {/each}
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
