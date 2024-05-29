<script>
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import { goto } from "$app/navigation";
  export let data;
  export let numLikes = 0;
  export let numComments = 0;

  let isLiked = false;

  const heartEmpty = "/heartEmpty.png";
  const heartFull = "/heartFull.png";

  function toggleLike() {
    const isLoggedIn = data.isLoggedIn;

    if (isLoggedIn) {
      isLiked = !isLiked;
    } else {
      goto("/login", { replaceState: true });
    }
  }

  function goToComments() {
    const comments = document.querySelector(".commentButton");
    comments.scrollIntoView({ behavior: 'smooth'});
  }
</script>

<div class="likeCommentContainer">

  <div class="likeButton">
    <ButtonImage
      buttonFunction={toggleLike}
      imgSrc={isLiked ? heartFull : heartEmpty}
      imgAlt={isLiked ? "Unlike" : "Like"}
      imgButtonLabel={numLikes}
      buttonWidth="10px"
    />
  </div>

  <div class="commentButton">
    <ButtonImage
      buttonFunction={goToComments}
      imgSrc="/icons/comment.png"
      imgAlt="Comments"
      imgButtonLabel={numComments}
      buttonWidth="10px"
    />
  </div>

</div>

<style>
  .likeCommentContainer {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }
</style>
