<script>
  import AvatarUpload from "./UploadAvatar.svelte";
  import SignUpTable from "./SignUpTable.svelte";
  import ButtonText from "$lib/components/ButtonText.svelte";
  import { createAccount } from "../js/utils.js";
  import {
    validateRegisterUserName,
    validateRegisterPassword,
    validateConfirmPassword,
    validateRegisterEmail,
    validateRegisterDate
  } from "../js/validation.js";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import AvatarChooser from "./AvatarChooser.svelte";
  import PopupBox from "./PopupBox.svelte";

  let firstName, lastName, userName;
  let password;
  let email;
  let dateOfBirth;
  let description;
  let filesToUpload;
  let selectedImage = "";
  let onMountTriggered = false;

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

  async function handleRegister(
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
    formData.append("firstName", firstName);
    formData.append("lastName", lastName);
    formData.append("email", email);
    formData.append("dateOfBirth", dateOfBirth);
    formData.append("userName", userName);
    formData.append("password", password);
    formData.append("description", description);
    if (userRegisterImage && filesToUpload.length > 0 && userRegisterImage !== undefined) {
      formData.append("avatar", userRegisterImage);
    } else {
      //if no image is uploaded, use the default image
      if (selectedImage !== "") {
        formData.append("avatar", `/images${selectedImage.substring(15)}`);
      } else {
        formData.append("avatar", "/images/avatar-default.png");
      }
    }

    // We can send a FormData object directly in the body. Send a POST to our API route, with this data.
    // REMEMBER that this is not JSON we're sending - we're sending multipart form data which is handled
    // by the multer middleware on our server.
    const response = await fetch(`${PUBLIC_API_BASE_URL}/users/register`, {
      method: "POST",
      credentials:"include",
      body: formData
    });

    if (response.status === 201) {
      // Redirect to the login page if successful.
      console.log("User registered successfully.");
      handlePopupBox("registered");
    } else {
      // If there was an error, log the error to the console.
      console.error(`Failed to register user.${response.status}`);
    }

    const serverResponse = await response.json();
  }

  let showPopupBox = false;
  let popupMessage = "Mission Completed!";
  let redirectUrl = "/";
  function handlePopupBox(operation) {
    popupMessage = `User has ${operation} . Redirecting to homepage...`;
    redirectUrl = "/";
    showPopupBox = true;
  }
</script>

<div class="page-container">
  <div class="page-title"><h2>Create account</h2></div>
  <div class="content-container">
    <div class="avatar-container">
      <AvatarUpload bind:filesToUpload bind:selectedImage />
      <AvatarChooser bind:selectedImage {onMountTriggered} />
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
        on:validation={handleValidation}
      />
    </div>
  </div>

  <button
  class="submitButton"
  class:valid={allValid}
    on:click={handleRegister(
      firstName,
      lastName,
      email,
      dateOfBirth,
      userName,
      password,
      description,
      filesToUpload
    )}
    disabled="{!allValid}"
  >
    Create account
  </button>
<!-- 
  <ButtonText
    buttonFunction={handleRegister(
      firstName,
      lastName,
      email,
      dateOfBirth,
      userName,
      password,
      description,
      filesToUpload
    )}
    buttonDisabled={allValid}
    buttonLabel="Sign up"
    bckgColour="#B5C0D0"
    txtColour="white"
    buttonWidth="140px"
  /> -->
</div>

{#if showPopupBox}
  <PopupBox {popupMessage} {redirectUrl} />
{/if}

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
      /* flex-direction: row; */
      align-content: center;
      gap: 4l0px;

      & > .avatar-container {
        width: 20em;
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

    /* .avatar-container {
      padding: 0 auto;
    } */
  }
</style>
