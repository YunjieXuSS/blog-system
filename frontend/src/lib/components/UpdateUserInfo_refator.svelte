<script>
  import UploadAvatar from "./UploadAvatar.svelte";
  import SignUpTable from "./SignUpTable.svelte";
  import { USER_URL } from "$lib/js/apiUrls.js";
  import AvatarChooser from "./AvatarChooser.svelte";
  import PopupBox from "./PopupBox.svelte";
  import ConfirmPopupBox from "./ConfirmPopupBox.svelte";
  import Dayjs from "dayjs";
  import "$lib/css/button.css";
  import ButtonText from "$lib/components/ButtonText.svelte";

  export let user;

  let firstName = user.firstName;
  let lastName = user.lastName;
  let userName = user.userName;
  let password = "";
  let confirmPassword = "";
  let email = user.email;
  let dateOfBirth = Dayjs(user.dateOfBirth).format("YYYY-MM-DD");
  let description = user.description;
  let filesToUpload = [];
  let selectedImage = user.avatar;
  let onMountTriggered = false;
  let imgInput;
  let isSelectedDefaultImg = true;
  let imageIsLegal = false;
  // let hasChanges;
  let userNamehasChanges = false;
  let isUpdateMode = true;
  let ConfirmPopupMessage = "";
  let showConfirmPopupBox = false;
  let confirmFunction = () => {};

  const originalUserData = {
    firstName: user.firstName,
    lastName: user.lastName,
    userName: user.userName,
    email: user.email,
    dateOfBirth: Dayjs(user.dateOfBirth).format("YYYY-MM-DD"),
    description: user.description,
    avatar: user.avatar
  };

  let validationResults = {
    firstName: true,
    lastName: true,
    email: true,
    dateOfBirth: true,
    userName: true,
    password: true,
    confirmPassword: true,
    imageIsLegal: true
  };

  function handleValidation(event) {
    validationResults[event.detail.variableName] = event.detail.validateResult;
  }

  $: allValid = Object.values(validationResults).every(Boolean);
  $: hasChanges =
    firstName !== originalUserData.firstName ||
    lastName !== originalUserData.lastName ||
    userName !== originalUserData.userName ||
    email !== originalUserData.email ||
    dateOfBirth !== originalUserData.dateOfBirth ||
    description !== originalUserData.description ||
    selectedImage !== originalUserData.avatar ||
    filesToUpload.length > 0 ||
    (password !== "" && confirmPassword !== "");

  $: userNamehasChanges = userName !== originalUserData.userName;
  $: passwordValid = !password || (password && password === confirmPassword);
  $: buttonEnabled = allValid && hasChanges && passwordValid && imageIsLegal;

  function createFormData() {
    const userRegisterImage = filesToUpload[0];
    const userRegisterData = {
      firstName,
      lastName,
      email,
      dateOfBirth,
      userName,
      password: password ? password : undefined,
      description,
      avatar: userRegisterImage
    };

    const body = new FormData();
    Object.entries(userRegisterData).forEach(([key, value]) => {
      if (key === "avatar" && filesToUpload.length > 0 && value !== undefined) {
        body.set(key, value);
      } else if (key === "avatar" && value === undefined) {
        body.set(key, selectedImage);
      } else if (value !== "" && value !== undefined) {
        body.set(key, value);
      }
    });
    return body;
  }

  async function handleUpdate() {
    try {
      const body = createFormData();
      const response = await fetch(USER_URL, {
        method: "PATCH",
        credentials: "include",
        body
      });

      if (response.status === 200) {
        handlePopupBox();
      } else if (response.status === 413) {
        handleImagePopupBox();
        imgInput.value = "";
      } else {
        handleUniPopupBox("delete");
        // console.error(`Failed to update user. StatusCode: ${response.status}`);
      }
    } catch (error) {
      console.error(`Failed to update user. ${error}`);
    }
  }

  async function handleDelete() {
    fetch(USER_URL, {
      method: "DELETE",
      credentials: "include"
    })
      .then((response) => {
        if (response.status === 204) {
          handleDeletePopupBox();
        } else if (response.status === 404) {
          handleFailDeletePopupBox();
        } else {
          // console.error(`Failed to delete user.${response.error}.Status code:${response.status}`);
          handleUniPopupBox("delete");
        }
      })
      .catch((error) => {
        console.error(`Failed to delete user.${error}`);
      });
  }

  let showPopupBox = false;
  let popupMessage = "Mission Completed!";
  let redirectUrl = "/";

  function handlePopupBox() {
    popupMessage = `User info updated. Redirecting to homepage...`;
    console.log(" redirectUrl = `/profile/${userName}`", `/profile/${userName}`);
    redirectUrl = `/profile/${userName}`;
    showPopupBox = true;
  }

  function handleUniPopupBox(operation) {
    popupMessage = `Fail to ${operation} user. please try it later ...`;
    redirectUrl = "/profile/edit";
    showPopupBox = true;
  }

  function handleImagePopupBox() {
    popupMessage = "The image size is Larger than 2MB. Please choose a smaller image.";
    redirectUrl = "/profile/edit";
    imageIsLegal = false;
    showPopupBox = true;
  }

  function handleSelectDefaultImg() {
    imgInput.value = "";
    isSelectedDefaultImg = true;
    selectedImage = selectedImage;
  }

  function handleConfirmPopupBox() {
    ConfirmPopupMessage = `Do you really want to delete this account?`;
    redirectUrl = "/";
    showConfirmPopupBox = true;
    confirmFunction = handleDelete;
  }

  function handleDeletePopupBox() {
    popupMessage = `User has been deleted . Redirecting to homepage...`;
    redirectUrl = "/";
    showPopupBox = true;
  }

  function handleFailDeletePopupBox() {
    popupMessage = `User can not be found. Please contact us by email.`;
    redirectUrl = "/profile/edit/";
    showPopupBox = true;
  }

