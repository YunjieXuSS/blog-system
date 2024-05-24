<script>
  import { PUBLIC_API_BASE_URL, PUBLIC_SERVER_URL } from "$env/static/public";

  export let filesToUpload;
  let messageToSend;

  let serverResponse = null;

  /**
   * Handles form submission. Packages up the fi
   * @param {SubmitEvent & { currentTarget: EventTarget & HTMLFormElement; } e the form submit event
   */
 
</script>

<!-- A form -->
<form >
  <label for="imageFile">File to upload:</label>
  <input
    type="file"
    multiple={false}
    name="image-file"
    accept="image/png, image/jpeg"
    bind:files={filesToUpload}
    required
  />
  <!-- <label for="message">Message:</label>
  <input type="text" name="message" bind:value={messageToSend} required />
  <button type="submit">Upload</button> -->
</form>

<h2>Server response</h2>
{#if serverResponse}
  <p><strong>Message:</strong> {serverResponse.message}</p>
  <img src={`${PUBLIC_SERVER_URL}${serverResponse.imageUrl}`} alt={serverResponse.message} />
{:else}
  <p>No response yet 😔</p>
{/if}

<style>
  form {
    display: table;
    text-align:center;
  }
  p {
    display: table-row;
    text-align:center;
  }
  label {
    display: table-row;
    text-align:center;
  }
  input {
    display: table-row;
    text-align:center;
  }
</style>
