<script>
  import SearchBox from "$lib/components/SearchBox.svelte";
  import SearchMenu from "$lib/components/SearchMenu.svelte";
</script>

<div class="search-bar-container">
  <SearchMenu />
  <SearchBox />
</div>

<style>
  .search-bar-container {
    display: flex;
    flex-direction: row;
    align-items: center;
  }
</style>
