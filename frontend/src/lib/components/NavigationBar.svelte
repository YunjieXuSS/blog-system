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
  let searchTimeout;
  let isSearching = false;

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
        <img
          class="userIcon"
          src={SERVER_URL + data.user.avatar}
          alt="userIcon"
          on:load={(event) => {
            console.log("loaded");
          }}
          on:error={(event) => {
            event.target.src = "/userDefaultIcon.png";
          }}
        />
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
<nav class="navBar">
  <ul>
    <!-- The class:active syntax here applies the "active" CSS class if the given condition is true. -->
    <li><a href="/" class:active={path === "/"}>Home</a></li>
    {#if isLoggedIn}
      <li>
        <a href="/profile/{data.user.userName}" class:active={path.startsWith("/profile/")}>Blog</a>
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
    <div class="searchSection">
      {#if isSearching}
        <svg class="loader"
          version="1.1"
          id="L7"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          x="0px"
          y="0px"
          viewBox="0 0 100 100"
          enable-background="new 0 0 100 100"
          xml:space="preserve"
        >
          <path
            fill="#fff"
            d="M31.6,3.5C5.9,13.6-6.6,42.7,3.5,68.4c10.1,25.7,39.2,38.3,64.9,28.1l-3.1-7.9c-21.3,8.4-45.4-2-53.8-23.3
c-8.4-21.3,2-45.4,23.3-53.8L31.6,3.5z"
          >
            <animateTransform
              attributeName="transform"
              attributeType="XML"
              type="rotate"
              dur="2s"
              from="0 50 50"
              to="360 50 50"
              repeatCount="indefinite"
            />
          </path>
          <path
            fill="#fff"
            d="M42.3,39.6c5.7-4.3,13.9-3.1,18.1,2.7c4.3,5.7,3.1,13.9-2.7,18.1l4.1,5.5c8.8-6.5,10.6-19,4.1-27.7
c-6.5-8.8-19-10.6-27.7-4.1L42.3,39.6z"
          >
            <animateTransform
              attributeName="transform"
              attributeType="XML"
              type="rotate"
              dur="1s"
              from="0 50 50"
              to="-360 50 50"
              repeatCount="indefinite"
            />
          </path>
          <path
            fill="#fff"
            d="M82,35.7C74.1,18,53.4,10.1,35.7,18S10.1,46.6,18,64.3l7.6-3.4c-6-13.5,0-29.3,13.5-35.3s29.3,0,35.3,13.5
L82,35.7z"
          >
            <animateTransform
              attributeName="transform"
              attributeType="XML"
              type="rotate"
              dur="2s"
              from="0 50 50"
              to="360 50 50"
              repeatCount="indefinite"
            />
          </path>
        </svg>

        <!-- <div class="loader" /> -->
      {/if}
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
  .loader{
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
    }
  }

  .navBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-height: 60px;
    background-color: #435334;
    /* opacity: 0.9; */
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

  .date-search {
    display: flex;
    align-items: center;
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
    border: 4px solid #f3f3f3;
    border-radius: 50%;
    border-top: 4px solid #3498db;
    width: 20px;
    height: 20px;
    animation: spin 2s linear infinite;
    margin-left: 10px;
  }
  @keyframes spin {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
</style>
