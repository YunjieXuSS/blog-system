<script>
  import { PUBLIC_API_BASE_URL, PUBLIC_SERVER_URL } from "$env/static/public";
  import { onMount } from "svelte";

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
</script>

<form>
  <div class="img-container">
    <!-- <div class="img-bg-container">  -->
    <img id="userIcon" src="userDefaultIcon.png" alt="userDefaultIcon" />
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
    padding-top: 45px;

    & .img-container {
      max-width: 20em;
      width: 100%;
      height: 100%;
      display: block;
      margin-bottom: 10px;

      /* & .img-bg-container {
        width: 300px;
        height: 300px;
        background-color: rgb(155, 155, 155);
        display: flex;
        justify-items: center;
        align-items: center;
        margin: 0;
        margin-bottom: 10px;
        border-radius: 10px;
      } */
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
  }

  .upload {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  @media (max-width: 800px) {
    /* .img-container {
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto;
    } */
  }
</style>