</script>

<div class="page-container">
  <div class="page-title"><h2>Update Account</h2></div>
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
        bind:confirmPassword
        bind:description
        on:validation={handleValidation}
        bind:isUpdateMode
        bind:userNamehasChanges
      />
    </div>
  </div>
  <div class="button_div">
    <button class="deleteButton" on:click={handleConfirmPopupBox}> Delete Account </button>
    <!-- <button
      class="submitButton"
      class:valid={buttonEnabled}
      on:click={handleUpdate}
      disabled={!buttonEnabled}
    >
      Update Info
    </button> -->

    <!-- <ButtonText
      buttonFunction={handleConfirmPopupBox}
      buttonLabel="Delete Account"
      buttonClass="deleteButton"
    /> -->

    <ButtonText
      buttonFunction={handleUpdate}
      buttonLabel="Update Info"
      buttonClass="confirmButton"
      buttonDisabled={!buttonEnabled}
    />
  </div>
</div>

<PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox />
<ConfirmPopupBox {ConfirmPopupMessage} {confirmFunction} bind:showConfirmPopupBox />

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
      gap: 40px;

      & > .avatar-container {
        width: 20em;
        margin: 0 30px;
      }
    }

    & .submitButton {
      width: 200px;
      height: 80px;
      margin-top: 20px;
      background-color: grey;
      border-radius: 15px;
      color: white;
      font-size: 1.5em;
    }
    & .submitButton.valid {
      background-color: green;
    }
  }

  .button_div {
    display: flex;
    flex-direction: row;
    align-content: center;
    gap: 50px;
  }

  .deleteButton {
    width: 200px;
    height: 80px;
    margin-top: 20px;
    background-color: rgb(183, 2, 2);
    border-radius: 15px;
    color: white;
    font-size: 1.5em;
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

    @media (max-width: 600px) {
      .page-container {
        width: 100%;
      }

      .content-container {
        display: flex;
        flex-direction: column;
        gap: 0;
      }
    }
  }
</style>
