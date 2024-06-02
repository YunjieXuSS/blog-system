<!-- Button to post new articles -->

<script>
  import "$lib/css/button.css";
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
    buttonClass="postButton"
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
