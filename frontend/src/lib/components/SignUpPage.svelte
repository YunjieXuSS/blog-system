<script>
  import UploadAvatar from "$lib/components/UploadAvatar.svelte";
  import SignUpTable from "$lib/components/SignUpTable.svelte";
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { USER_URL } from "$lib/js/apiUrls.js";
  import AvatarChooser from "$lib/components/AvatarChooser.svelte";
  import PopupBox from "$lib/components/PopupBox.svelte";
  import "$lib/css/button.css";

  let firstName, lastName, userName;
  let password;
  let confirmPassword;
  let email;
  let dateOfBirth;
  let description;
  let filesToUpload;
  let selectedImage = "";
  let onMountTriggered = true;
  let imgInput;
  let isSelectedDefaultImg = true;
  let imageIsLegal = false;

  let validationResults = {
    firstName: false,
    lastName: false,
    email: false,
    dateOfBirth: false,
    userName: false,
    password: false,
    confirmPassword: false
  };

  function handleValidation(event) {
    validationResults[event.detail.variableName] = event.detail.validateResult;
  }

  $: allValid = Object.values(validationResults).every(Boolean) && imageIsLegal;

  function createFormData() {
    const userRegisterImage = filesToUpload[0];
    const userRegisterData = {
      firstName,
      lastName,
      email,
      dateOfBirth,
      userName,
      password,
      description,
      avatar: userRegisterImage
    };

    const body = new FormData();
    Object.entries(userRegisterData).forEach(([key, value]) => {
      if (key == "avatar" && filesToUpload.length > 0 && value !== undefined) {
        body.set(key, value);
      } else if (key == "avatar" && value == undefined) {
        body.set(key, `/images${selectedImage.substring(7)}`);
      } else if (key == "") {
      } else {
        body.set(key, value);
      }
    });

    return body;
  }

  async function handleRegister() {
    try {
      const body = createFormData();
      const response = await fetch(`${USER_URL}/register`, {
        method: "POST",
        credentials: "include",
        body
      });

      if (response.status === 201) {
        handlePopupBox();
      } else if (response.status === 413) {
        handleImagePopupBox();
        imgInput.value = "";
      } else if (response.status === 409) {
        handleUserExistPopupBox();
        imgInput.value = "";
      } else {
        handleUniPopupBox();
      }
    } catch (error) {
      console.error(`Failed to register user.${error}`);
    }
  }

  let showPopupBox = false;
  let popupMessage = "Mission Completed!";
  let redirectUrl = "/";

  function handlePopupBox() {
    popupMessage = `User has registered. Redirecting ...`;
    redirectUrl = "/";
    showPopupBox = true;
  }

  function handleUniPopupBox() {
    popupMessage = `Fail to regiser user. please try it again ...`;
    redirectUrl = "/signup";
    showPopupBox = true;
  }

  function handleUserExistPopupBox() {
    popupMessage = `Username has existed. Please choose a new name ...`;
    redirectUrl = "/signup";
    showPopupBox = true;
  }

  function handleImagePopupBox() {
    popupMessage = "The image size is Larger than 2MB. Please choose a smaller image.";
    redirectUrl = "/signup";
    imageIsLegal = false;
    showPopupBox = true;
  }

  function handleSelectDefaultImg() {
    imgInput.value = "";
    isSelectedDefaultImg = true;
  }
</script>

<div class="page-container">
  <div class="page-title"><h2>Create account</h2></div>
  <div class="content-container">
    <div class="avatar-container">
      <UploadAvatar
        bind:filesToUpload
        bind:selectedImage
        bind:imgInput
        bind:isSelectedDefaultImg
        bind:imageIsLegal
      />
      <AvatarChooser
        bind:selectedImage
        {onMountTriggered}
        on:selectedImage={handleSelectDefaultImg}
      />
    </div>
    <div>
      <SignUpTable
        bind:firstName
        bind:lastName
        bind:email
        bind:dateOfBirth
        bind:userName
        bind:password
        bind:description
        bind:confirmPassword
        on:validation={handleValidation}
      />
    </div>
  </div>

  <ButtonText
    buttonFunction={handleRegister}
    buttonLabel="Sign up"
    buttonClass="confirmButton"
    buttonDisabled={!allValid}
  />
</div>

<PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox />

<style>
  .page-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 50px 0;
    padding: 50px 0;
    width: 60em;
    gap: 30px;
    color: #505050;
    background-color: white;
    box-shadow: 0 4px 8px 0 rgba(4, 0, 37, 0.2), 0 6px 20px 0 rgba(39, 15, 118, 0.19);

    & .page-title {
      & h2 {
        font-size: 3em;
        font-weight: 800;
        margin: 0;
      }
    }

    & > .content-container {
      display: flex;
      align-content: center;
      gap: 30px;

      & > .avatar-container {
        width: 20em;
        margin: 1em 0;
        padding: 40px 20px;
        background-color: #f0f8ffa9;
      }
    }
  }

  @media (max-width: 1000px) {
    .page-container {
      width: 48em;
    }
  }

  @media (max-width: 800px) {
    .page-container {
      width: 30em;
    }

    .content-container {
      display: flex;
      flex-direction: column;
      gap: 0;
    }
  }
</style>
