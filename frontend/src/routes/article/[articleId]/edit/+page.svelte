<script>
  import ArticleEditor from "$lib/components/ArticleEditor.svelte";
  export let data;
</script>

<main>
  <div class="edit-container">
    <ArticleEditor article={data.article} />
  </div>
</main>

<style>
  .edit-container {
    margin: 24px auto;
  }
</style>
