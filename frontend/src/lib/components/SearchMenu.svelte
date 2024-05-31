<script>
  export let selectedCategory;
</script>

<section class="menu-container">
  <select class="menu" name="menu" bind:value={selectedCategory}>
    <option selected value="title">Title</option>
    <option value="userName">Author</option>
    <option value="date">Date</option>
  </select>
</section>

<style>
  /* .menu-container {
    height: 40px;
    width: 80px;
    display: flex;
    margin: 0 10px 0 0;
  }

  select {
    margin: 0;
    font-family: "Nunito", sans-serif;
    font-size: 1rem;
    font-weight: 400;
    color: gray;
    border: 1px solid gray;
    border-radius: 5px;
  }

  .menu {
    width: 100%;
  } */

  .menu-container {
    height: 30px;
    width: 100px;
    display: flex;
    margin: 0;
  }

  select {
    margin: 0;
    font-family: "Nunito", sans-serif;
    font-size: 1rem;
    font-weight: 400;
    color: gray;
    border: 1px solid gray;
    border-radius: 5px;
  }

  .menu {
    width: 100%;
  }

  .menu:focus {
    outline: none;
    box-shadow: none;
  }
</style>
