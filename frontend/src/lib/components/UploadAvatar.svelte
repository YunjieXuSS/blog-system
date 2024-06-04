<script>
  import { SERVER_URL } from "../js/apiUrls";
  import { browser } from "$app/environment";
  export let filesToUpload = "";
  export let selectedImage = "";
  export let isSelectedDefaultImg = true;
  export let imgInput;
  let showImage;
  export let isImgSizeLarge = false;
  let warnMessage = "";
  export let imageIsLegal = false;

  $: {
    if (filesToUpload && filesToUpload.length > 0) {
      isImgSizeLarge = filesToUpload[0].size > 2097152 ? true : false;
      const [file] = imgInp.files;
      // userIcon.src = URL.createObjectURL(file);
      showImage = URL.createObjectURL(file);
      selectedImage = "";
      warnMessage = isImgSizeLarge
        ? "The image size is Larger than 2MB. Please choose a smaller image."
        : "The image size is right.";
      isSelectedDefaultImg = false;
    } else {
      showImage = SERVER_URL + selectedImage;
      isImgSizeLarge = false;
    }
  }

  $: {
    if (filesToUpload.length == 0) {
      //default image when the page is loaded
      // selectedImage = "/images/userDefaultIcon2.png";
      isImgSizeLarge = false;
    }
  }

  $: imageIsLegal = (!isImgSizeLarge && filesToUpload.length > 0) || isSelectedDefaultImg == true;
  $: filesToUpload.length > 0 ? (isSelectedDefaultImg = false) : (isSelectedDefaultImg = true);
  $: isSelectedDefaultImg ? (warnMessage = "The image size should be less than 2MB") : "";
  $: imageIsLegal
    ? ""
    : (warnMessage = "The image size is Larger than 2MB. Please choose a smaller image.");
</script>

<form>
  <div class="img-container">
    <div class="img-bg-container">
      {#if browser}
        <img
          id="userIcon"
          src={showImage}
          alt="userDefaultIcon"
          on:error={(e) => {
            e.target.src = "/userDefaultIcon.png";
          }}
        />
      {/if}
    </div>
  </div>
  <div class="upload">
    <label for="imageFile">Choose a PNG or JPG to upload:</label>
    <div>
      <p class="LargePicWarn" class:active={!imageIsLegal}>{warnMessage}</p>
      <div>
        <input
          id="imgInp"
          type="file"
          multiple={false}
          name="image-file"
          accept="image/png, image/jpeg"
          bind:files={filesToUpload}
          bind:this={imgInput}
          required
        />
      </div>
    </div>
  </div>
</form>

<style>
  form {
    display: block;
    align-items: center;

    & .img-container {
      width: 100%;
      height: 100%;
      display: block;
      margin-bottom: 10px;

      & .img-bg-container {
        width: 300px;
        height: 300px;
        background-color: transparent;
        display: flex;
        justify-items: center;
        align-items: center;
        margin: 0 auto;
        margin-bottom: 10px;
        border-radius: 50%;
      }
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
    width: 100%;
    height: 100%;
    margin: 0 auto;
    display: block;
    border-radius: 50%;
    object-fit: cover;
  }

  .LargePicWarn {
    white-space: normal;
    width: 100%;
  }
  .active {
    color: red;
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
