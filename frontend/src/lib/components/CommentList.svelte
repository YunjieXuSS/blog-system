<script>
  import CommentCard from "./CommentCard.svelte";
  import { page } from "$app/stores";
  import { getComments, postComment } from "../js/comments";
  import { onMount } from "svelte";

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
    const rootComments = comments.filter((comment) => comment.parentCommentId === parentId);
    const childrenComments = comments.filter((comment) => comment.parentCommentId !== parentId);
    rootComments.forEach((parentComment) => {
      parentComment.children = generateCommentProps(
        childrenComments,
        parentComment.commentId
      ).filter(
        (comment) =>
          comment.parentCommentId === parentComment.commentId &&
          (!comment.isDeleted || (comment.isDeleted && comment.children?.length))
      );
    });

    return rootComments;
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
      // comments = removeParentCommentId(comments);
      loadedComment = true;
    } catch (error) {
      console.error(error);
    }
  });

  $: commentProps = generateCommentProps(comments);

  async function postCommentToArticle() {
    sending = true;
    try {
      await postComment({ content: commentToArticle, articleId });
      comments = await getComments({ articleId });
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
    // comments = removeParentCommentId(comments);
  }
</script>

<section class="comments">
  <div class="title-area">
    <h2>Comments</h2>
    <button class="title-button" on:click={toggleComments}
      ><h2>{showComments ? "Hide Comments" : "Show Comments"}</h2></button
    >
  </div>

  <textarea
    class="comment-input"
    placeholder="Write your comment here!"
    maxlength="500"
    disabled={sending}
    bind:value={commentToArticle}
  />
  <div class= "operations" >
  <button on:click={postCommentToArticle} disabled={sending}>reply</button>
  <button on:click={clearTextarea}>clear</button>
  </div>

  <div class="list" style="display: {showComments ? '' : 'none'};">
    {#if !loadedComment}
      <p class="loading">loading...</p>
    {:else}
      {#each commentProps as comment}
        <CommentCard {...comment} {refreshComments} {authorId} {loginUserId} />
      {/each}
    {/if}
  </div>
</section>
<div class="comments-container" />

<style>
  .comments {
    min-height: 400px;
    flex: 1;

    & .title-area {
      display: flex;
      justify-content: space-between;
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
      gap: 16px;
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
    }
  }
</style>
