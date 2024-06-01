<script>
export let article;

// $:console.log(article)
</script>


<div class="pm_each_div">
    <div class="img_div">
      <img src={`/images/${article.imgUrl}`} alt={article.name} />
    </div>
    <div id="articleId">
        <h1>ID: {article.articleId}</h1>
      </div>
    <div class="nameDiv">
      <h1>{article.title}</h1>
    </div>
    <div class="des">
        <p>{article.content}</p>
      </div>
  </div>
  


  <style>
    .pm_each_div {
      background-color: rgb(255, 255, 255);
      width: 550px;
      height: 750px;
      box-shadow: 1px 3px 5px 5px rgba(186, 186, 186, 0.461);
      border-radius: 10px;
    }
    
  
    .img_div {
      background-color: #f4f4f4;
      width: 100%;
    }
    .img_div img {
      display: block;
      width: 456px;
      height: 456px;
      margin: 0 auto;
    }
  
    h1 {
      text-align: left;
      margin: 0px 0px 0px 30px;
      font-size: 40px;
    }
   
  
    .nameDiv {
      position: relative;
    }
  
  
  </style>
  