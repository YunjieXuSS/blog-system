<!-- Button to post new articles -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { goto } from "$app/navigation";
  export let data;

  async function handlePostNewArticle() {
    const isLoggedIn = data.isLoggedIn;

    if (isLoggedIn) {
      goto("/article/create", { replaceState: true });
    } else {
      goto("/login", { replaceState: true });
    }
  }
</script>

<div class="button-container">
  <ButtonText
    buttonFunction={handlePostNewArticle}
    buttonLabel="✚ New article"
    bckgColour="#9EB384"
    txtColour="white"
    borderRadius="8px 0 0 8px"
    buttonHeight="55px"
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
