<!-- Displays the user's information (username, name, avatar, description) on their profile. -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";
  import  {goto} from '$app/navigation';  
  export let data;

  $: isLoggedIn = data.isLoggedIn;
  let loginUser = {};
  $: if (isLoggedIn) {
    loginUser = data.user;
  }
 
  export let avatarURL = "/userDefaultIcon.png";
  export let description =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ullamcorper dapibus leo vitae facilisis. Vestibulum nibh elit, varius a tellus quis, porta cursus lectus. Sed at pellentesque sapien.";

  function settingsButton() {
    goto("/profile/edit/", { replace: true });
  }
  
</script>

<div class="container">
  <div class="settingsAndAvatar">
    <img class="userAvatar" src={avatarURL} alt="User avatar" />

    <div class="settings">
      <ButtonText
        buttonLabel="Settings"
        buttonFunction={settingsButton}
        bckgColour="lightgray"
        txtColour="gray"
        buttonWidth="110px"
      />
    </div>
  </div>

  <div class="profileInfo">
    {#if isLoggedIn}
      <h1>{loginUser.userName}</h1>
      <h3>{loginUser.firstName} {loginUser.lastName}</h3>
      <p>{description}</p>
    {/if}
  </div>


</div>

<style>
  .container {
    margin: 50px 350px;
    border: 1px solid black;
    border-radius: 15px;
    display: flex;
    padding: 50px;
  }

  .settingsAndAvatar {
    align-content: center;
    justify-content: center;
  }

  .userAvatar {
    max-width: 150px;
    width: 100%;
    margin-bottom: 10px;
  }

  .profileInfo {
    display: flex;
    flex-direction: column;
    justify-content: center;
    margin-left: 30px;

    & h1,
    h3 {
      margin: 0 0 10px 0;
    }

    & p {
      margin: 15px 0 0 0;
    }
  }
</style>
