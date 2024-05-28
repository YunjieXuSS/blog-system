<!-- Button to post new articles -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { goto } from "$app/navigation";
  export let data;

  async function handlePostNewArticle() {
    console.log("post new article");
    const isLoggedIn = data.isLoggedIn;

    if (isLoggedIn) {
      goto("/articles/create", { replaceState: true });
    } else {
      goto("/login", { replaceState: true });
    }
  }
</script>

<div class="button-container">
  <ButtonText
    buttonFunction={handlePostNewArticle}
    buttonLabel="✚ New article"
    bckgColour="#B5C0D0"
    txtColour="#F5E8DD"
    borderRadius="8px 0 0 8px"
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
