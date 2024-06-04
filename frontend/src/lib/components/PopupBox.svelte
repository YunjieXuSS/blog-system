<script>
  import { goto } from "$app/navigation";
  import ButtonText from "$lib/components/ButtonText.svelte";

  export let popupMessage = "Mission Completed!";
  export let redirectUrl = "/";
  export let countdown = 5;
  export let showPopupBox = false;

  let countdownTime;
  let nIntervId = null;
  let nTimeoutId = null;

  function handlecountdown() {
    countdownTime -= 1;
    if (countdownTime <= 0) {
      countdownTime = countdown;
      clearInterval(nIntervId);
      closePopupBox();
    }
  }

  function closePopupBox() {
    showPopupBox = false;
    clearInterval(nIntervId);
    clearTimeout(nTimeoutId);
    goto(redirectUrl, { replaceState: true, invalidateAll: true });
  }

  $: if (showPopupBox) {
    countdownTime = countdown;
    if (nIntervId) {
      clearInterval(nIntervId);
    }
    if (nTimeoutId) {
      clearTimeout(nTimeoutId);
    }
    nIntervId = setInterval(handlecountdown, 1000);
    nTimeoutId = setTimeout(() => {
      closePopupBox();
    }, countdown * 1000);
  }
</script>

{#if showPopupBox}
  <div class="container">
    <div class="content_container">
      <p>{popupMessage}</p>
      <div class="countdown_container">{countdownTime}</div>
      <ButtonText buttonFunction={closePopupBox} buttonLabel="OK" buttonClass="cancelButton" />
    </div>
  </div>
{/if}

<style>
  .container {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: #2d2d2dc2;
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .content_container {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 10px #2d2d2d;
    width: 400px;
    height: 150px;
  }

  .countdown_container {
    margin: 0 0 20px 0;
  }
</style>
