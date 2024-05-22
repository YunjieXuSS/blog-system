<script>
  import { getPasswordHashSalt } from "../lib/js/utils";
  //testcode
  import { articleStore } from "../lib/js/test.js";
  import FakeArticleCard from "../lib/components/FakeArticleCard.svelte";
  import ArticleCard from "../lib/components/ArticleCard.svelte";


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
</script>

<div class="articleDiv">
  {#each $articleStore as article}
    <ArticleCard {article} />
  {/each}
</div>

//testing code for hash

<!-- <span>{result}</span>
<span>{salt}</span>
<button on:click={clickBTN}>test</button> -->

<style>
  .articleDiv {
    display: flex;
    flex-wrap: wrap;
  }
</style>
