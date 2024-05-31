<script>
  import { createEventDispatcher } from "svelte";
  export let searchTerm;
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

  <svg
    xmlns="http://www.w3.org/2000/svg"
    class="icon icon-tabler icon-tabler-search"
    width="44"
    height="44"
    viewBox="0 0 24 24"
    stroke-width="1.5"
    stroke="#9e9e9e"
    fill="none"
    stroke-linecap="round"
    stroke-linejoin="round"
  >
    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
    <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0" />
    <path d="M21 21l-6 -6" />
  </svg>

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
    font-family: "Nunito", sans-serif;
    font-size: 1rem;
    font-weight: 400;
    color: gray;
    padding: 8px;
    margin: 0;
  }
</style>
