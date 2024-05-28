<script>
  import { onMount } from "svelte";
  import { goto } from "$app/navigation";
  import { page } from "$app/stores";
  import PopupBox from "./PopupBox.svelte";
  export let popupMessage = "Mission Completed!";
  export let redirectUrl = "/";
  export let resultMsg = "Redirecting to homepage...";
  let showPopupBox = false;
  $: path = $page.url.pathname;

  export let confirmFunction = () => {};

  export let showConfirmPopupBox = true;

  function confirmAction() {
    confirmFunction();
    handlePopupBox(resultMsg);
  }

  function closePopupBox() {
    showConfirmPopupBox = false;
    goto(path, { replaceState: true, invalidateAll: true });
  }

  function cancelAction() {
    closePopupBox();
  }

  function handlePopupBox(resultMsg) {
    popupMessage = resultMsg;
    redirectUrl = "/";
    showPopupBox = true;
  }
</script>

{#if showConfirmPopupBox}
  <div class="container">
    <div class="content_container">
      <p>{popupMessage}</p>
      <div class="buttonDiv">
        <button class="cancelButton" on:click={cancelAction}>Cancel</button>
        <button on:click={confirmAction}>Confirm</button>
      </div>
    </div>
  </div>
{/if}

{#if showPopupBox}
  <PopupBox {popupMessage} {redirectUrl} />
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
  }
  .content_container {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 10px #2d2d2d;
    text-align: center;
    width: 400px;
    height: 130px;

    & .buttonDiv {
      display: flex;
      justify-content: center;
      gap: 30px;
    }
  }
  .content_container button {
    margin-top: 20px;
    padding: 10px 20px;
    border: none;
    background-color: rgb(183, 2, 2);
    color: white;
    border-radius: 5px;
    cursor: pointer;
    height: 40px;
    width: 100px;
  }

  .content_container .cancelButton {
    background-color: #268600;
  }

  .content_container button:hover {
    background-color: #0056b3;
  }
</style>
