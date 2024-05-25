<script>
  import { PUBLIC_API_BASE_URL, PUBLIC_SERVER_URL } from "$env/static/public";

  export let filesToUpload = "";
  let messageToSend;

  let serverResponse = null;

  // function readURL(input) {
  //   console.log("input", input);
  //   if (input.files && input.files[0]) {
  //     var reader = new FileReader();

  //     reader.onload = function (e) {
  //       ("#userIcon").attr("src", e.target.result).width(150).height(200);
  //     };

  //     reader.readAsDataURL(input.files[0]);
  //   }
  // }

  function previewImage(event) {
    const [file] = imgInp.files;
    if (file) {
      userIcon.src = URL.createObjectURL(file);
    } else {
      userIcon.src = "userDefaultIcon.png";
    }
  }
</script>

<!-- A form -->
<form>
  <div class="img-container">
    <div class="img-bg-container"> 
      <img id="userIcon" src="userDefaultIcon.png" alt="userDefaultIcon" />   
    </div>
  
  </div>
  <label for="imageFile">Choose a PNG or JPG to upload:</label>
  <input
    id="imgInp"
    type="file"
    multiple={false}
    name="image-file"
    accept="image/png, image/jpeg"
    bind:files={filesToUpload}
    on:change={previewImage}
    required
  />
  <!-- <label for="message">Message:</label>
  <input type="text" name="message" bind:value={messageToSend} required />
  <button type="submit">Upload</button> -->
</form>

<!-- Test code -->
<!-- <h2>Server response</h2>
{#if serverResponse}
  <p><strong>Message:</strong> {serverResponse.message}</p>
  <img src={`${PUBLIC_SERVER_URL}${serverResponse.imageUrl}`} alt={serverResponse.message} />
{:else}
  <p>No response yet 😔</p>
{/if} -->

<style>
  form {
    display: block;
    align-items: center;
    padding-left: 50x;
    padding-top: 45px;

    & .img-container {
      
      width: 100%;
      height: 100%;
      display: block;
      margin-bottom: 10px;

      & .img-bg-container {
        width: 300px;
        height: 300px;
        background-color: rgb(155, 155, 155);
        display: flex;
        justify-items: center;
        align-items: center;
        margin: 0 auto;
        margin-bottom: 10px;
        border-radius: 10px;
      }

      & #userIcon {
        width: 95%;
        height: 95%;
        margin: 0 auto;
        display: block;
      }
    }

    & label {
      display: block;
      float: left;
      margin-bottom: 10px;
      margin-left: 20%;
    }
    & input {
      display: block;
      float: left;
      margin-bottom: 10px;
      margin-left: 20%;
    }
  }
</style>
