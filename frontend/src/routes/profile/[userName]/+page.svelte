<!-- // ---/routes/profile/[userName]/+page.svelte
// display personal blog page: profile and articles
// API: PATCH /api/users/:userId -->

<script>
  import UserInfo from "$lib/components/UserInfo.svelte";
  import ArticleList from "$lib/components/ArticleList.svelte";

  export let data;
  $: console.log("data", data.articlesOfUser);
</script>

<div class="profileDiv">
  <UserInfo {data} />
  <ArticleList articles={data.articlesOfUser} />
</div>

<style>
  .profileDiv {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
</style>
