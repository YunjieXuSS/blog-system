<script>
  import Comments from "./../../../lib/components/Comments.svelte";
  export let data;
  const { article } = data;
  const { userId } = article;
</script>

<main>
  <section class="article">// implement article component here</section>
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
