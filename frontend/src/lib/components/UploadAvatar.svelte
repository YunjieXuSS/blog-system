<script>
  export let filesToUpload = "";
  export let selectedImage = "";
  export let isSelectedDefaultImg = true;
  export let imgInput;

  export let isImgSizeLarge = false;
  let warnMessage = "";
  export let imageIsLegal = false;

  $: {
    if (filesToUpload && filesToUpload.length > 0) {
      isImgSizeLarge = filesToUpload[0].size > 2097152 ? true : false;
      const [file] = imgInp.files;
      selectedImage =
        filesToUpload.length > 0 ? URL.createObjectURL(file) : "/images/userDefaultIcon1.png";
      warnMessage = isImgSizeLarge
        ? "The image size is Larger than 2MB. Please choose a smaller image."
        : "The image size is right.";
      isSelectedDefaultImg = false;
    } else {
      selectedImage = "/images/userDefaultIcon1.png";
      isImgSizeLarge = false;
    }
  }

  $: imageIsLegal =
    (!isImgSizeLarge && filesToUpload.length > 0) ||
    (!isImgSizeLarge && filesToUpload.length < 1 && isSelectedDefaultImg == true);
  $: filesToUpload.length > 0 ? (isSelectedDefaultImg = false) : (isSelectedDefaultImg = true);
  $: isSelectedDefaultImg ? (warnMessage = "The image size should be less than 2MB") : "";
  $: imageIsLegal ? "": (warnMessage = "The image size is Larger than 2MB. Please choose a smaller image.") ;
</script>

<form>
  <div class="img-container">
    <!-- <div class="img-bg-container">  -->
    <img id="userIcon" src={selectedImage} alt="userDefaultIcon" />
    <!-- </div> -->
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
    padding-top: 45px;

    & .img-container {
      max-width: 18em;
      width: 100%;
      height: 18em;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 10px;
      background-color: rgb(155, 155, 155);
      border-radius: 50%;
      overflow: hidden;
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
    border-radius: 50%;
  }

  .LargePicWarn {
    white-space: normal;
    width: 100%;
  }
  .active {
    color: red;
  }

  @media (max-width: 600px) {
    #userIcon {
      display: flex;
      justify-content: center;
      width: 250px;
      height: 250px;

      margin: 0 auto;
      display: block;
    }
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
