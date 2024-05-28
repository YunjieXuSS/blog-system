<script>
  // import "$lib/css/app.css";
  import { page } from "$app/stores";
  import { invalidateAll } from "$app/navigation";
  import SearchMenu from "$lib/components/SearchMenu.svelte";
  import SearchBox from "./SearchBox.svelte";
  import { searchArticles } from "../js/utils.js";
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { USER_URL } from "../js/apiUrls.js";
  import { goto } from "$app/navigation";
  import DateSearchBox from "./DateSearchBox.svelte";
  import { queryStore } from "../js/store.js";

  export let data;

  let query = {};
  let selectedCategory = "title"; //  menu selection
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
    console.log("i want to see my query now:", $queryStore);
  }

  $: path = $page.url.pathname;
  $: isLoggedIn = data.isLoggedIn;
  let loginUser;
  $: if(isLoggedIn){
    loginUser = data.user;
  }

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
    goto("/login", { replaceState: true , invalidateAll:true});
  }

  async function handleSearch() {
    await searchArticles();
  }
</script>

<div class="titleDiv">
  <div><img class="logo" src="/images/logo.png" alt="chars" /></div>

  <!-- show different content depends on the status of user -->
  {#if isLoggedIn == false}
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

  {#if isLoggedIn == true}
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
          href="/profile/{data.user.userName}"
          class:active={path === `/profile/${data.user.userName}/`}>Profile</a
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
    margin: 0 30px 0 25px;
    height: 100px;
    background-color: white;
    padding: 0 20px 0 20px;
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
    }
  }

  .navBar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 60px;
    background-color: #b5c0d0;

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
