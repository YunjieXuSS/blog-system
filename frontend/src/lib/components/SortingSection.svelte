<script>
  import { articleStore } from "../js/utils.js";
  export let sortingCategory;

  const articles = $articleStore;

  function sortingArticles(sortingCategory) {
    console.log(sortingCategory);
    let newOrderArticles = "";
    if (sortingCategory == "titleA-Z") {
      newOrderArticles = articles.sort(function (a, b) {
        return a.title > b.title ? 1 : -1;
      });
    } else if (sortingCategory == "titleZ-A") {
      newOrderArticles = articles.sort(function (a, b) {
        return b.title > a.title ? 1 : -1;
      });
    }else if (sortingCategory == "dateA-Z") {
      newOrderArticles = articles.sort(function (a, b) {
        return a.createDate > b.createDate ? 1 : -1;
      });
    }else if (sortingCategory == "dateZ-A") {
      newOrderArticles = articles.sort(function (a, b) {
        return b.createDate > a.createDate ? 1 : -1;
      });
    }

    articleStore.set(newOrderArticles);
  }

  // $: console.log(sortingCategory);
  // $: console.log("+sorting", $articleStore);
</script>

<!-- svelte-ignore a11y-no-onchange -->
<section class="menu-cont">
  <select
    class="menu"
    name="menu"
    id="menu"
    bind:value={sortingCategory}
    on:change={sortingArticles(sortingCategory)}
  >
    <option disabled selected value="">Sort by</option>
    <option value="titleA-Z">Title a-z</option>
    <option value="titleZ-A">Title z-a</option>
    <option value="usernameA-Z">Author a-z</option>
    <option value="usernameZ-A">Author z-a</option>
    <option value="dateA-Z">Newest</option>
    <option value="dateZ-A">Oldest</option>
  </select>
</section>

<style>
  .menu-cont {
    height: 40px;
    width: 200px;
    display: flex;
    margin: 0 10px 0 0;
  }

  select {
    /* REMOVE MARGIN 0 AND UNCOMMENT `margin: 50px 0 20px 0;` AFTER ARTICLE LIST IS DONE (otherwise it doesn't show) -jade */
    margin: 0; 
    /* margin: 50px 0 20px 0; */
    font-family: 'Nunito', sans-serif;
    font-size: 1rem;
    font-weight: 400;
    color: gray;
    border: 1px solid gray;
    border-radius: 5px;
  }

  .menu {
    width: 100%;
  }
</style>
