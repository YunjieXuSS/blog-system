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
  $: console.log("+sorting", $articleStore);
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
    <option disabled selected value="">Sorting</option>
    <option value="titleA-Z">Article Title A-Z</option>
    <option value="titleZ-A">Article Title Z-A</option>
    <option value="usernameA-Z">User Name A-Z</option>
    <option value="usernameZ-A">User Name Z-A</option>
    <option value="dateA-Z">Date A-Z </option>
    <option value="dateZ-A">Date Z-A </option>
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
    margin: 0;
    font-size: 1.18rem;
    border: 1px solid gray;
    border-radius: 5px;
  }

  .menu {
    width: 100%;
  }
</style>
