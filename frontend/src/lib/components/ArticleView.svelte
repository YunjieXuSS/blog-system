<script>
  export let articleDetail;
  import dayjs from "dayjs";
  import { SERVER_URL } from "../js/apiUrls.js";

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
  <img
    src={SERVER_URL + articleDetail.imgUrl}
    alt=""
    class="article-image"
    on:error={(e) => {
      e.target.style.display = "none";
    }}
  />
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
    box-sizing: border-box; /* Ensure padding is included in the width */
    margin-bottom:10px;
  }

  .article-image {
    width: 500px;
    margin-bottom: 5px;
  }

  @media (max-width: 600px) {
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
    flex-direction: row;
    margin: 0;
    width: 100%;
    justify-content: flex-end;
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
    /* display: -webkit-box;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
      line-height: 1.5;
      max-height: calc(1.5em * 7);  */
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
</style>
