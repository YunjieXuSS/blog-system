<script>
  import UpdateUserTable from "./UpdateUserTable.svelte";
  import UpdateAvatar from "./UpdateAvatar.svelte";
  import {
    validateRegisterUserName,
    validateRegisterPassword,
    validateConfirmPassword,
    validateRegisterEmail,
    validateRegisterDate
  } from "../js/validation.js";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import Dayjs from "dayjs";
  import { SERVER_URL, USER_URL } from "../js/apiUrls.js";
  import AvatarChooser from "./AvatarChooser.svelte";
  import PopupBox from "./PopupBox.svelte";
  import ConfirmPopupBox from "./ConfirmPopupBox.svelte";
  import { page } from "$app/stores";
  $: path = $page.url.pathname;

  export let user;
  let firstName = user.firstName;
  let lastName = user.lastName;
  let userName = user.userName;
  let password;
  let email = user.email;
  let dateOfBirth = Dayjs(user.dateOfBirth).format("YYYY-MM-DD");
  let description = user.description;
  let filesToUpload;
  let avatarURL = user.avatar;
  let selectedImage = "";
  let onMountTriggered = false;
  let userIconURL = `${SERVER_URL}${avatarURL}`;
  let showPopupBox = false;
  let popupMessage = "Mission Completed!";
  let ConfirmPopupMessage = "";
  let redirectUrl = "/";
  let showConfirmPopupBox = false;
  let resultMsg = "";
  let confirmFunction = () => {};

  // define a function to get the first password.
  const getPassword = function () {
    return password;
  };
  // create closure function to validate two passwords.
  const confirmPasswordValidator = validateConfirmPassword(getPassword);

  let validationResults = {
    firstName: true,
    lastName: true,
    email: true,
    dateOfBirth: true,
    userName: true,
    password: true,
    confirmPassword: true
  };

  function handleValidation(event) {
    //create a new array to store the validation results
    validationResults[event.detail.label] = event.detail.validateResult;
  }

  //check if all the values are valid
  //add a new property to the object to store the result
  //Object.values(validationResults) means put all the values of the object into an array
  //every(Boolean) means check if all the values are true
  $: allValid = Object.values(validationResults).every(Boolean);

  async function handleUpdate(
    firstName,
    lastName,
    email,
    dateOfBirth,
    userName,
    password,
    description,
    filesToUpload
  ) {
    const userRegisterData = {
      firstName,
      lastName,
      email,
      dateOfBirth,
      userName,
      password,
      description
    };
    const userRegisterImage = filesToUpload[0];
    // const userRegisterImage =events.target.files[0];
    // Create a FormData object to send, rather than sending JSON as usual.
    const formData = new FormData();

    if (
      userRegisterImage == undefined &&
      selectedImage.substring(16) !== userIconURL.substring(29)
    ) {
      formData.append("avatar", `/images${selectedImage.substring(15)}`);
    } else if (userRegisterImage && filesToUpload.length > 0) {
      formData.append("avatar", userRegisterImage);
    }

    Object.keys(user).forEach((key) => {
      if (key === "userId") return;
      if (userRegisterData[key] !== user[key] && userRegisterData[key] !== undefined) {
        formData.append(key, userRegisterData[key]);
      }
    });

    // We can send a FormData object directly in the body. Send a POST to our API route, with this data.
    // REMEMBER that this is not JSON we're sending - we're sending multipart form data which is handled
    // by the multer middleware on our server.
    const response = await fetch(USER_URL, {
      method: "PATCH",
      credentials: "include",
      body: formData
    });

    if (response.status === 200) {
      // Redirect to the login page if successful.
      handleUpdatePopupBox();
    } else {
      // If there was an error, log the error to the console.
      console.error(`Failed to update user info.${response.status}`);
    }
    const serverResponse = await response.json();
  }

  async function handleDelete() {
    fetch(USER_URL, {
      method: "DELETE",
      credentials: "include"
    })
      .then((response) => {
        if (response.status === 204) {
          handleDeletePopupBox();
        }else if ( response.status === 404) {
          handleFailDeletePopupBox();
        }
        else {
          console.error(`Failed to delete user.${response.error}.Status code:${response.status}`);
        }
      })
      .catch((error) => {
        console.error(`Failed to delete user.${error}`);
      });
  }

  
  function handleUpdatePopupBox() {
    popupMessage = `User has been updated . Redirecting to profile page...`;
    redirectUrl = `/profile/${userName}`;
    showPopupBox = true;
  }
  function handleConfirmPopupBox() {
    ConfirmPopupMessage = `Do you really want to delete this account?`;
    redirectUrl = "/profile/edit";
    showConfirmPopupBox = true;
    confirmFunction = handleDelete;
  }
  function handleDeletePopupBox() {
    popupMessage = `User has been deleted . Redirecting to homepage...`;
    redirectUrl = "/";
    showPopupBox = true;
  }
  function handleFailDeletePopupBox() {
    popupMessage = `User not authorized to delete this account.`;
    redirectUrl = path;
    showPopupBox = true;

  }


</script>

<div class="page-container">
  <div class="page-title"><h2>Edit Account</h2></div>
  <div class="content-container">
    <div class="avatar-container">
      <!-- <UpdateAvatar bind:filesToUpload userIconURL={"localhost:3000/images/img2.jpg"}/> -->
      <UpdateAvatar bind:filesToUpload bind:selectedImage {userIconURL} />
      <AvatarChooser bind:selectedImage {onMountTriggered} />
      <!-- /userDefaultIcon.png -->
    </div>
    <div>
      <UpdateUserTable
        bind:firstName
        bind:lastName
        bind:email
        bind:dateOfBirth
        bind:userName
        bind:password
        bind:description
        on:validation={handleValidation}
        userData={user}
      />
    </div>
  </div>
  <div class="button_div">
    <button class="deleteButton" on:click={handleConfirmPopupBox}> Delete Account </button>

    <button
      class="submitButton"
      class:valid={allValid}
      on:click={handleUpdate(
        firstName,
        lastName,
        email,
        dateOfBirth,
        userName,
        password,
        description,
        filesToUpload
      )}
    >
      Confirm Edit
    </button>
  </div>
</div>


  <PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox/>

  <ConfirmPopupBox
    {ConfirmPopupMessage}
    {resultMsg}
    {redirectUrl}
    {confirmFunction}
    bind:showConfirmPopupBox
  />

<style>
  .page-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;

    & .page-title {
      & > h2 {
        font-size: 2em;
        margin: 5px 0 0 0;
      }
    }

    & > .content-container {
      display: flex;
      flex-direction: row;
      align-content: center;
      gap: 10px;

      & > .avatar-container {
        width: 50%;
      }
      & .table-container {
        width: 48%;
      }
    }

    & .button_div {
      display: flex;
      flex-direction: row;
      align-content: center;
      gap: 50px;
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

    & .deleteButton {
      width: 200px;
      height: 80px;
      margin-top: 20px;
      background-color: rgb(183, 2, 2);
      border-radius: 15px;
      color: white;
      font-size: 1.5em;
    }
  }
</style>
