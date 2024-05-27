<script>
  // ---/routes/+layout.svelte
// This file is our homepage layout. It wraps around the homepage and provides a navbar, a post button, etc.
  import "$lib/css/app.css";
  import  NavigationBar from "$lib/components/NavigationBar.svelte";
  import { page } from "$app/stores";
 
  $: path = $page.url.pathname;

  export let data ;


</script>

<NavigationBar {data}/>
<div class="container">
  <slot />
</div>
