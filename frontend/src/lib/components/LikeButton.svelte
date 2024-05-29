<script>
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import { goto } from "$app/navigation";
  export let data;
  let isLiked = false;

  const heartEmpty = '/heartEmpty.png';
  const heartFull = '/heartFull.png'

  function toggleLike() {
    const isLoggedIn = data.isLoggedIn;

    if (isLoggedIn) {
      isLiked = !isLiked;
    } else {
      goto("/login", { replaceState: true });
    }
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
