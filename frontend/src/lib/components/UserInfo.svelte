<!-- Displays the user's information (username, name, avatar, description) on their profile. -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";
  export let data;

  $: isLoggedIn = data.isLoggedIn;
  let loginUser = {};
  $: if (isLoggedIn) {
    loginUser = data.user;
  }

  export let avatarURL = "/userDefaultIcon.png";

  function settingsButton() {
    window.location = "/profile/edit/";
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
      <p>{loginUser.description}</p>
    {/if}
  </div>
</div>

<style>
  .container {
    display: flex;
    justify-content: center;
    margin: 50px;
    padding: 50px;
    border-radius: 10px;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);
    max-width: 50em;
    width: 100%;
    gap: 30px;
  }

  .settingsAndAvatar {
    align-content: center;
    justify-content: center;
  }

  .settings {
    display: flex;
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

    & h1,
    h3 {
      margin: 0 0 10px 0;
    }

    & p {
      margin: 15px 0 0 0;
    }
  }

  @media (max-width: 950px) {
    .container {
      max-width: 35em;
    }
  }

  @media (max-width: 690px) {
    .container {
      max-width: 25em;
    }
  }
</style>
