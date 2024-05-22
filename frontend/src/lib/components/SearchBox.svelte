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
</div>

<style>
  #search-input-cont {
    height: 40px;
    width: 55%;
    display: flex;
    align-items: center;
    margin: 0 0 0 0;
  }

  #search-field {
    width: 100%;
    font-size: 1.3rem;
    border: 1px solid gray;
    border-radius: 5px;
    padding: 8px;
    margin: 0 10px 0;
  }
</style>
