<script>
  import { onDestroy, onMount } from "svelte";
  const searchByValues = [
    { name: "Title", value: "title" },
    { name: "Author", value: "userName" },
    { name: "Date", value: "date" }
  ];
  const sortByValues = [
    { name: "Newest", value: "dateDesc" },
    { name: "Oldest", value: "dateAsc" },
    { name: "Title a-z", value: "titleAsc" },
    { name: "Title z-a", value: "titleDesc" },
    { name: "Author a-z", value: "userNameAsc" },
    { name: "Author z-a", value: "userNameDesc" }
  ];

  let showSearchBy = false;
  let showSortBy = false;
  let searchedBy = searchByValues[0];
  let sortedBy = sortByValues[0];
  let isSearching = false;

  export let searchTerm = "";

  export let selectedCategory = searchedBy.value;
  $: selectedCategory = searchedBy.value;

  export let sortByCategory = sortedBy.value;

  export let searchTermStart = 0;
  export let searchTermEnd = 0;

  function showSearchByList(event) {
    showSearchBy = true;
  }
  function showSortByList() {
    showSortBy = true;
  }
  function hideSearchByList() {
    showSearchBy = false;
  }
  function hideSortByList() {
    showSortBy = false;
  }
  function setSearchBy(search) {
    searchedBy = search;
    hideSearchByList();
  }

  function setSortBy(sort) {
    sortedBy = sort;
    hideSortByList();
  }

  function hideAllList() {
    showSearchBy = false;
    showSortBy = false;
  }

  function debounce(func, wait = 500) {
    let timer;

    function debounced(...args) {
      const self = this;
      if (timer == null) {
        addTimer();
        return;
      }

      if (timer != null) {
        clearTimer();
        addTimer();
        return;
      }

      function addTimer() {
        isSearching = true;
        timer = setTimeout(() => {
          invokeFunc();
          isSearching = false;
          clearTimer();
        }, wait);
      }

      function invokeFunc() {
        func.apply(self, args);
      }
    }

    return debounced;

    function clearTimer() {
      clearTimeout(timer);
      timer = null;
    }
  }
  const setSearchTerm = (e) => {
    searchTerm = e.target.value;
  };

  const debouncedSetSearchTerm = debounce(setSearchTerm);

  $: sortByCategory = sortedBy.value;

  $: {
    if (searchedBy.value === "date") {
      searchTerm = "";
    } else {
      searchTermStart = 0;
      searchTermEnd = 0;
    }
  }

  onMount(() => {
    const hideList = (e) => {
      if (![...e.target.classList].includes("keep-list")) {
        hideAllList();
      }
    };
    document.addEventListener("click", hideList);

    return () => {
      document.removeEventListener("click", hideList);
      searchTerm = "";
    };
  });
</script>

