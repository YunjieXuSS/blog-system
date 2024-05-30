<script>
  export let article;
  import dayjs from "dayjs";
  import { SERVER_URL } from "../js/apiUrls.js";
  import { onMount } from "svelte";
  import { browser } from "$app/environment";

  let imageLoaded = true;
  function handleImageError(event) {
    imageLoaded = false;
  }

  onMount(() => {
    const img = new Image();
    img.src = SERVER_URL + article.imgUrl;
    img.onerror = () => {
      handleImageError();
    };
  });

  function stripHtml(html) {
    if (browser) {
      const doc = new DOMParser().parseFromString(html, "text/html");
      return doc.body.textContent || "";
    }
  }
</script>

<article class="article-container">
  {#if imageLoaded}
  <div class="image-container">
    <img src={SERVER_URL + article.imgUrl} alt="" class="article-image" />
</div>
{/if}
  <h1 class="article-title">{article.title}</h1>
  <div class="authorInfo">
  <p class="user"><strong>@ </strong>{article.userName}</p>
  <p class="date">{dayjs(article.createDate).format("YYYY-MM-DD hh:mm:ss")}</p>
</div>
  <p class="article-content">{stripHtml(article.content)}</p>
</article>

<style>
  .article-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 800px;
    margin: auto;
    padding: 20px 20px 0;
    background-color: #fff;
    box-sizing: border-box; /* Ensure padding is included in the width */
  }

  .image-container {
    width: 400px; 
    height: 300px; 
    overflow: hidden; 
    position: relative;
}

  .article-image {
    width: 100%;
    margin-bottom: 5px;
    object-fit: cover; 
    object-position: center; 
  }

  .article-title {
    font-size: 1.5em;
    margin-bottom: 5px;
    text-align: center;
  }

  .authorInfo{
    display: flex;
    flex-direction: row;
    margin:0;
    width: 100%;
    justify-content: center;
    align-items: center;
    padding: 0;
  }

  .user {
    font-size: 1em;
    color: #555;
    margin-right: 20px;
  }

  .date {
    font-size: 0.8em;
    font-style: italic;
    color: #999;
  }

  .article-content {
    font-size: 1.2em;
    line-height: 1.6;
    color: #333;
    text-align: justify;
    width: 100%;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 7; /* numbed of lines */
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: 1.5;
    max-height: calc(1.5em * 7); /* calculate from line-height */
  }
</style>
