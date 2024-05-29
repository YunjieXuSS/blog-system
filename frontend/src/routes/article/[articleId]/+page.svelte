<script>
  import CommentList from "../../../lib/components/CommentList.svelte";
  import ArticleCard from "../../../lib/components/ArticleCard.svelte";
  import { goto } from "$app/navigation";
  import { ARTICLES_URL } from "../../../lib/js/apiUrls.js";
  import PostArticleButton from "../../../lib/components/PostArticleButton.svelte";
  import LikeButton from "./../../../lib/components/LikeButton.svelte";
  import LikesCommentsDisplay from "$lib/components/LikesCommentsDisplay.svelte";
  export let data;

  const article = data.article;
  const isLoggedIn = data.isLoggedIn;
  let loginUser = {};
  if (isLoggedIn) {
    loginUser = data.user;
  }
  const authorId = article.userId;
  console.log("loginUser", loginUser);
  import { invalidate } from "$app/navigation";


  async function editArticle() {
    goto(`/article/${article.articleId}/edit`);
  }

  async function deleteArticle(e) {
    console.log("deleteArticle");
    const article = e.detail;
    const response = await fetch(`${ARTICLES_URL}/${article.articleId}`, {
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

<PostArticleButton data={data} />

<main>
  <div class="articleDiv">
    {#if loginUser.userId === article.userId}
      <button class="edit" on:click={editArticle}>
        <img src="/icons/pencil-icon.png" alt="pencil" />
      </button>
      <button class="delete" on:click={deleteArticle}>
        <img src="/icons/delete-icon.png" alt="trash-can" />
      </button>
    {/if}
  </div>

  <ArticleCard {article} />

  <LikesCommentsDisplay data={data} />

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
  

  .edit{
    width: 22px;
    height: 22px;
    padding: 0;
    background: none;
    border: none;
    cursor: pointer;
    position: absolute;
    right: 0;

    & img {
      width: 100%;
      height: 100%;
    }
  }

  .delete {
    width: 22px;
    height: 22px;
    padding: 0;
    background: none;
    border: none;
    cursor: pointer;
    position: absolute;
    right: 22px;

    & img {
      width: 100%;
      height: 100%;
    }
  }
</style>
