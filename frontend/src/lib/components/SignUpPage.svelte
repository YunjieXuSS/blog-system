<script>
  import AvatarUpload from "./UploadAvatar.svelte";
  import SignUpTable from "./SignUpTable.svelte";
  import {
    validateRegisterUserName,
    validateRegisterPassword,
    validateConfirmPassword,
    validateRegisterEmail,
    validateRegisterDate
  } from "../js/validation.js";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";

  let firstName, lastName, userName;
  let password;
  let email;
  let dateOfBirth;
  let description;
  let filesToUpload;
  
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
    if (userRegisterImage && filesToUpload.length > 0 && userRegisterImage !== undefined) {
      formData.append("avatar", userRegisterImage);
    } else {
      //if no image is uploaded, use the default image
      formData.append("avatar", "/images/avatar-default.png");
    }


    // We can send a FormData object directly in the body. Send a POST to our API route, with this data.
    // REMEMBER that this is not JSON we're sending - we're sending multipart form data which is handled
    // by the multer middleware on our server.
    const response = await fetch(`${PUBLIC_API_BASE_URL}/users/register`, {
      method: "POST",
      body: formData
    });

    const serverResponse = await response.json();


  }
</script>

<div class="page-container">
  <div class="page-title"><h2>Create account</h2></div>
  <div class="content-container">
    <div class="avatar-container">
      <AvatarUpload bind:filesToUpload />
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
  >
    Create account
  </button>
</div>

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
</style>
