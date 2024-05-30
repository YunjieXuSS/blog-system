<script>
  import CommentCard from "./CommentCard.svelte";
  import { page } from "$app/stores";
  import { getComments, postComment } from "../js/comments";
  import { onMount } from "svelte";
  import { goto } from "$app/navigation";
  import Modal from "./Modal.svelte";
  let redirectUrl = "/login";
  let showPopupBox = false;

  export let numComments = 0;

  export let authorId;
  export let loginUserId = 0;

  let commentToArticle = "";
  const { articleId } = $page.params;

  let comments = [];
  let loadedComment = false;
  let sending = false;
  let showComments = true;

  function toggleComments() {
    showComments = !showComments;
  }

  function generateCommentProps(comments, parentId = null) {
    if (!comments) return [];
    const currentComments = comments.filter((comment) => comment.parentCommentId === parentId);
    const descendantsComments = comments.filter((comment) => comment.parentCommentId !== parentId);

    currentComments.forEach((currentComment) => {
      currentComment.children = generateCommentProps(descendantsComments, currentComment.commentId);
    });

    return currentComments;
  }

  // function removeParentCommentId(comments) {
  //   return comments.map(comment => {
  //       delete comment.parentCommentId;
  //       return comment;
  //     });
  // }
  onMount(async () => {
    try {
      comments = await getComments({ articleId });
      numComments = comments.length;
      // comments = removeParentCommentId(comments);
      loadedComment = true;
    } catch (error) {
      console.error(error);
    }
  });

  $: commentProps = generateCommentProps(comments);

  async function postCommentToArticle() {
    if (loginUserId === 0) { 
      showPopupBox=true;
      return;
    }
    sending = true;
    try {
      await postComment({ content: commentToArticle, articleId });
      comments = await getComments({ articleId });
      numComments = comments.length;
      // comments = removeParentCommentId(comments);
      clearTextarea();
    } catch (error) {
      console.error(error);
    } finally {
      sending = false;
    }
  }

  function clearTextarea() {
    commentToArticle = "";
  }

  async function refreshComments() {
    comments = await getComments({ articleId });
    numComments = comments.length;
    // comments = removeParentCommentId(comments);
  }
</script>

<section class="comments">
  <div class="title-area">
    <h2>Comments</h2>
    <!-- <button class="title-button" on:click={toggleComments}>
      <h2>{showComments ? "Hide Comments" : "Show Comments"}</h2></button> -->
      <button class="title-button" on:click={toggleComments}>
        <img class="comment-view-control" src = {showComments ? "/icons/up-arrow.png" : "/icons/down-arrow.png"} alt=""></button>
  </div>

  <textarea
    class="comment-input"
    placeholder="Write your comment here!"
    maxlength="500"
    disabled={sending}
    bind:value={commentToArticle}
  />
  <div class= "operations" >
  <button on:click={postCommentToArticle} disabled={sending}>post</button>
  <button on:click={clearTextarea}>clear</button>
  </div>

  <div class="list" style="display: {showComments ? '' : 'none'};">
    {#if !loadedComment}
      <p class="loading">loading...</p>
    {:else}
      {#each commentProps as comment (comment.commentId)}
        <CommentCard {...comment} {refreshComments} {authorId} {loginUserId} />
      {/each}
    {/if}
  </div>
</section>
<div class="comments-container" />
{#if showPopupBox}
<Modal
  bind:showPopupBox
  description={"You should login to reply."}
  buttons={[
    {
      text: "Log in",
      onClick: () => {
        goto(redirectUrl);
      }
    }
  ]}
  countdown={10}
  countdownCallback={() => {
    goto(redirectUrl);
  }}
  countdownMessage={"Redirecting"}
/>
<!-- <PopupBox {popupMessage} {redirectUrl} countdown={10} bind:showPopupBox /> -->
{/if}

<style>
  .comments {
    min-height: 400px;
    flex: 1;
    margin:50px;

    & .title-area {
      display: flex;
      justify-content: flex-start;
    }

    & .loading {
      font-size: 1.2em;
      text-align: center;
    }

    & textarea.comment-input {
      display: block;
      width: 100%;
      height: 100px;
      box-sizing: border-box;
      margin:0;
      padding: 8px;
      resize: vertical;
    }

    & .operations {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      margin-bottom:20px;
    }

    & button {
      margin: 0 16px 0 0;
      background: transparent;
      border: none;
      outline: none;
      color: #454545;
      font-size: 0.8em;
      font-weight: 700;
      padding: 2px 4px;
      &:hover {
        cursor: pointer;
        color: #9EB384;
        text-decoration: underline;
      }
    }
  }
  .comment-view-control {
    width: 20px;
    margin-left:10px;
  }
</style>
