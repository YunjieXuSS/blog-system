<script>
  import UpdateUserTable from "./UpdateUserTable.svelte";
  import UploadAvatar from "./UploadAvatar.svelte";
  import Dayjs from "dayjs";
  import { SERVER_URL, USER_URL } from "../js/apiUrls.js";
  import AvatarChooser from "./AvatarChooser.svelte";
  import PopupBox from "./PopupBox.svelte";
  import ConfirmPopupBox from "./ConfirmPopupBox.svelte";
  import { page } from "$app/stores";
  import { onMount } from "svelte";
  $: path = $page.url.pathname;

  export let user;
  let firstName = user.firstName;
  let lastName = user.lastName;
  let userName = user.userName;
  let password;
  let confirmPassword;
  let email = user.email;
  let dateOfBirth = Dayjs(user.dateOfBirth).format("YYYY-MM-DD");
  let description = user.description;
  let filesToUpload = [];
  let avatar = user.avatar;
  let selectedImage = user.avatar;
  $: console.log("avatar ", avatar);
  $: console.log("selectedImage ", selectedImage);

  let onMountTriggered = false;
  let userIconURL = `${SERVER_URL}${avatar}`;
  let showPopupBox = false;
  let popupMessage = "Mission Completed!";
  let ConfirmPopupMessage = "";
  let redirectUrl = "/";
  let showConfirmPopupBox = false;
  let confirmFunction = () => {};
  let imgInput;
  let isSelectedDefaultImg = true;
  let imageIsLegal = false;

  // define a function to get the first password.
  const getPassword = function () {
    return password;
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

  $: console.log("selectedImage- update userinfo ", selectedImage);

  function handleValidation(event) {
    //create a new array to store the validation results
    validationResults[event.detail.variableName] = event.detail.validateResult;
    console.log("event.detail.label", event.detail.label);
    console.log("event.detail.validateResult", event.detail.validateResult);
    console.log("validationResults", validationResults);
  }
  $: console.log("validationResults", validationResults);

  //check if all the values are valid
  //add a new property to the object to store the result
  //Object.values(validationResults) means put all the values of the object into an array
  //every(Boolean) means check if all the values are true
  $: allValid = Object.values(validationResults).every(Boolean) && imageIsLegal & passwordMatch;
  $: passwordMatch = password == confirmPassword;
  $: {
    console.log("password", password);
  }
  $: {
    console.log("confirmPassword)", confirmPassword);
  }
  $: {
    console.log("passwordMatch)", passwordMatch);
  }

  $:selectedImage=selectedImage

  $: {
    if (selectedImage) {
      filesToUpload = [];
    }
  }

  $:console.log("Update User info page selectedImage outside", selectedImage);

  $: userUpdateImage = filesToUpload[0]||selectedImage;
  $: avatar =
    userUpdateImage || (selectedImage ? `/images${selectedImage.substring(7)}` : user.avatar);
  $: validationResults["imageIsLegal"] = imageIsLegal ? true : false;



  $:console.log("Update User info page userUpdateImage outside", userUpdateImage);
  function createFormData() {
    const userRegisterImage = filesToUpload[0];
    const userUpdateData = {
      firstName,
      lastName,
      email,
      dateOfBirth,
      userName,
      password,
      description,
      avatar: userRegisterImage
    };
    
    //refactor the code to use the createAccount function
    // Create a FormData object to send, rather than sending JSON as usual.
    const body = new FormData();
    console.log("userUpdateData avatar ", userUpdateData.avatar);
    console.log("userUpdateData", userUpdateData);
    console.log("Update User info page userUpdateImage inside", userUpdateImage);
    Object.keys(userUpdateData).forEach((key) => {
      if (userUpdateData[key] !== undefined && userUpdateData[key] !== user[key]) {
        if (key === "password" && userUpdateData[key] !== "") {
          body.set(key, userUpdateData[key]);
        } else if (key === "avatar") {
          body.set(key, userUpdateImage || userUpdateData[key]);
        } else if (userUpdateData[key]) {
          body.set(key, userUpdateData[key]);
        }
      }
    });


    return body;
  }

  // async function handleUpdate(
  //   firstName,
  //   lastName,
  //   email,
  //   dateOfBirth,
  //   userName,
  //   password,
  //   description,
  //   avatar
  // ) {
  //   const userUpdateData = {
  //     firstName,
  //     lastName,
  //     email,
  //     dateOfBirth,
  //     userName,
  //     password,
  //     description,
  //     avatar
  //   };

  //   // const userRegisterImage =events.target.files[0];
  //   // Create a FormData object to send, rather than sending JSON as usual.

  //   console.log(userUpdateImage, selectedImage, userUpdateData.avatar, user.avatar);
  //   const formData = new FormData();
  //   Object.keys(userUpdateData).forEach((key) => {
  //     if (userUpdateData[key] !== undefined && userUpdateData[key] !== user[key]) {
  //       if (key === "password" && userUpdateData[key] !== "") {
  //         formData.append(key, userUpdateData[key]);
  //       } else if (key === "avatar") {
  //         formData.append("avatar", userUpdateImage || userUpdateData[key]);
  //       } else if (userUpdateData[key]) {
  //         formData.append(key, userUpdateData[key]);
  //       }
  //     }
  //   });

  // AVATAR is not update!!!!!!!t

  // We can send a FormData object directly in the body. Send a POST to our API route, with this data.
  // REMEMBER that this is not JSON we're sending - we're sending multipart form data which is handled
  // by the multer middleware on our server.

  async function handleUpdate() {
    const body = createFormData();
    const response = await fetch(USER_URL, {
      method: "PATCH",
      credentials: "include",
      body
    });

    if (response.status === 200) {
      // Redirect to the login page if successful.
      handleUpdatePopupBox();
    } else if (response.status === 413) {
      handleImagePopupBox();
      imgInput.value = "";
    } else {
      // If there was an error, log the error to the console.
      popupMessage = `Update failed. Please try again.`;
      showPopupBox = true;
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
        } else if (response.status === 404) {
          handleFailDeletePopupBox();
        } else {
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

  onMount(() => {
    allValid = false;
  });
</script>

<div class="page-container">
  <div class="page-title"><h2>Edit Account</h2></div>
  <div class="content-container">
    <div class="avatar-container">
      <!-- <UpdateAvatar bind:filesToUpload userIconURL={"localhost:3000/images/img2.jpg"}/> -->
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
        bind:confirmPassword
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
        filesToUpload,
        avatar
      )}
      disabled={!allValid}
    >
      Confirm Edit
    </button>
  </div>
</div>

<PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox />
<ConfirmPopupBox {ConfirmPopupMessage} {confirmFunction} bind:showConfirmPopupBox />

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
      cursor: not-allowed;
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
