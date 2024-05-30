<script>
  import { user } from "./../js/store.js";
  // import userDefaultIcon from "../images/userDefaultIcon.png";
  import { deleteComment, postComment } from "../js/comments";
  import { SERVER_URL } from "$lib/js/apiUrls";
  import dayjs from "dayjs";
  import PopupBox from "./PopupBox.svelte";
  import { goto } from "$app/navigation";
  import Modal from "./Modal.svelte";
  let popupMessage = "";
  let redirectUrl = "/";
  let showPopupBox = false;
  let showDeletePopupBox = false;

  export let articleId = "";
  export let userId = "";
  export let userName = "";
  export let content = "";
  export let children = [];
  export let deep = 0;
  export let commentId = 0;
  export let isDeleted = false;
  export let createDate = "now";
  export let authorId = "";
  export let avatar = "";
  export let refreshComments = async () => {};

  const INTENT = 24;
  let replying = false;
  let sending = false;
  let reply = "";
  let errorMessage = "";
  let avatarImage;
  export let loginUserId = 0;

  $: allowDelete = (loginUserId === userId || authorId === loginUserId) && !isDeleted;
  $: authorLink = `/profile/${userName}`;
  $: {
    if (!replying) errorMessage = "";
  }

  function startReply() {
    if (!loginUserId) {
      popupMessage = "Please login to reply.";
      showPopupBox = true;
      redirectUrl = "/login";
    } else {
      replying = true;
    }
  }

  function endReply() {
    replying = false;
  }

  function useFallbackAvatar() {
    if (avatarImage) avatarImage.src = "/userDefaultIcon.png";
  }

  async function postReply() {
    if (!reply) return endReply();
    sending = true;
    try {
      await postComment({ articleId, content: reply, parentId: commentId });
      await refreshComments();
      replying = false;
      errorMessage = "";
      reply = "";
      endReply();
    } catch (error) {
      console.error(error);
      errorMessage = "Error on sending message, try again!";
    } finally {
      sending = false;
    }
  }

  async function deleteReply() {
    try {
      await deleteComment({ commentId });

      await refreshComments();
    } catch (error) {
      console.error(error);
    } finally {
      endReply();
    }
  }

  function shouldDeleteCommentCard(comment) {
    if (!comment.children.length) {
      return comment.isDeleted;
    }

    const childrenShouldBeDeleted = comment.children.every(shouldDeleteCommentCard);
    const shouldDelete = comment.isDeleted && childrenShouldBeDeleted;
    return shouldDelete;
  }
</script>

<div
  class="comment-container"
  style="margin-left: {deep ? INTENT : 0}px; display:{shouldDeleteCommentCard({
    commentId,
    isDeleted,
    children
  })
    ? 'none'
    : 'block'}"
>
  <a class="author-info" href={authorLink}>
    <img
      class="avatar"
      src={isDeleted ? "/userDefaultIcon.png" : SERVER_URL + "/" + avatar}
      alt=""
      bind:this={avatarImage}
      on:error={useFallbackAvatar}
    />
    {#if !isDeleted}
      <div class="author">{userName}</div>
      <div class="date">{dayjs(createDate).format("YYYY-MM-DD hh:mm:ss")}</div>
    {/if}
  </a>

  <div class="main-content">
    <p class="content {isDeleted ? 'deleted' : ''}">{content}</p>
    {#if deep < 15 && !replying && !isDeleted}
      <button class="edit-button" on:click={startReply}>reply</button>
    {/if}
    {#if allowDelete}
      <button on:click={()=>{console.log("delete");showDeletePopupBox=true}} class="edit-button">delete</button>
    {/if}
    <div class="edit">
      {#if replying}
        <textarea
          disabled={sending}
          class="reply-input"
          rows="4"
          maxlength="500"
          bind:value={reply}
          placeholder="Please be nice and kind."
        />
        {#if errorMessage}
          <p class="error">{errorMessage}</p>
        {/if}
        <button on:click={postReply} disabled={sending}>send</button>
        <button on:click={endReply}>cancel</button>
      {/if}
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
      {#if showDeletePopupBox}
      <Modal
        bind:showPopupBox={showDeletePopupBox}
        description={"Are you sure you want to delete this comment?"}
        buttons={[
          {
            text: "Confirm",
            onClick: deleteReply
          }
        ]}
      />
      <!-- <PopupBox {popupMessage} {redirectUrl} countdown={10} bind:showPopupBox /> -->
    {/if}
    </div>

    {#each children as child (child.commentId)}
      <svelte:self {...child} deep={deep + 1} {refreshComments} {authorId} {loginUserId} />
    {/each}
  </div>
</div>

<style>
  .comment-container {
    padding-top: 24px;
    border-left: 1px solid #ababab;

    & a.author-info {
      display: flex;
      align-items: center;
      text-decoration: none;

      & .author {
        font-weight: 700;
        color: #131110;
      }

      & .avatar {
        padding: 2px 8px;
        width: 32px;
        height: 32px;
        border-radius: 50%;
      }

      & .date {
        font-size: 0.8em;
        margin-left: 16px;
        color: #666666;
      }
    }

    & .main-content {
      padding: 0 8px;

      & p.content {
        white-space: pre-wrap;
        margin: 0;
        padding: 8px;
      }

      & p.deleted {
        color: #ababab;
      }
    }

    & .error {
      font-size: 0.8em;
      color: red;
    }

    & button.edit-button {
      margin: 0;
      background: transparent;
      border: none;
      outline: none;
      color: #454545;
      font-size: 0.8em;
      font-weight: 700;
      padding: 2px 4px;

      &:hover {
        text-decoration: underline;
        cursor: pointer;
      }
    }

    & textarea.reply-input {
      display: block;
      resize: vertical;
      width: 400px;
      box-sizing: border-box;
      padding: 8px;
    }

    & .edit {
      margin-top: 16px;
      margin-left: 24px;
    }
  }
</style>
