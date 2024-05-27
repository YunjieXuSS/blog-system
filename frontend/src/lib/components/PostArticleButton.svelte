<!-- Button to post new articles -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";

  function newPost() {
    window.location = "/article/create"
  }
</script>

<div class="button-container">
  <ButtonText buttonFunction="{newPost}" buttonLabel="✚ New article" bckgColour="#F5E8DD" txtColour="#B5C0D0" borderRadius="8px 0 0 8px"/>
</div>

<style>
  .button-container {
    margin-top: 120px;
    position: fixed;
    right: 0;
    z-index: 1000;
  }
</style>