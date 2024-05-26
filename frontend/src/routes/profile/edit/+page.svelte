<script>
  import { onMount } from "svelte";
  import UpdateUserPage from "../../../lib/components/UpdateUserPage.svelte";
  import { goto } from "$app/navigation";
  export let data;
  console.log("data", data);
  onMount(() => {
    if(!data.user) {
        goto("/login", { replace: true });
    }
  });
</script>
{#if data.user}
<UpdateUserPage user = {data.user} /> 
{/if}