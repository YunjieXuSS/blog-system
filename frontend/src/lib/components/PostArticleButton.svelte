<!-- Button to post new articles -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";
</script>

<div class="button-container">
  <ButtonText buttonLabel="✚ New article" buttonPath="/articles/create" bckgColour="#F5E8DD" txtColour="#B5C0D0" borderRadius="4px 0 0 4px"/>
</div>

<style>
  .button-container {
    margin-top: 120px;
    position: fixed;
    right: 0;
    z-index: 1000;
  }
</style>