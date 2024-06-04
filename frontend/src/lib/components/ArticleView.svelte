<script>
  export let articleDetail;
  import dayjs from "dayjs";
  import { SERVER_URL } from "$lib/js/apiUrls.js";
  import { browser } from "$app/environment";

  function goToAuthorPage() {
    window.location.href = "/profile/" + articleDetail.userName;
  }
</script>

<article class="article-container">
  <h1 class="article-title">{articleDetail.title}</h1>
  <div class="authorInfo">
    <button class="author-button" on:click={goToAuthorPage}
      ><p class="user"><strong>@</strong>{articleDetail.userName}</p></button
    >
    <p class="date">{dayjs(articleDetail.createDate).format("YYYY-MM-DD hh:mm:ss")}</p>
  </div>
  {#if browser}
    <img
      src={SERVER_URL + articleDetail.imgUrl}
      alt=""
      class="article-image"
      on:error={(e) => {
        e.target.style.display = "none";
      }}
    />{/if}
  <p class="article-content">{@html articleDetail.content}</p>
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
    box-sizing: border-box;
    margin-bottom: 10px;
  }

  .article-image {
    width: 500px;
    margin-bottom: 5px;
  }

  @media (max-width: 700px) {
    .article-image {
      width: 100%;
    }
  }

  .article-title {
    font-size: 2em;
    margin-bottom: 5px;
    text-align: center;
  }

  .authorInfo {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 0;
    padding: 0;
    width: 100%;
  }

  .user {
    font-size: 1em;
    color: #555;
    margin-right: 20px;
    display: flex;
  }

  .date {
    font-size: 0.8em;
    font-style: italic;
    color: #999;
    margin: 0 0 40px 0;
  }

  .article-content {
    font-size: 1.2em;
    line-height: 1.6;
    color: #333;
    text-align: justify;
    width: 100%;
  }

  .author-button {
    text-decoration: none;
    background-color: transparent;
    border: none;
    &:hover {
      cursor: pointer;
      text-decoration: underline;
    }
  }

  .author-button > p {
    text-align: center;
    margin: 0;
  }
</style>
