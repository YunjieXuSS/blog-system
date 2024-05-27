<script>
  /** ---routes/login/+page.svelte
   * It is a svelte file that contains the login page.
   * API: POST /api/users/login if the user login successfully, then the user will be redirected to the home page.
   **/
  import Login from "$lib/components/Login.svelte";
  import SignUpSection from "$lib/components/SignUpSection.svelte";
</script>

<div class="container">

  <div class="loginDev">
    <Login />
  </div>

  <div class="signupDev">
    <SignUpSection />
  </div>

</div>

<style>
  .container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    margin: 50px 0;
  }
  .loginDev,
  .signupDev {
    display: flex;
    margin: 0;
  }

  @media (max-width: 1035px) {
    .container {
      display: flex;
      flex-direction: column;
    }
  }
</style>
