<script>
  export let searchTerm;
</script>

<div class="searchBarContainer">
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
    width="28"
    height="28"
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
  .searchBarContainer {
    display: flex;
    align-items: center;
    margin: 0 20px;
    padding: 5px;
    height: 30px;
    max-width: 800px;
    min-width: 500px;
    border: 1px solid gray;
    border-radius: 25px;
    background-color: white;
  }

  #search-field {
    margin: 0;
    padding: 8px;
    width: 100%;
    height: 80%;
    border-radius: 25px;
    border: transparent;
    font-family: "Nunito", sans-serif;
    font-size: 1rem;
    font-weight: 400;
    color: rgb(77, 77, 77);
  }

  #search-field:focus {
    outline: none;
    box-shadow: none;
  }
</style>
