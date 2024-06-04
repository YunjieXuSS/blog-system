<script>
  import UserInfo from "$lib/components/UserInfo.svelte";
  import ArticleList from "$lib/components/ArticleList.svelte";
  import PostArticleButton from "$lib/components/PostArticleButton.svelte";

  export let data;
  $: userNotFound = JSON.stringify(data.userInfo) === "{}";
</script>

{#if !userNotFound}
  <div class="profileDiv">
    <UserInfo {data} />
    <ArticleList {data} articles={data.articlesOfUser} />
    <PostArticleButton {data} />
  </div>
{:else}
<div class="not-fount-hint">Not found</div>
{/if}

<style>
  .profileDiv {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .not-fount-hint{
    font-size: 2rem;
    margin-top: 20px;
    text-align: center;
  }
</style>
