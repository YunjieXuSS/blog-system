<!-- // ---/routes/profile/[userName]/+page.svelte
// display personal blog page: profile and articles
// API: PATCH /api/users/:userId -->

<script>
  import UserInfo from "$lib/components/UserInfo.svelte";
  import ArticleList from "$lib/components/ArticleList.svelte";

  export let data;
  $: console.log("data", data.articlesOfUser);
</script>

<UserInfo {data} />
<ArticleList articles={data.articlesOfUser} />
