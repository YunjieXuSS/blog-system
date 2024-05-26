<script>
  import Comments from "./../../../lib/components/Comments.svelte";
  import LikeButton from "./../../../lib/components/LikeButton.svelte";
  export let data;
  const { article } = data;
  const { userId } = article;
</script>

<main>
  <section class="article">// implement article component here</section>

  <LikeButton />
  <Comments authorId={userId} />
</main>

<style>
  main {
    padding: 16px;
    width: 900px;
    margin: 0 auto;
  }

  .article {
    min-height: calc(100vh - 700px);
  }
</style>
