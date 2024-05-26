<script>
export let selectedCategory;
//   $: console.log(selectedCategory);

</script>

<!-- svelte-ignore a11y-no-onchange -->
<section class="menu-cont">
  <select class="menu" name="menu" id="menu" bind:value={selectedCategory} >
    <option disabled selected value="">Select Category</option>
    <option selected value="title">Title</option>
    <option value="userName">Author</option>
    <option value="date">Date</option>
  </select>
</section>

<style>
  .menu-cont {
    height: 40px;
    width: 47%;
    display: flex;
    margin: 0 10px 0 0;
  }

  select {
    margin: 0;
    font-family: 'Nunito', sans-serif;
    font-size: 1rem;
    font-weight: 400;
    color: gray;
    border: 1px solid gray;
    border-radius: 5px;
  }

  .menu {
    width: 100%;
  }
</style>
