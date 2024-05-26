<script>
  import InputBar from "./InputBar.svelte";
  import UpdateUserTable from "./UpdateUserTable.svelte";
  import UpdateAvatar from "./UpdateAvatar.svelte";
  import { createAccount } from "../js/utils.js";
  import {
    validateRegisterUserName,
    validateRegisterPassword,
    validateConfirmPassword,
    validateRegisterEmail,
    validateRegisterDate
  } from "../js/validation.js";
  import SignUpSection from "./SignUpSection.svelte";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import { user } from "../js/store.js";
  import Dayjs from "dayjs";
  import { SERVER_URL } from "../js/apiUrls.js";

  export let data;
  user.set(data.userInfo);
  let firstName = $user.firstName;
  let lastName = $user.lastName;
  let userName = $user.userName;
  let password;
  let email = $user.email;
  let dateOfBirth = Dayjs($user.dateOfBirth).format("YYYY-MM-DD");
  let description = $user.description;
  let filesToUpload;
  let avatarURL = $user.avatar;

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
    console.log("firstName", firstName);
    console.log("user.firstName", $user.firstName);
    if (firstName !== $user.firstName) {
      console.log("firstName", firstName);
      console.log("user.firstName", $user.firstName);
      formData.append("firstName", firstName);
    }
    if (lastName !== $user.lastName) {
      formData.append("lastName", lastName);
    }
    if (email !== $user.email) {
      formData.append("email", email);
    }
    if (dateOfBirth !== $user.dateOfBirth) {
      formData.append("dateOfBirth", dateOfBirth);
    }
    if (userName !== $user.userName) {
      formData.append("userName", userName);
    }
    if (password) {
      formData.append("password", password);
    }
    if (userRegisterImage && filesToUpload.length > 0 && userRegisterImage !== undefined) {
      formData.append("avatar", userRegisterImage);
    } else {
      //if no image is uploaded, use the default image
      formData.append("avatar", "/images/avatar-default.png");
      // formData.append("avatar", "localhost:3000/images/avatar-default.png");
    }


    // We can send a FormData object directly in the body. Send a POST to our API route, with this data.
    // REMEMBER that this is not JSON we're sending - we're sending multipart form data which is handled
    // by the multer middleware on our server.
    const response = await fetch(`${PUBLIC_API_BASE_URL}/users/`, {
      method: "PATCH",
      credentials: "include",
      body: formData
    });

    const serverResponse = await response.json();

  }
</script>

<div class="page-container">
  <div class="page-title"><h2>Edit account</h2></div>
  <div class="content-container">
    <div class="avatar-container">
      <!-- <UpdateAvatar bind:filesToUpload userIconURL={"localhost:3000/images/img2.jpg"}/> -->
      <UpdateAvatar bind:filesToUpload userIconURL={`${SERVER_URL}/${avatarURL}`} />

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
      />
    </div>
  </div>

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
    Confirm edit
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
