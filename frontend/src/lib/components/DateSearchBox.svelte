<script>
  export let searchTerm;
</script>

<div id="search-input-cont">
  <input
    type="date"
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
    width: 150px;
    display: flex;
    align-items: center;
    margin: 5px 1px;
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
