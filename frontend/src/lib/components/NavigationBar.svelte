<script>
  // import "$lib/css/app.css";
  import { page } from "$app/stores";
  import { invalidateAll } from "$app/navigation";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import SearchMenu from "$lib/components/SearchMenu.svelte";
  import SearchBox from "./SearchBox.svelte";
  import { articleStore } from "../js/utils.js";
  import { searchArticles, refreshPage } from "../js/utils.js";
  import { onMount } from "svelte";
  import Button from "$lib/components/Button.svelte";

  export let data;
  $: path = $page.url.pathname;
  $: console.log($page.url.pathname);
  //The status of user
  $: isLoggined = false;
  // $:isLoggined = data.isLoggined;
  //testing code

  let userName = "userName";
  let selectedCategory = ""; //  menu selection

  let searchTerm = "";
  //why I don't need this code any more when I put the searchArticles in the  handleSearch()??
  // $: if (searchTerm.trim() === "") {
  //   console.log("if searchTerm = null");
  //   refreshPage(articleStore);
  // }

  function userLogout() {
    //..
    console.log("User logout Successfully!");
  }
  // Fetch articles on component mount
  // Avoid calling `fetch` eagerly during server side rendering — put your `fetch` calls inside `onMount` or a `load` function instead，
  onMount(() => {
    refreshPage(articleStore);
  });

  async function handleSearch() {
    console.log("handleSearch");
    await searchArticles(articleStore, selectedCategory, searchTerm);
  }
</script>

<div class="titleDiv">
  <div><img class="logo" src="/images/logo.png" alt="chars" /></div>
  <!-- <span class="websiteName"> Chars </span> -->

  <!-- show different content depends on the status of user -->
  {#if isLoggined == false}
    <div class="userNameLogoutDiv">
      <span class="userName"> Hi! Please Login / Signup </span>
      <img class="userIcon" src="userDefaultIcon.png" alt="userDefaultIcon" />
      <Button buttonLabel="Login" buttonPath="/login" bckgColour="#F5E8DD" txtColour="#B5C0D0" />
      <!-- <a href="/login">Login</a> -->
    </div>
  {/if}

  {#if isLoggined == true}
    <div class="userNameLogoutDiv">
      <span class="userName"> Hi! {userName}</span>
      <img class="userIcon" src="userDefaultIcon.png" alt="userIcon" />
      <button on:click={userLogout}>Logout</button>
    </div>
  {/if}
</div>
<nav class="navBar">
  <ul>
    <!-- The class:active syntax here applies the "active" CSS class if the given condition is true. -->
    <li><a href="/" class:active={path === "/"}>home</a></li>
    <li>
      <a href="/profile/{data.userName}" class:active={path === "/profile/{data.userName}"}
        >profile</a
      >
    </li>
    <!-- browsing here to see the default Svelte 404 page. -->
    <!-- <li><a href="/notfound">Not Found</a></li> -->
  </ul>
  {#if path === "/"}
    <div class="searchSection">
      <SearchMenu bind:selectedCategory />
      <SearchBox bind:searchTerm on:input={handleSearch} />
      <img class="searchIcon" src="search_icon.png" alt="searchIcon" />
    </div>
  {/if}
</nav>

<style>
  .titleDiv {
    margin: 0;
    height: 100px;
    background-color: white;
    padding: 0 20px 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    /* & .websiteName { */
    /* font-size: 40px; */
    /* } */

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

      /* &:hover {
        background-color: rgba(255, 255, 255, 0.2);
      } */
    }

    & a {
      color: white;
      font-size: 1.3rem;
      font-weight: 600;
      text-decoration: none;

      /* &.active {
        text-decoration: underline;
      } */
    }

    /*  */
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
    /*  */

    & .searchSection {
      margin: 0;
      width: 500px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px;

      & .searchIcon {
        height: 30px;
      }
    }
  }
</style>
