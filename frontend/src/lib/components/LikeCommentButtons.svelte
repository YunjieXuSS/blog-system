<script>
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import { goto } from "$app/navigation";
  import { ARTICLES_URL } from "$lib/js/apiUrls.js";
  import { onMount } from "svelte";
  import Modal from "$lib/components/Modal.svelte";
  import { page } from "$app/stores";

  export let data;
  export let articleId;
  export let isLiked;
  export let commentButtonFunction = async () => {};
  export let numComments = 0;
  $: numComments;

  const heartEmpty = "/heartEmpty.png";
  const heartFull = "/heartFull.png";
  const redirectUrl = "/login";

  let numLikes;
  let showPopupBox = false;
  $: path = $page.url.pathname;

  onMount(() => {
    getNumLikes().then((res) => (numLikes = res));
  });

  async function toggleLike() {
    const isLoggedIn = data.isLoggedIn;
    if (isLoggedIn && !isLiked) {
      const response = await fetch(ARTICLES_URL + "/" + articleId + "/like", {
        method: "POST",
        credentials: "include"
      });
      if (response.status === 200) {
        isLiked = !isLiked;
        getNumLikes().then((res) => (numLikes = res));
      }
    } else if (isLoggedIn && isLiked) {
      const response = await fetch(ARTICLES_URL + "/" + articleId + "/unlike", {
        method: "POST",
        credentials: "include"
      });
      if (response.status === 200) {
        isLiked = !isLiked;
        getNumLikes().then((res) => (numLikes = res));
      }
    } else if (path.startsWith("/article")) {
      showPopupBox = true;
    } else {
      goto("/login");
    }
  }

  async function getNumLikes() {
    const response = await fetch(ARTICLES_URL + "/" + articleId + "/like", {
      credentials: "include"
    });
    if (response.status === 200) {
      const body = await response.json();
      const numLikes = await body.likesCount;
      return numLikes;
    }
  }

  // let numComments;
  $: getNumComments().then((res) => (numComments = res));

  async function getNumComments() {
    const response = await fetch(ARTICLES_URL + "/" + articleId + "/commentsCount", {
      credentials: "include"
    });
    if (response.status === 200) {
      const body = await response.json();
      const numComments = await body.commentsCount;
      // console.log("ssss",numComments)
      return numComments;
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
      imgWidth="25px"
    />
  </div>

  <div class="commentButton">
    <ButtonImage
      buttonFunction={commentButtonFunction}
      imgSrc="/icons/comment.png"
      imgAlt="Comments"
      imgButtonLabel={numComments}
      imgWidth="25px"
    />
  </div>

  {#if showPopupBox}
    <Modal
      bind:showPopupBox
      description={"Login to like the article ~"}
      buttons={[
        {
          text: "Log in",
          onClick: () => {
            goto(redirectUrl);
          }
        }
      ]}
    />
    <!-- <PopupBox {popupMessage} {redirectUrl} countdown={10} bind:showPopupBox /> -->
  {/if}
</div>

<style>
  .likeCommentContainer {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    width: 150px;
    margin-bottom: 10px;
    float: right;
  }
</style>
