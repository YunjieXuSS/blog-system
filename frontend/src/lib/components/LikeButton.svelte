<script>
  import ButtonImage from "$lib/components/ButtonImage.svelte";

  let isLiked = false;

  const heartEmpty = '/heartEmpty.png';
  const heartFull = '/heartFull.png'

  function toggleLike() {
    isLiked = !isLiked;
  }
</script>

<div class="likeBtn">
  <ButtonImage
    buttonFunction={toggleLike}
    imgSrc="{isLiked ? heartFull : heartEmpty}"
    imgAlt="{isLiked ? 'Unlike' : 'Like'}"
    buttonWidth="10px"
  />
</div>

<style>
</style>
