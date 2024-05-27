<!-- Displays the user's information (username, name, avatar, description) on their profile. -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";

  export let userName = "@john-smith";
  export let firstName = "John";
  export let lastName = "Smith";
  export let avatarURL = "/userDefaultIcon.png";
  export let description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ullamcorper dapibus leo vitae facilisis. Vestibulum nibh elit, varius a tellus quis, porta cursus lectus. Sed at pellentesque sapien.";
  //   export let data;

  function settingsButton() {
    window.location = "/users/";
  }
</script>

  <div class="container">
    <div class="settingsAndAvatar">

      <img class ="userAvatar" src={avatarURL} alt="User avatar" />

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
      <h1>{userName}</h1>
      <h3>{firstName} {lastName}</h3>
      <p>{description}</p>
    </div>

  </div>

<style>
  .container {
    display: flex;
    margin: 50px;
    padding: 50px;
    border-radius: 10px;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);
    max-width: 800px;
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

    & h1, h3 {
        margin: 0 0 10px 0;
    }

    & p {
        margin: 15px 0 0 0;
    }
  }

</style>
