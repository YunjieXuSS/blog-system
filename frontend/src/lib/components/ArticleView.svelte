<script>
  export let articleDetail;
  import dayjs from "dayjs";
  import { SERVER_URL } from "../js/apiUrls.js";
  import { onMount } from "svelte";

  let imageLoaded = true;
  function handleImageError(event) {
    imageLoaded = false;
  }

  onMount(() => {
    const img = new Image();
    img.src = SERVER_URL + articleDetail.imgUrl;
    img.onload = () => {
      imageLoaded = true;
    };
    img.onerror = () => {
      handleImageError();
    };
  });
</script>

<article class="article-container">
  <h1 class="article-title">{articleDetail.title}</h1>
  <p class="user"><strong>@Author: </strong>{articleDetail.userName}</p>
  <p class="date">{dayjs(articleDetail.createDate).format("YYYY-MM-DD hh:mm:ss")}</p>
  {#if imageLoaded}
    <img src={SERVER_URL + articleDetail.imgUrl} alt="" class="article-image" />
  {/if}
  <p class="article-content" >{@html articleDetail.content}</p>
</article>

<style>
  .article-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 800px;
    margin: auto;
    padding: 20px;
    background-color: #fff;
    box-sizing: border-box; /* Ensure padding is included in the width */
  }

  .article-image {
    width: 500px;
    margin-bottom: 5px;
  }

  .article-title {
    font-size: 2em;
    margin-bottom: 5px;
    text-align: center;
  }

  .user {
    font-size: 1em;
    color: #555;
  }

  .date {
    font-size: 0.9em;
    font-style: italic;
    color: #999;
  }

  .article-content {
    font-size: 1.2em;
    line-height: 1.6;
    color: #333;
    text-align: justify;
    width: 100%;
    /* display: -webkit-box;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
      line-height: 1.5;
      max-height: calc(1.5em * 7);  */
  }
</style>
