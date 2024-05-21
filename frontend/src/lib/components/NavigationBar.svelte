<script>
  // import "$lib/css/app.css";
  import { page } from "$app/stores";
  $: path = $page.url.pathname;
  $: console.log($page.url.pathname);

  let userName = "userName";
</script>

<div class="titleDiv">
  <span class="websiteName"> Chars </span>
  <div class="userNameLogoutDiv">
    <span class="userName"> Hi! {userName}</span>
    <img class="userIcon" src="userDefaultIcon.png" alt="userDefaultIcon" />
    <a href="/notfound">Logout</a>
  </div>
</div>
<nav>
  <ul>
    <!-- The class:active syntax here applies the "active" CSS class if the given condition is true. -->
    <li><a href="/" class:active={path === "/"}>Homepage</a></li>
    <li><a href="/profile" class:active={path === "/profile"}>Profile</a></li>
    <!-- browsing here to see the default Svelte 404 page. -->
    <!-- <li><a href="/notfound">Not Found</a></li> -->
  </ul>
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

    & .websiteName{
        font-size: 40px;
    }

    & .userNameLogoutDiv {
      display: flex;
      align-items: center;
      gap: 20px
     
    }

    & .userIcon {
      width: 50px;
    }
  }

  nav {
    background-color: #b5c0d0;
    box-shadow: 0 5px 3px lightgray;
    align-content: center;
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
  }
</style>
