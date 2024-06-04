<script>
  // ---/routes/+layout.svelte
  // This file is our homepage layout. It wraps around the homepage and provides a navbar, a post button, etc.
  import "$lib/css/app.css";
  import NavigationBar from "$lib/components/NavigationBar.svelte";
  import { page } from "$app/stores";

  import { goto } from "$app/navigation";
  import { invalidate } from "$app/navigation";
  import { USER_URL, SERVER_URL, ARTICLES_URL } from "$lib/js/apiUrls.js";
  import { browser } from "$app/environment";
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  $: path = $page.url.pathname;

  export let data;

  let backgroundColor = "#f0fff0";

  //test
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
</script>
<svelte:head>
  <title>Chars</title>
</svelte:head>

<div class="background" style="--background-color: {backgroundColor}">
  <div class="shape" />
  <div class="shape" />
  <div class="shape" />
  <div class="shape" />
  <div class="shape" />
</div>

<div class="background" style="--background-color: {backgroundColor}">
  <div class="shape" />
  <div class="shape" />
  <div class="shape" />
  <div class="shape" />
  <div class="shape" />
</div>

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
<div class="navBar">
  <NavigationBar {data} />
</div>
<div class="container">
  <slot />
</div>

<style>
  .container {
    margin: 0 auto;
  }

  .background {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    z-index: -1;
    overflow: hidden;
    display: flex;
    flex-wrap: wrap;
  }

  .shape {
    width: 50px;
    height: 50px;
    background-color: rgba(255, 192, 203, 0.6);
    border-radius: 50%;
    position: absolute;
    animation: float 10s ease-in-out infinite;
  }

  .shape:nth-child(2) {
    background-color: rgba(230, 230, 250, 0.6);
    animation-duration: 12s;
    width: 60px;
    height: 60px;
  }

  .shape:nth-child(3) {
    background-color: rgba(173, 216, 230, 0.6);
    animation-duration: 8s;
    width: 40px;
    height: 40px;
  }

  .shape:nth-child(4) {
    background-color: rgba(255, 228, 225, 0.6);
    animation-duration: 14s;
    width: 70px;
    height: 70px;
  }

  .shape:nth-child(5) {
    background-color: rgba(216, 191, 216, 0.6);
    animation-duration: 16s;
    width: 30px;
    height: 30px;
  }

  @keyframes float {
    0% {
      transform: translateY(0) translateX(0) rotate(0deg);
    }
    50% {
      transform: translateY(-20px) translateX(20px) rotate(45deg);
    }
    100% {
      transform: translateY(0) translateX(0) rotate(0deg);
    }
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
    width: 100%;
    z-index: 1005;
    top: 0;
  }
</style>
