<script>
    import { createEventDispatcher } from "svelte";
  export let searchTerm;
  $:console.log(searchTerm);

</script>

<div id="search-input-cont">
  <input
    type="text"
    id="search-field"
    placeholder="Search"
    autocomplete="off"
    bind:value={searchTerm}
    on:input
  />
  <img class="searchIcon" src="search_icon.png" alt="searchIcon" />
</div>

<style>
  #search-input-cont {
    height: 30px;
    width: 100px;
    display: flex;
    align-items: center;
    margin: 0 40px 0 0;
    background-color: white;
    border: 1px solid gray;
    border-radius: 5px;
    padding: 5px;
  }

  #search-field {
    width: 100%;
    height: 80%;
    border-radius: 5px;
    border: transparent;
    font-family: 'Nunito', sans-serif;
    font-size: 1rem;
    font-weight: 400;
    color: gray;
    padding: 8px;
    margin: 0;
  }
</style>
