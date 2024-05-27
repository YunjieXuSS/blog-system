<script>
  // import "$lib/css/app.css";
  import { page } from "$app/stores";
  import { invalidateAll } from "$app/navigation";
  import SearchMenu from "$lib/components/SearchMenu.svelte";
  import SearchBox from "./SearchBox.svelte";
  import { articleStore } from "../js/utils.js";
  import { searchArticles, refreshPage } from "../js/utils.js";
  import { onMount } from "svelte";
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { user } from "../js/store";
  import { USER_URL } from "../js/apiUrls.js";
  import { goto } from "$app/navigation";

  export let data;

  $: isLoggedIn = data.isLoggedIn;
  let loginUser = {};
  $: if (isLoggedIn) {
    loginUser = data.user;
  }

  $: path = $page.url.pathname;

  async function userLogout() {
    try {
      console.log("Processing logout start");

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
    goto("/login", { replaceState: true });
    await refreshPage();
  }

  let selectedCategory = "title"; //  menu selection

  let searchTerm = "";

  async function handleSearch() {
    await searchArticles(articleStore, selectedCategory, searchTerm);
  }
</script>

<div class="titleDiv">
  <div><img class="logo" src="/images/logo.png" alt="chars" /></div>

  <!-- show different content depends on the status of user -->
  {#if !isLoggedIn}
    <div class="userNameLogoutDiv">
      <span class="userName"> Hi!</span>
      <img class="userIcon" src="/userDefaultIcon.png" alt="userDefaultIcon" />
      <ButtonText
        buttonLabel="Login"
        buttonFunction={userLogin}
        bckgColour="#F5E8DD"
        txtColour="#B5C0D0"
      />
    </div>
  {/if}

  {#if isLoggedIn}
    <div class="userNameLogoutDiv">
      <span class="userName"> Hi {loginUser.userName}!</span>
      <img class="userIcon" src="/userDefaultIcon.png" alt="userIcon" />
      <ButtonText
        buttonLabel="Logout"
        buttonFunction={userLogout}
        bckgColour="#F5E8DD"
        txtColour="#B5C0D0"
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
          href="/profile/{loginUser.userName}"
          class:active={path === "/profile/{loginUser.userName}"}>Profile</a
        >
      </li>
    {/if}
  </ul>
  {#if path === "/"}
    <div class="searchSection">
      <SearchMenu bind:selectedCategory />
      <SearchBox bind:searchTerm on:input={handleSearch} />
    </div>
  {/if}
</nav>

<style>
  .titleDiv {
    margin: 0 30px 0 25px;
    height: 100px;
    background-color: white;
    padding: 0 20px 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    & .logo {
      max-width: 140px;
      width: 100%;
    }

    & .userNameLogoutDiv {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    & .userIcon {
      width: 50px;
    }
  }

  .navBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #b5c0d0;
    box-shadow: 0 5px 3px lightgray;
    height: 60px;

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
        background-color: #f5e8dd;

        bottom: 0;
        width: 100%;
      }
    }

    & a::before {
      content: "";
      display: block;
      height: 5px;
      background-color: #f5e8dd;

      bottom: 0;
      width: 0%;

      transition: ease 200ms;
    }

    & a:hover::before {
      width: 100%;
    }

    & .searchSection {
      margin: 0;
      width: 400px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px;

      & .searchIcon {
        height: 20px;
      }
    }
  }
</style>
