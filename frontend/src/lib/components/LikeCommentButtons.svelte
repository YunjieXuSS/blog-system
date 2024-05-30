<script>
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import { goto } from "$app/navigation";
  import { ARTICLES_URL } from "$lib/js/apiUrls.js";

  export let data;
  export let articleId;
  // export let numComments = 0;
  export let isLiked;

  const heartEmpty = "/heartEmpty.png";
  const heartFull = "/heartFull.png";

  async function toggleLike() {
    const isLoggedIn = data.isLoggedIn;
    if (isLoggedIn && !isLiked) {
      const response = await fetch(ARTICLES_URL+"/"+articleId+"/like", { 
        method: "POST",
        credentials: "include" 
      });
      if (response.status === 200) {
      isLiked = !isLiked;
      numLikes = getNumLikes().then((res) => numLikes = res);
      }
    } else if(isLoggedIn && isLiked){
      const response = await fetch(ARTICLES_URL+"/"+articleId+"/unlike", { 
        method: "POST",
        credentials: "include" 
      });
      if (response.status === 200) {
      isLiked = !isLiked;
      numLikes = getNumLikes().then((res) => numLikes = res);
      }
    }
    else {
      goto("/login", { replaceState: true });
    }
  }

  function goToComments() {
    const comments = document.querySelector(".commentButton");
    comments.scrollIntoView({ behavior: 'smooth'});
  }

  let numLikes;
  $:numLikes = getNumLikes().then((res) => numLikes = res);

  async function getNumLikes(){
    const response = await fetch(ARTICLES_URL+"/"+articleId+"/like", { credentials: "include" });
    if (response.status === 200) {
      const body = await response.json();
      const numLikes = await body.likesCount
      return numLikes;
    }
  }

  let numComments;
  $:numComments = getNumComments().then((res) => numComments = res);

  async function getNumComments() {
    const response = await fetch(ARTICLES_URL+"/"+articleId+"/like", { credentials: "include" });
    if (response.status === 200) {
      const body = await response.json();
      const numLikes = await body.likesCount
      return numLikes;
    }
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
