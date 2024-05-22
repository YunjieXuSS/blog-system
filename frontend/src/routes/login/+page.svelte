<script>
  /** ---routes/login/+page.svelte
   * It is a svelte file that contains the login page.
   * API: POST /api/users/login if the user login successfully, then the user will be redirected to the home page.
   **/
  import Login from '$lib/components/Login.svelte';
  import SignUpSection from "$lib/components/SignUpSection.svelte";
</script>

<Login />

<SignUpSection />