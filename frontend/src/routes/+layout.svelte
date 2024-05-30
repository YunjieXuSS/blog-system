<script>
  // ---/routes/+layout.svelte
// This file is our homepage layout. It wraps around the homepage and provides a navbar, a post button, etc.
  import "$lib/css/app.css";
  import  NavigationBar from "$lib/components/NavigationBar.svelte";
  import { page } from "$app/stores";
 
  $: path = $page.url.pathname;

  export let data ;

  let backgroundColor = '#f0fff0'; 
</script>

<div class="background" style="--background-color: {backgroundColor}">
  <div class="shape"></div>
  <div class="shape"></div>
  <div class="shape"></div>
  <div class="shape"></div>
  <div class="shape"></div>
</div>

<div class="background" style="--background-color: {backgroundColor}">
  <div class="shape"></div>
  <div class="shape"></div>
  <div class="shape"></div>
  <div class="shape"></div>
  <div class="shape"></div>
</div>
<div class="navBar">
<NavigationBar {data}/>
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
  .navBar {
    position: sticky;
    width: 100%;
    z-index: 1005;
    top: 0;
  }
</style>
