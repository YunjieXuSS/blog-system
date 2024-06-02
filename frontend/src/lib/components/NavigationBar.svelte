<script>
  import { USER_URL, SERVER_URL, ARTICLES_URL } from "../js/apiUrls.js";
  import { page } from "$app/stores";
  import { invalidate } from "$app/navigation";
  import { searchArticles } from "../js/utils.js";
  import { goto } from "$app/navigation";
  import { queryStore } from "../js/store.js";
  import { browser } from "$app/environment";
  import SearchAndSortTool from "./SearchAndSortTool.svelte";
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
    // console.log(query);
    queryStore.update((current) => ({ ...current, ...query }));
    handleSearch();
  }

  $: path = $page.url.pathname;
  $: isLoggedIn = data.isLoggedIn;
  let loginUser;
  $: if (isLoggedIn) {
    loginUser = data.user;
  }

  async function userLogout() {
    try {
      // Make the logout request to the server
      const response = await fetch(`${USER_URL}/logout`, {
        method: "POST",
        credentials: "include"
      });

      // Check if the logout was successful
      if (response.status === 204) {
        await invalidate(ARTICLES_URL);
        await goto("/", { replaceState: true, invalidateAll: true });
        // window.location.reload();
      } else {
        console.error("Logout failed with status:", response.status);
      }
    } catch (error) {
      console.error("Error logging out:", error);
    }
  }

  async function userLogin() {
    goto("/login", { replaceState: true, invalidateAll: true });
  }
  async function handleSearch() {
    clearTimeout(searchTimeout);
    isSearching = true;
    searchTimeout = setTimeout(async () => {
      await searchArticles();
      isSearching = false;
    }, 500);
  }

  import { articleInfo } from "../js/store.js";

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

<div class="titleDiv">
  <div><img class="logo" src="/images/logo.png" alt="chars" /></div>

  <!-- show different content depends on the status of user -->
  {#if isLoggedIn == false}
    <div class="userNameLogoutDiv">
      <button class="login-button" on:click={userLogin}
        ><img class="login" src="/icons/login.png" alt="userDefaultIcon" /></button
      >
    </div>
  {/if}

  {#if isLoggedIn == true}
    <div class="userNameLogoutDiv">
      <!-- <span class="userName"> Hi {loginUser.userName}!</span> -->
      <a href="/profile/edit">
        {#if browser}
          <img
            class="userIcon"
            src={SERVER_URL + data.user.avatar}
            alt="userIcon"
            on:load={(event) => {
              // console.log("loaded");
            }}
            on:error={(event) => {
              event.target.src = "/userDefaultIcon.png";
            }}
          />
        {/if}
      </a>

      <ButtonImage
        buttonFunction={userLogout}
        imgSrc="/icons/logout.png"
        imgAlt="Logout"
        imgWidth="35px"
        buttonWidth="40px"
      />
    </div>
  {/if}
</div>
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
    <SearchAndSortTool
      bind:selectedCategory
      bind:searchTerm
      bind:sortByCategory
      bind:searchTermStart
      bind:searchTermEnd
    />
  {/if}
</nav>

<style>
  .loader {
    width: 40px;
    height: 40px;
  }

  .titleDiv {
    margin: 0;
    height: 100px;
    background-color: white;
    opacity: 0.9;
    padding: 0 50px 0 45px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    & .logo {
      max-width: 140px;
      min-width: 80px;
      width: 100%;
    }

    & .userNameLogoutDiv {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    & .userIcon {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      border: 2px solid #9eb384;
      display: block;
      object-fit: cover;
    }
  }

  .navBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-height: 60px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    flex-wrap: wrap;

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
        /* background-color: #fad094; */
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

  .login {
    width: 50px;
  }

  .login-button {
    background: transparent;
    border: none;
    outline: none;
    cursor: pointer;
  }

  .loader {
    width: 45x;
    height: 45px;
  }
  
</style>
