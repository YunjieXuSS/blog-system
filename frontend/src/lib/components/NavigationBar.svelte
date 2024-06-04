<script>
  import { page } from "$app/stores";
  import { searchArticles } from "../js/utils.js";
  import { queryStore } from "../js/store.js";
  import { articleInfo } from "../js/store.js";
  import { browser } from "$app/environment";
  import SearchAndSortTool from "$lib/components/SearchAndSortTool.svelte";
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import "$lib/css/button.css";

  export let data;
  let searchTimeout;
  let isSearching = false;

  let query = {};
  let selectedCategory = "title"; // menu selection
  let searchTerm = "";
  let sortByCategory = "titleAsc";
  let searchTermStart = "";
  let searchTermEnd = "";

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

  $: {
    delete $queryStore.title;
    delete $queryStore.userName;
    delete $queryStore.startDate;
    delete $queryStore.endDate;
    if (selectedCategory !== "date") {
      searchTermStart = "";
      searchTermEnd = "";
      query = selectedCategory === "title" ? { title: searchTerm } : { userName: searchTerm };
    } else {
      query = { startDate: searchTermStart, endDate: searchTermEnd };
    }
    const sortQuery = getSortQuery(sortByCategory) || {};
    query = { ...query, ...sortQuery };
    queryStore.update((current) => ({ ...current, ...query }));
    handleSearch();
  }

  $: path = $page.url.pathname;
  $: isLoggedIn = data.isLoggedIn;
  let loginUser;
  $: if (isLoggedIn) {
    loginUser = data.user;
  }

  async function handleSearch() {
    clearTimeout(searchTimeout);
    isSearching = true;
    searchTimeout = setTimeout(async () => {
      await searchArticles();
      isSearching = false;
    }, 500);
  }

  let showArticleLink = false;
  let articleId = null;
  let articlePath = "/article";
  let onArticlePage = false;

  articleInfo.subscribe((value) => {
    showArticleLink = value.id !== null;
    articleId = value.id;
    articlePath = value.path;
    onArticlePage = value.onArticlePage;
  });
  $: onArticlePage = path.startsWith(`/article/${articleId}`);
  $: articleInfo.update((value) => {
    value.onArticlePage = onArticlePage;
    return value;
  });
</script>

<nav class="navBar darkGreen">
  <ul>
    <!-- The class:active syntax here applies the "active" CSS class if the given condition is true. -->
    <li><a href="/" class:active={path === "/"}>Home</a></li>
    {#if isLoggedIn}
      <li>
        <a
          href="/profile/{data.user.userName}"
          class:active={path.startsWith(`/profile/${data.user.userName}`)}>My Blog</a
        >
      </li>
    {/if}

    {#if showArticleLink && articleId}
      <li>
        <a href="/article/{articleId}" class:active={path.startsWith(`/article/${articleId}`)}>
          {#if onArticlePage}
            Current
          {:else}
            Previous
          {/if}
        </a>
      </li>
    {/if}

    <!-- browsing here to see the default Svelte 404 page. -->
    <!-- <li><a href="/notfound">Not Found</a></li> -->
  </ul>

  {#if path === "/"}
  <div class="search-menu-container">
    <SearchAndSortTool
      bind:selectedCategory
      bind:searchTerm
      bind:sortByCategory
      bind:searchTermStart
      bind:searchTermEnd
    />
  </div>
{/if}

</nav>

<style>
.search-menu-container {
    position: sticky;
    top: 65px;
    display: flex;
    justify-content: center;
    margin: 0;
    height: 80px;
    background-color: rgb(255, 255, 255);
    z-index: 1000;
    max-width: 100%;
  }

  .navBar {
    display: flex;
    justify-content: center;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    flex-wrap: wrap;
    flex-direction: column;
    position: sticky;

    & > ul {
      list-style: none;
      margin: 0;
      display: flex;
      gap: 50px;
    }

    & li {
      padding: 10px;
    }

    & a {
      color: white;
      font-size: 1.3rem;
      font-weight: 600;
      text-decoration: none;

      &.active::before {
        content: "";
        display: block;
        height: 5px;
        background-color: #cedebd;
        bottom: 0;
        width: 100%;
      }
    }

    & a::before {
      content: "";
      display: block;
      height: 5px;
      background-color: #cedebd;

      bottom: 0;
      width: 0%;

      transition: ease 200ms;
    }

    & a:hover::before {
      width: 100%;
    }

    & .searchSection {
      margin: 0;
      display: flex;
      align-items: center;
      padding: 8px;

      & .searchIcon {
        height: 20px;
      }
    }
  }
</style>
