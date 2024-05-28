<script>
  // ---/routes/signup/+page.svelte
  // It is a svelte file that contains the signup page.
  // API: POST /api/upload if the user wants to upload a profile picture, please note that this API must be requested first, then pass the response image URL to the API below (register API).
  // API: POST /api/users/register
  // API: POST /api/users/login if the user signup successfully, then the user will be redirected to the home page.

  import SignUpPage from "../../lib/components/SignUpPage.svelte";
</script>

<div class="signup">
  <SignUpPage />
</div>

<style>
  .signup {
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
