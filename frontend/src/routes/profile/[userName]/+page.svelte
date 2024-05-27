<!-- // ---/routes/profile/[userName]/+page.svelte
// display personal blog page: profile and articles
// API: PATCH /api/users/:userId -->

<script>
    import UserInfo from "$lib/components/UserInfo.svelte";
</script>

<div class="profileDiv">
    <UserInfo />
</div>

<style>
    .profileDiv {
        display: flex;
        justify-content: center;
    }
</style>