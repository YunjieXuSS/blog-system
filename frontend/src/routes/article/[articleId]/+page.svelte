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
  const articleNotFound = JSON.stringify(articleDetail) === "{}";

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
      invalidate(ARTICLES_URL);
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
{#if articleNotFound}
  <div class="not-fount-hint">Not found</div>
{:else}
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
{/if}

<style>
  main {
    padding: 16px;
    width: 900px;
    margin: 40px auto;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.46);
  }

  @media (max-width: 1000px) {
    main {
      width: 90%;
      box-sizing: border-box;
    }
  }

  @media (max-width: 700px) {
    main {
      width: 80%;
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
    width: 5px;
    padding: 0;
    background: none;
    border: none;
    cursor: pointer;
    position: absolute;
    right: -15px;
    top: 60px;

    & img {
      width: 40%;
      height: 50%;
    }
  }

  .delete {
    width: 15px;
    padding: 0;
    background: none;
    border: none;
    cursor: pointer;
    position: absolute;
    top: 120px;
    right: -10px;

    & img {
      width: 50%;
      height: 100%;
    }
  }
  .not-fount-hint {
    font-size: 2rem;
    margin-top: 20px;
    text-align: center;
  }
</style>
