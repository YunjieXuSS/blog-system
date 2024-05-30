<script>
  import { page } from "$app/stores";
  import { invalidateAll } from "$app/navigation";
  import SearchMenu from "$lib/components/SearchMenu.svelte";
  import SearchBox from "./SearchBox.svelte";
  import { searchArticles } from "../js/utils.js";
  import ButtonText from "$lib/components/ButtonText.svelte";
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import { USER_URL, SERVER_URL } from "../js/apiUrls.js";
  import { goto } from "$app/navigation";
  import DateSearchBox from "./DateSearchBox.svelte";
  import { queryStore } from "../js/store.js";
  import { onMount } from "svelte";
  export let data;

  let query = {};
  let selectedCategory = "title"; // menu selection
  let searchTerm = "";
  let searchTermStart = "";
  let searchTermEnd = "";
  $: {
    if (selectedCategory !== "date") {
      searchTermStart = "";
      searchTermEnd = "";
      delete $queryStore.startDate;
      delete $queryStore.endDate;
      query = selectedCategory === "title" ? { title: searchTerm } : { userName: searchTerm };
    } else {
      query = { startDate: searchTermStart, endDate: searchTermEnd };
    }
    queryStore.update((current) => ({ ...current, ...query }));
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
        await invalidateAll();
        goto("/", { replaceState: true });
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
    await searchArticles();
  }

  let imageLoaded = true;
  function handleImageError(event) {
    imageLoaded = false;
  }

  onMount(() => {
    if (isLoggedIn === false) return;
    const img = new Image();
    img.src = SERVER_URL + loginUser.avatar;
    img.onerror = handleImageError;
  });

  import { articleInfo } from "../js/store.js";


  let showArticleLink = false;
  let articleId = null;
  let articlePath = "/article";

  articleInfo.subscribe((value) => {
    showArticleLink = value.id !== null;
    articleId = value.id;
    articlePath = value.path;
  });
</script>

<div class="titleDiv">
  <div><img class="logo" src="/images/logo.png" alt="chars" /></div>

  <!-- show different content depends on the status of user -->
  {#if isLoggedIn == false}
    <div class="userNameLogoutDiv">
      <!-- <span class="userName"> Hi!</span> -->
      <img class="userIcon" src="/userDefaultIcon.png" alt="userDefaultIcon" />

      <ButtonText
        buttonLabel="Login"
        buttonFunction={userLogin}
        bckgColour="#9EB384"
        txtColour="#435334"
        buttonWidth="80px"
        buttonHeight="42px"
      />
      
    </div>
  {/if}

  {#if isLoggedIn == true}
    <div class="userNameLogoutDiv">
      <!-- <span class="userName"> Hi {loginUser.userName}!</span> -->
      {#if imageLoaded == false}
        <img class="userIcon" src="/userDefaultIcon.png" alt="userDefaultIcon" />
      {:else}
        <img class="userIcon" src={SERVER_URL + data.user.avatar} alt="userIcon" />
      {/if}

      <ButtonImage
      buttonFunction={userLogout}
      imgSrc="/icons/logout.png"
      imgAlt="Logout"
      imgWidth="35px"
      />

    </div>
  {/if}
</div>
<nav class="navBar">
  <ul>
    <!-- The class:active syntax here applies the "active" CSS class if the given condition is true. -->
    <li><a href="/" class:active={path === "/"}>Home</a></li>
    {#if isLoggedIn}
      <li>
        <a
          href="/profile/{data.user.userName}"
          class:active={path.startsWith(`/profile/${data.user.userName}`)}>Profile</a
        >
      </li>
    {/if}

    {#if showArticleLink && articleId}
      <li>
        <a href="/article/{articleId}" class:active={path.startsWith(`/article/${articleId}`)}
          >Article</a
        >
      </li>
    {/if}
    {#if showArticleLink && articleId}
      <li>
        <a href={`${articlePath}/${articleId}`} class:active={path.startsWith("/article")}
          >Article</a
        >
      </li>
    {/if}
    <!-- browsing here to see the default Svelte 404 page. -->
    <!-- <li><a href="/notfound">Not Found</a></li> -->
  </ul>
  {#if path === "/"}
    <div class="searchSection">
      <SearchMenu bind:selectedCategory />
      {#if selectedCategory === "date"}
        <div class="date-search">
          <DateSearchBox bind:searchTerm={searchTermStart} on:input={handleSearch} />
          <div style="color: #606060">to</div>
          <DateSearchBox bind:searchTerm={searchTermEnd} on:input={handleSearch} />
        </div>
      {:else}
        <SearchBox bind:searchTerm on:input={handleSearch} />
      {/if}
    </div>
  {/if}
</nav>

<style>
  .titleDiv {
    margin: 0;
    height: 100px;
    background-color: white;
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
        border-radius: 50%; 
        border: 2px solid #9EB384; 
    }
  }

  .navBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 60px;
    background-color: #435334;
    opacity: 0.9;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

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
        background-color: #CEDEBD;
        /* background-color: #fad094; */
        bottom: 0;
        width: 100%;
      }
    }

    & a::before {
      content: "";
      display: block;
      height: 5px;
      background-color: #CEDEBD;

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

  .date-search {
    display: flex;
    align-items: center;
  }
</style>
