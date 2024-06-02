<!-- Displays the user's information (username, name, avatar, description) on their profile. -->

<script>
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { goto } from "$app/navigation";
  import { SERVER_URL } from "../js/apiUrls";
  import { browser } from "$app/environment";

  export let data;

  let hoster = {};
  hoster = data.userInfo;

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
          bckgColour="#9EB384"
          txtColour="white"
          buttonWidth="110px"
        />
      {/if}
    </div>
  </div>

  <div class="profileInfo">
    <h1>{hoster.userName}</h1>
    <h3>{hoster.firstName} {hoster.lastName}</h3>
    <p>{hoster.description}</p>
    <div class="user-detail">
      <strong>{hoster.numOfLikes}</strong><strong>{hoster.numOfPosts}</strong><span>Likes</span><span
        >Posts</span
      >
    </div>
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

  @media (max-width: 600px) {
    .container {
      width: 100%;
      padding: 16px;
      flex-wrap: wrap;
      box-sizing: border-box;
    }
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
    height: 150px;
    width: 150px;
    margin-bottom: 10px;
    border-radius: 50%;
    object-fit: cover;
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
  .user-detail {
    margin-top:40px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    text-align: center;
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
