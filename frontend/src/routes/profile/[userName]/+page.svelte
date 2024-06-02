<!-- // ---/routes/profile/[userName]/+page.svelte
// display personal blog page: profile and articles
// API: PATCH /api/users/:userId -->

<script>
  import UserInfo from "$lib/components/UserInfo.svelte";
  import ArticleList from "$lib/components/ArticleList.svelte";
  import PostArticleButton from "$lib/components/PostArticleButton.svelte";

  export let data;
</script>

<div class="profileDiv">
  <UserInfo {data} />
  <ArticleList {data} articles={data.articlesOfUser} />
  <PostArticleButton {data} />
</div>

<style>
  .profileDiv {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
</style>
