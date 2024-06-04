<script>
  import { onMount } from "svelte";
  import UpdateUserInfoPage from "$lib/components/UpdateUserInfo_refator.svelte";
  import { goto } from "$app/navigation";
  export let data;
  onMount(() => {
    // console.log(data.user);
    if (!data.user) {
      goto("/login", { replace: true });
    }
  });
</script>

<div class="update-user-container">
{#if data.user}
  <UpdateUserInfoPage user={data.user} />
{/if}
</div>

<style>
  .update-user-container {
    display: flex;
    justify-content: center;
  }
</style>