<div class="search-sort">
  <div class="loadingAnimate">
    {#if isSearching}
      <svg
        class="loader"
        version="1.1"
        id="L4"
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        x="0px"
        y="0px"
        viewBox="0 0 100 100"
        enable-background="new 0 0 0 0"
        xml:space="preserve"
      >
        <circle fill="#fff" stroke="none" cx="6" cy="50" r="6">
          <animate
            attributeName="opacity"
            dur="1s"
            values="0;1;0"
            repeatCount="indefinite"
            begin="0.1"
          />
        </circle>
        <circle fill="#fff" stroke="none" cx="26" cy="50" r="6">
          <animate
            attributeName="opacity"
            dur="1s"
            values="0;1;0"
            repeatCount="indefinite"
            begin="0.2"
          />
        </circle>
        <circle fill="#fff" stroke="none" cx="46" cy="50" r="6">
          <animate
            attributeName="opacity"
            dur="1s"
            values="0;1;0"
            repeatCount="indefinite"
            begin="0.3"
          />
        </circle>
      </svg>
    {/if}
  </div>

  <div class="select search-by select-toggle keep-list">
    <button class="keep-list" on:click={showSearchByList}>
      <div class="search-by-name keep-list">
        <img src="/icons/search-by.svg" alt="" class="icon keep-list" />
      </div>
      <div class="search-by-value keep-list">
        {searchedBy.name}
      </div>
    </button>

    <div class="search-by-values keep-list" style="display: {showSearchBy ? '' : 'none'};">
      {#each searchByValues as search}
        <button
          class="list-value keep-list"
          id={search.value}
          style="display: {search.value === searchedBy.value ? 'none' : ''}"
          on:click={(event) => {
            event.stopPropagation();
            setSearchBy(search);
          }}
        >
          {search.name}
        </button>
      {/each}
    </div>
  </div>
  <div class="input-area">
    {#if searchedBy.value === "date"}
      <input type="date" bind:value={searchTermStart} class="date" placeholder="Start date" />
      <span class="to"> to </span><input
        type="date"
        bind:value={searchTermEnd}
        class="Start date"
      />
    {:else}
      <input
        type="text"
        class="keyword"
        on:input={debouncedSetSearchTerm}
        placeholder="Search keywords..."
      />
    {/if}
  </div>

  <div class="select sort-by keep-list">
    <button on:click={showSortByList} class="keep-list">
      <div class="sort-by-name keep-list">
        <img src="/icons/sort-by.svg" alt="" class="icon keep-list" />
      </div>
      <div class="sort-by-value select-toggle keep-list">
        {sortedBy.name}
      </div>
    </button>
    <div class="sort-by-values keep-list" style="display: {showSortBy ? '' : 'none'};">
      {#each sortByValues as sort}
        <button
          class="list-value keep-list"
          id={sort.value}
          style="display: {sort.value === sortedBy.value ? 'none' : ''}"
          on:click={(event) => {
            event.stopPropagation();
            setSortBy(sort);
          }}
        >
          {sort.name}
        </button>
      {/each}
    </div>
  </div>
</div>

<style>
  button {
    display: block;
    border: none;
    width: 100%;
    background: transparent;
  }

  .search-sort {
    display: flex;
    padding: 8px;
    background: #435334;
    justify-content: center;
    align-items: center;
    width: 600px;
    min-height: 60px;

    @media screen and (max: 600px) {
      width: 100%;
    }
  }

  .search-sort .search-by,
  .sort-by {
    width: 80px;
    position: relative;
  }

  .search-by-name,
  .sort-by-name {
    font-weight: 700;
    text-align: center;
  }

  .search-by-value,
  .search-by-values,
  .sort-by-value,
  .sort-by-values {
    font-size: 1.2em;
    text-align: left;
    text-align: center;
    border-radius: 0 0 8px 8px;
    font-family: Nunito, sans-serif;
  }

  .search-by-values,
  .sort-by-values {
    width: 100%;
    position: absolute;
    background: #435334;
    top: 45px;
    left: 0;
  }
  .search-by-value {
    color: white;
  }
  .sort-by-value {
    color: white;
  }

  .list-value {
    padding: 12px 8px;
    color: white;
    font-size: 0.7em;
  }
  .list-value:hover {
    background: #4a5d4c;
  }

  input.keyword {
    width: 100%;
    padding: 4px 6px;
    height: 28px;
  }

  .sort-by {
    width: 100px;
    text-align: center;
  }

  .input-area {
    display: flex;
    align-items: center;
    flex: 1;
    box-sizing: border-box;
    margin: 0 4px;
    justify-content: center;
    flex-wrap: wrap;
  }

  .to {
    padding: 0 8px;
  }

  input.date {
    padding: 4px 6px;
    flex: 1;
  }

  img.icon {
    width: 22px;
    height: 22px;
    filter: invert(0.9);
  }

  .loadingAnimate {
    width: 5%;
    height: 100%;
  }
  .loader {
    width: 45x;
    height: 45px;
  }
</style>
