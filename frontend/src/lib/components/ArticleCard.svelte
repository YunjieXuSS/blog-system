<script>
  export let article;
  import dayjs from "dayjs";
</script>

<article class="article-container">
  {#if article.isImgExist === true}
    <img src={`http://localhost:3000/images/${article.imgUrl}`} alt="" class="article-image" />
  {/if}
  <h1 class="article-title">{article.title}</h1>
  <p class="user"><strong>@Author: </strong>{article.userName}</p>
  <p class="date">{dayjs(article.createDate).format("YYYY-MM-DD hh:mm:ss")}</p>
  <p class="article-content">{article.content}</p>
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
    height: 150px;
    width: 200px;
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
    margin-bottom: 5px;
  }

  .date {
    font-size: 0.9em;
    font-style: italic;
    color: #999;
    margin-bottom: 10px;
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
