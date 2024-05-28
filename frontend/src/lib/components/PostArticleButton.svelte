<!-- Button to post new articles -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { goto } from "$app/navigation";
  import { refreshPage } from "../js/utils.js";
  export let data;

  async function handlePostNewArticle() {
    console.log("post new article");
    const isLoggedIn = data.isLoggedIn;

    if (isLoggedIn) {
      goto("/articles/create", { replaceState: true });
      await refreshPage();
    } else {
      goto("/login", { replaceState: true });
      await refreshPage();
    }
  }

</script>

<div class="button-container">
  <ButtonText
    buttonLabel="✚ New article"
    buttonPath="/articles/create"
    bckgColour="#F5E8DD"
    txtColour="#B5C0D0"
    borderRadius="4px 0 0 4px"
    buttonFunction={handlePostNewArticle}
  />
</div>

<style>
  .button-container {
    margin-top: 120px;
    position: fixed;
    right: 0;
    z-index: 1000;
  }
</style>
