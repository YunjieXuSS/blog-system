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
  import { USER_URL } from "$lib/js/apiUrls.js";
  import AvatarChooser from "./AvatarChooser.svelte";
  import PopupBox from "./PopupBox.svelte";
  import { onMount } from "svelte";

  let firstName, lastName, userName;
  let password;
  let email;
  let dateOfBirth;
  let description;
  let filesToUpload;
  let selectedImage = "";
  let onMountTriggered = true;

  let validationResults = {
    firstName: false,
    lastName: false,
    email: false,
    dateOfBirth: false,
    userName: false,
    password: false,
    confirmPassword: false
  };



  //get all the validation results from the SignUpTable dispatch event
  function handleValidation(event) {
    //create a new array to store the validation results
    validationResults[event.detail.variableName] = event.detail.validateResult;
  }

  //check if all the values are valid
  //add a new property to the object to store the result
  //Object.values(validationResults) means put all the values of the object into an array
  //every(Boolean) means check if all the values are true
  $: allValid = Object.values(validationResults).every(Boolean);

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

    //refactor the code to use the createAccount function
    // Create a FormData object to send, rather than sending JSON as usual.
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
    try {
      const body = createFormData();
      // We can send a FormData object directly in the body. Send a POST to our API route, with this data.
      // REMEMBER that this is not JSON we're sending - we're sending multipart form data which is handled
      // by the multer middleware on our server.
      const response = await fetch(`${USER_URL}/register`, {
        method: "POST",
        credentials: "include",
        body
      });

      if (response.status === 201) {
        // Redirect to the login page if successful.
        handlePopupBox();
      } else {
        // If there was an error, log the error to the console.
        console.error(`Failed to register user.StatusCode: ${response.status}`);
      }
    } catch (error) {
      console.error(`Failed to register user.${error}`);
    }
  }

  let showPopupBox = false;
  let popupMessage = "Mission Completed!";
  let redirectUrl = "/";

  function handlePopupBox() {
    popupMessage = `User has registered. Redirecting to homepage...`;
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
    disabled={!allValid}
  >
    Create account
  </button>
  <!-- 
  <ButtonText
    buttonFunction={() => handleRegister(
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

<PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox/>


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
