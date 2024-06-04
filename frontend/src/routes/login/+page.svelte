<script>
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
    margin: 50px auto;
  }

  .loginDev,
  .signupDev {
    display: flex;
    margin: 0;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);
  }

  @media (max-width: 1035px) {
    .container {
      display: flex;
      flex-direction: column;
      box-shadow: none;
    }
  }
</style>
