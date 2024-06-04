<script>
  import ArticleEditor from "$lib/components/ArticleEditor.svelte";
  import { onMount } from "svelte";
  import { goto } from "$app/navigation";

  export let data;

  onMount(async () => {
    if (!data.isLoggedIn) {
      goto("/login");
    } else if (data.article.userId !== data.user.userId) {
      goto(`/article/${data.article.articleId}`);
    }
  });
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
