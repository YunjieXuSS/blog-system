<script>
  import { searchArticles } from "../js/utils.js";
  export let sortingCategory;
  import { queryStore } from "../js/store.js";
  let sortQuery = {};

  $: {
    sortQuery = getSortQuery(sortingCategory);
    queryStore.update((current) => ({ ...current, ...sortQuery }));
  }

  function getSortQuery(sortingCategory) {
    if (sortingCategory == "titleAsc") {
      return { sortBy: "title", sortOrder: 0 };
    } else if (sortingCategory == "titleDesc") {
      return { sortBy: "title", sortOrder: 1 };
    } else if (sortingCategory == "userNameAsc") {
      return { sortBy: "userName", sortOrder: 0 };
    } else if (sortingCategory == "userNameDesc") {
      return { sortBy: "userName", sortOrder: 1 };
    } else if (sortingCategory == "dateAsc") {
      return { sortBy: "createDate", sortOrder: 0 };
    } else if (sortingCategory == "dateDesc") {
      return { sortBy: "createDate", sortOrder: 1 };
    }
  }

</script>

<!-- svelte-ignore a11y-no-onchange -->
<section class="menu-cont">
  <select
    class="menu"
    name="menu"
    id="menu"
    bind:value={sortingCategory}
    on:change={searchArticles}
  >
    <option disabled selected value="">Sort by</option>
    <option value="dateDesc">Newest</option>
    <option value="dateAsc">Oldest</option>
    <option value="titleDesc">Title z-a</option>
    <option value="titleAsc">Title a-z</option>
    <option value="userNameDesc">Author z-a</option>
    <option value="userNameAsc">Author a-z</option>
  </select>
</section>

<style>
  .menu-cont {
    height: 30px;
    width: 100px;
    display: flex;
    margin: 5px 10px 0 0;
  }

  select {
    /* REMOVE MARGIN 0 AND UNCOMMENT `margin: 50px 0 20px 0;` AFTER ARTICLE LIST IS DONE (otherwise it doesn't show) -jade */
    margin: 0;
    /* margin: 50px 0 20px 0; */
    font-family: "Nunito", sans-serif;
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
