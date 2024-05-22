<script>
  // import "$lib/css/app.css";
  import { page } from "$app/stores";
  import SearchMenu from "$lib/components/SearchMenu.svelte";
  import SearchBox from "./SearchBox.svelte";

  $: path = $page.url.pathname;
  $: console.log($page.url.pathname);
  export let data;

  //The status of user
  // $:isLoggined = data.isLoggined;
  //testing code
  $: isLoggined = false;

  let userName = "userName";
  let selectedCategory = ""; //  menu selection

  // For Search Input
  let searchTerm = "";

  function userLogout() {
    //..
    console.log("User logout Successfully!");
  }

  function searchArticles() {
    console.log("Searching Articles");
  }
</script>

<div class="titleDiv">
  <span class="websiteName"> Chars </span>

  <!-- show different content depends on the status of user -->
  {#if isLoggined == false}
    <div class="userNameLogoutDiv">
      <span class="userName"> Hi! Please Login / Signup </span>
      <img class="userIcon" src="userDefaultIcon.png" alt="userDefaultIcon" />
      <a href="/notfound">Login</a>
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
    <li><a href="/" class:active={path === "/"}>Homepage</a></li>
    <li>
      <a href="/profile/{data.userName}" class:active={path === "/profile/{data.userName}"}
        >Profile</a
      >
    </li>
    <!-- browsing here to see the default Svelte 404 page. -->
    <!-- <li><a href="/notfound">Not Found</a></li> -->
  </ul>
  <div class="searchSection">
    <SearchMenu bind:selectedCategory />
    <SearchBox bind:searchTerm on:input={searchArticles} />
    <img class="searchIcon" src="search_icon.png" alt="searchIcon" />
  </div>
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

    & .websiteName {
      font-size: 40px;
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
    background-color: #b5c0d0;
    box-shadow: 0 5px 3px lightgray;
    height: 60px;

    & > ul {
      list-style: none;
      margin: 0;
      display: flex;
      gap: 15px;
    }

    & li {
      padding: 10px;

      &:hover {
        background-color: rgba(255, 255, 255, 0.2);
      }
    }

    & a {
      color: white;
      font-size: 1.4rem;
      font-weight: bold;
      text-decoration: none;

      &.active {
        text-decoration: underline;
      }
    }

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
