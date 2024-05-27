<script>
  import ButtonImage from "$lib/components/ButtonImage.svelte";

  function likeUnlike() {
    console.log("like/unlike");
  }
</script>

<div class="likeBtn">
  <ButtonImage
    buttonFunction={likeUnlike}
    imgSrc="/heartEmpty.png"
    imgAlt="Like/Unlike"
    buttonWidth="10px"
  />
</div>

<style>
</style>
