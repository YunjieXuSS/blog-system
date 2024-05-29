<script>
  import CommentList from "../../../lib/components/CommentList.svelte";
  import ArticleView from "../../../lib/components/ArticleView.svelte";
  import { goto } from "$app/navigation";
  import { ARTICLES_URL } from "../../../lib/js/apiUrls.js";
  import PostArticleButton from "../../../lib/components/PostArticleButton.svelte";
  import LikeButton from "./../../../lib/components/LikeButton.svelte";
  import PopupBox from "../../../lib/components/PopupBox.svelte";
  import ConfirmPopupBox from "../../../lib/components/ConfirmPopupBox.svelte";
  export let data;
  let showPopupBox = false;
  let popupMessage = "";
  let redirectUrl = "/";
  let showConfirmPopupBox = false;
  let confirmFunction = () => {};

  const articleDetail = data.article;
  const isLoggedIn = data.isLoggedIn;
  let loginUser = {};
  if (isLoggedIn) {
    loginUser = data.user;
  }
  const authorId = articleDetail.userId;
  console.log("loginUser", loginUser);
  import { invalidate } from "$app/navigation";

  function handlePopupBox(operation) {
    popupMessage = `Article has been ${operation} . Redirecting to your profile page...`;
    redirectUrl = "/profile";
    showPopupBox = true;
  }

 

  async function editArticle() {
    goto(`/article/${articleDetail.articleId}/edit`);
  }



  function handleConfirmPopupBox() {
    popupMessage = `Are you sure you want to delete this article?`;
    redirectUrl = "/article/edit";
    showConfirmPopupBox = true;
    confirmFunction = deleteArticle;
    handlePopupBox("deleted");
  }

  async function deleteArticle() {
    console.log("deleteArticle");
    const response = await fetch(`${ARTICLES_URL}/${articleDetail.articleId}`, {
      method: "DELETE"
    });

    console.log(response.status);
    if (response.status === 204) {
      // Invalidating this URL will cause our +page.js load() function to rerun, because that load() function
      // depends on this URL.
      /**
       * This function will let us "invalidate" any page load functions which depend on a given URL, which will cause
       * them to be reloaded.
       */
      invalidate(ARTICLES_URL);
    } else {
      alert(`Unexpected status code received: ${response.status}`);
    }
  }
</script>

<PostArticleButton />

<main>
  <div class="articleDiv">
    {#if loginUser.userId === articleDetail.userId}
      <button class="edit" on:click={editArticle}>
        <img src="/icons/pencil-icon.png" alt="pencil" />
      </button>
      <button class="delete" on:click={handleConfirmPopupBox}>
        <img src="/icons/delete-icon.png" alt="trash-can" />
      </button>
    {/if}
  </div>


  <PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox/>

    <ConfirmPopupBox
      {popupMessage}
      {redirectUrl}
      {confirmFunction}
      operation="Deleted"
      bind:showConfirmPopupBox
    />

  <ArticleView {articleDetail} />
  <LikeButton />
  <div class="commentsDiv">
    <CommentList {authorId} loginUserId={loginUser.userId} />
  </div>
</main>

<style>
  main {
    padding: 16px;
    width: 900px;
    margin: 0 auto;
  }
  .articleDiv {
    position: relative;
  }

  .edit {
    width: 25px;
    height: 25px;
    padding: 0;
    background: none;
    border: none;
    cursor: pointer;
    position: absolute;
    right: 0;
    top: 60px;

    & img {
      width: 100%;
      height: 100%;
    }
  }

  .delete {
    width: 30px;
    height: 30px;
    padding: 0;
    background: none;
    border: none;
    cursor: pointer;
    position: absolute;
    top: 120px;
    right: 0;

    & img {
      width: 100%;
      height: 100%;
    }
  }
</style>
