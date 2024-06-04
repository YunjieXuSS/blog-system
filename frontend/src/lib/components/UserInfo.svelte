<!-- Displays the user's information (username, name, avatar, description) on their profile. -->

<script>
  import { goto } from "$app/navigation";
  import { SERVER_URL } from "../js/apiUrls";
  import { browser } from "$app/environment";
  import ButtonText from "$lib/components/ButtonText.svelte";
  import "$lib/css/button.css";

  export let data;

  let hoster = {};
$: hoster = data.userInfo;

  $: avatarUrl = SERVER_URL + hoster.avatar;
  function settingsButton() {
    goto("/profile/edit/", { replaceState: true });
  }

  $: showSettings = hoster.userId === data?.user?.userId;
</script>

<div class="container">
  <div class="settingsAndAvatar">
    {#if browser}
      <img
        class="userAvatar"
        src={avatarUrl}
        alt="User avatar"
        on:error={(e) => {
          e.target.src = "/userDefaultIcon.png";
        }}
      />
    {/if}

    <div class="settings">
      {#if showSettings}
        <ButtonText
          buttonLabel="Settings"
          buttonFunction={settingsButton}
          buttonClass="cancelButton"
        />
      {/if}
    </div>
  </div>

  <div class="profileInfo">
    <h1>{hoster.userName}</h1>
    <h3>{hoster.firstName} {hoster.lastName}</h3>
    <p>{hoster.description}</p>

    <div class="userDetailContainer">
      <div class="userDetail">
        <span><strong>{hoster.numOfLikes}</strong></span>
        <span>Likes</span>
      </div>

      <div class="userDetail">
        <span><strong>{hoster.numOfPosts}</strong></span>
        <span>Posts</span>
      </div>
    </div>
  </div>
</div>

<style>
  .container {
    display: flex;
    justify-content: center;
    margin: 100px 0 50px 0;
    padding: 50px;
    border-radius: 10px;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);
    background-color: white;
    max-width: 60em;
    gap: 30px;
  }

  .settingsAndAvatar {
    min-width: 9.3em;
    align-content: center;
    justify-content: center;
  }

  .settings {
    display: flex;
    justify-content: center;
  }

  .userAvatar {
    width: 150px;
    height: 150px;
    margin-bottom: 10px;
    border-radius: 50%;
    object-fit: cover;
  }

  .profileInfo {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding-right: 20px;
  }

  .profileInfo > h1,
  h3 {
    margin: 0 0 10px 0;
  }

  .profileInfo > p {
    margin: 15px 0 0 0;
  }

  .userDetailContainer {
    margin-top: 40px;
    display: flex;
    justify-content: left;
    gap: 100px;
  }

  .userDetail {
    text-align: center;
    display: flex;
    flex-direction: column;
    width: 40px;
  }

  span {
    max-width: 200px;
  }

  @media (max-width: 1200px) {
    .container {
      max-width: 40em;
    }
  }

  @media (max-width: 790px) {
    .container {
      max-width: 25em;
      width: 100%;
      padding: 20px;
      box-sizing: border-box;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      gap: 0;
    }

    .profileInfo {
      padding-right: 0;
    }

    .profileInfo > h1,
    h3,
    p {
      text-align: center;
    }

    .userDetailContainer {
      gap: 50px;
      margin-bottom: 30px;
      justify-content: center;
    }

    .settings {
      margin-bottom: 40px;
    }

    .userAvatar {
      margin-top: 30px;
    }
  }
</style>
