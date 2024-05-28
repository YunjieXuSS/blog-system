<script>
  // ---/routes/+layout.svelte
// This file is our homepage layout. It wraps around the homepage and provides a navbar, a post button, etc.
  import "$lib/css/app.css";
  import  NavigationBar from "$lib/components/NavigationBar.svelte";
  import { page } from "$app/stores";
 
  $: path = $page.url.pathname;

  export let data ;


</script>
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
  /* .navBar {
    position: fixed;
    width: 100%;
    z-index: 1000;
  } */
</style>
