<script>
  import "$lib/css/app.css";
  import NavigationBar from "$lib/components/NavigationBar.svelte";
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import { page } from "$app/stores";
  import { goto } from "$app/navigation";
  import { invalidate } from "$app/navigation";
  import { USER_URL, SERVER_URL, ARTICLES_URL } from "$lib/js/apiUrls.js";
  import { browser } from "$app/environment";

  export let data;

  $: path = $page.url.pathname;
  $: isLoggedIn = data.isLoggedIn;

  let loginUser;
  $: if (isLoggedIn) {
    loginUser = data.user;
  }

  async function userLogin() {
    goto("/login", { replaceState: true, invalidateAll: true });
  }

  async function userLogout() {
    try {
      const response = await fetch(`${USER_URL}/logout`, {
        method: "POST",
        credentials: "include"
      });
      if (response.status === 204) {
        await invalidate(ARTICLES_URL);
        await goto("/", { replaceState: true, invalidateAll: true });
      } else {
        console.error("Logout failed with status:", response.status);
      }
    } catch (error) {
      console.error("Error logging out:", error);
    }
  }
</script>

<svelte:head>
  <title>Chars</title>
</svelte:head>

<div class="titleDiv">
  <div class="logos-container">
    <img class="logo-sushi" src="/images/sushi-logo.png" alt="mascot" />
    <img class="logo" src="/images/logo.png" alt="chars" />
  </div>

  {#if isLoggedIn == false}
    <div class="userNameLogoutDiv">
      <button class="login-button" on:click={userLogin}
        ><img class="login" src="/icons/login.png" alt="userDefaultIcon" />
      </button>
    </div>
  {/if}

  {#if isLoggedIn == true}
    <div class="userNameLogoutDiv">
      <a href="/profile/edit">
        {#if browser}
          <img
            class="userIcon"
            src={SERVER_URL + data.user.avatar}
            alt="userIcon"
            on:load={(event) => {}}
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

<div class="navBar">
  <NavigationBar {data} />
</div>

<div class="container">
  <slot />
</div>

<style>
  .container {
    margin: 0;
    justify-content: center;
  }

  .titleDiv {
    margin: 0;
    height: 80px;
    background-color: white;
    opacity: 0.9;
    padding: 0 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .logos-container {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 10px;
  }

  .logo {
    max-width: 140px;
    min-width: 80px;
    width: 100%;
  }

  .logo-sushi {
    max-width: 40px;
    min-width: 10px;
    width: 100%;
  }

  .userNameLogoutDiv {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .userIcon {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    border: 2px solid #9eb384;
    display: block;
    object-fit: cover;
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

  .navBar {
    position: sticky;
    top: 0;
    width: 100%;
    z-index: 1005;
  }
</style>
