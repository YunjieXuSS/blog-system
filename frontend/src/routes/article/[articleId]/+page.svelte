<script>
  import { goto } from "$app/navigation";
  import { ARTICLES_URL } from "$lib/js/apiUrls.js";
  import CommentList from "$lib/components/CommentList.svelte";
  import ArticleView from "$lib/components/ArticleView.svelte";
  import PostArticleButton from "$lib/components/PostArticleButton.svelte";
  import PopupBox from "$lib/components/PopupBox.svelte";
  import ConfirmPopupBox from "$lib/components/ConfirmPopupBox.svelte";
  import LikeCommentButtons from "$lib/components/LikeCommentButtons.svelte";

  export let data;

  let showPopupBox = false;
  let ConfirmPopupMessage = "";
  let resultMsg = "";
  let popupMessage = "";
  let redirectUrl = "/";
  let showConfirmPopupBox = false;
  let confirmFunction = () => {};

  const articleDetail = data.article;
  const isLoggedIn = data.isLoggedIn;

  let loginUser = {};
  let numComments = 0;

  if (isLoggedIn) {
    loginUser = data.user;
  }

  const authorId = articleDetail.userId;
  import { invalidate } from "$app/navigation";

  async function editArticle() {
    goto(`/article/${articleDetail.articleId}/edit`);
  }

  function handleConfirmPopupBox() {
    ConfirmPopupMessage = `Are you sure you want to delete this article?`;
    redirectUrl = "/article/edit";
    showConfirmPopupBox = true;
    confirmFunction = deleteArticle;
  }

  function handleDeletePopupBox() {
    popupMessage = `Article has been deleted. Redirecting to your profile page...`;
    redirectUrl = `/profile/${loginUser.userName}`;
    showPopupBox = true;
  }

  async function deleteArticle() {
    const response = await fetch(`${ARTICLES_URL}/${articleDetail.articleId}`, {
      method: "DELETE"
    });
    if (response.status === 204) {
      // Invalidating this URL will cause our +page.js load() function to rerun, because that load() function
      // depends on this URL.
      /**
       * This function will let us "invalidate" any page load functions which depend on a given URL, which will cause
       * them to be reloaded.
       */
      invalidate(ARTICLES_URL);
      console.log("Article deleted successfully.");
      handleDeletePopupBox();
    } else {
      alert(`Unexpected status code received: ${response.status}`);
    }
  }

  function goToComments() {
    const comments = document.querySelector(".commentsDiv");
    comments.scrollIntoView({ behavior: "smooth" });
  }
</script>

<PostArticleButton {data} />

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

  <PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox />

  <ConfirmPopupBox {ConfirmPopupMessage} {confirmFunction} bind:showConfirmPopupBox />

  <ArticleView {articleDetail} />

  <div class="like-comment-buttons-container">
    <LikeCommentButtons
      {data}
      articleId={articleDetail.articleId}
      isLiked={data.isLiked}
      {numComments}
      commentButtonFunction={goToComments}
    />
  </div>

  <div class="commentsDiv">
    <CommentList {authorId} loginUserId={loginUser.userId} bind:numComments />
  </div>
</main>

<style>
  main {
    padding: 16px;
    width: 900px;
    margin: 40px auto;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.46);
  }

  @media (max-width: 600px) {
    main {
      width: 100%;
      box-sizing: border-box;
    }
  }

  .articleDiv {
    position: relative;
  }

  .like-comment-buttons-container {
    margin-right: 40px;
  }

  .edit {
    width: 22px;
    height: 22px;
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
