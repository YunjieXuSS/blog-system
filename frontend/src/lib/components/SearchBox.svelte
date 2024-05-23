<script>
    import { createEventDispatcher } from "svelte";
  export let searchTerm;
  $:console.log(searchTerm);

</script>

<div id="search-input-cont">
  <input
    type="text"
    id="search-field"
    placeholder="Enter Search Term"
    autocomplete="off"
    bind:value={searchTerm}
    on:input
  />
  <img class="searchIcon" src="search_icon.png" alt="searchIcon" />
</div>

<style>
  #search-input-cont {
    height: 30px;
    width: 53%;
    display: flex;
    align-items: center;
    margin: 0 0 0 0;
    background-color: white;
    border: 1px solid gray;
    border-radius: 5px;
    padding: 5px;
  }

  #search-field {
    width: 100%;
    height: 80%;
    font-size: 1.3rem;
    border:transparent;
  }
</style>
