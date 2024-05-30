<script>
  import { onMount } from "svelte";
  import UpdateUserPage from "../../../lib/components/UpdateUserPage.svelte";
  import UpdateUserInfoPage from "../../../lib/components/UpdateUserInfoPage.svelte";
  import { goto } from "$app/navigation";
  export let data;
  onMount(() => {
    console.log(data.user);
    if (!data.user) {
      goto("/login", { replace: true });
    }
  });
</script>

{#if data.user}
  <UpdateUserInfoPage user={data.user} />
{/if}
