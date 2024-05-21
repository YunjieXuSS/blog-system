<script>
  import "$lib/css/app.css";
  import  NavigationBar from "$lib/components/NavigationBar.svelte";
  import { page } from "$app/stores";
 
  $: path = $page.url.pathname;

  export let data =[];


</script>

<NavigationBar {data}/>
<div class="container">
  <slot />
</div>
