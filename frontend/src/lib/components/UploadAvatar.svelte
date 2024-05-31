<script>
  import { PUBLIC_API_BASE_URL, PUBLIC_SERVER_URL } from "$env/static/public";
  import { onMount } from "svelte";
  import { SERVER_URL } from "../js/apiUrls";

  export let filesToUpload = "";
  export let selectedImage = "";

  let messageToSend;

  let serverResponse = null;

  function previewImage(event) {
    const [file] = imgInp.files;
    if (file) {
      userIcon.src = URL.createObjectURL(file);
    } else {
      userIcon.src = "/userDefaultIcon.png";
    }
  }

  onMount(() => {
    selectedImage = "/userDefaultIcon.png";
  });

  $: console.log(selectedImage);
</script>

<form>
  <div class="img-container">
    <!-- <div class="img-bg-container">  -->
    <img id="userIcon" src={selectedImage} alt="userDefaultIcon" />
    <!-- </div> -->
  </div>
  <div class="upload">
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
  </div>
</form>

<style>
  form {
    display: block;
    align-items: center;

    & .img-container {
      max-width: 20em;
      width: 100%;
      height: 100%;
      display: block;
      margin-bottom: 10px;
    }

    & label {
      display: block;
      float: left;
      margin-bottom: 10px;
    }

    & input {
      display: block;
      float: left;
      margin: 0 0 10px 0;
    }
  }

  #imgInp {
    width: 13.5em;
  }

  #userIcon {
    display: flex;
    justify-content: center;
    width: 100%;
    margin: 0;
    display: block;
    border-radius: 50%;
  }

  .upload {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 20px 0 40px 0;
  }

  @media (max-width: 800px) {
    #userIcon {
      display: flex;
      justify-content: center;
      width: 250px;
      height: 250px;

      margin: 0 auto;
      display: block;
    }
  }
</style>
