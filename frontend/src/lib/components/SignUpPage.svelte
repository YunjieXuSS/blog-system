<script>
  import InputBar from "./InputBar.svelte";
  import AvatarUpload from "./AvatarUpload.svelte";
  import SignUpTable from "./SignUpTable.svelte";
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

  let firstName, lastName, userName;
  let password;
  let email;
  let dateOfBirth;
  let filesToUpload;

  // define a function to get the first password.
  const getPassword = function () {
    return password;
  };
  // create closure function to validate two passwords.
  const confirmPasswordValidator = validateConfirmPassword(getPassword);

  async function handleRegister(
    firstName,
    lastName,
    email,
    dateOfBirth,
    userName,
    password,
    filesToUpload
  ) {
    const userRegisterData = { firstName, lastName, email, dateOfBirth, userName, password };
    const userRegisterImage = filesToUpload[0];
    // const userRegisterImage =events.target.files[0];
    console.log("filesToUpload", filesToUpload);
    console.log("register", userRegisterData);
    console.log("Image", userRegisterImage);

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
    }else{
      //if no image is uploaded, use the default image
      formData.append("avatar", "/images/avatar-default.png");
    }

    // console.log("formData", formData);

    // We can send a FormData object directly in the body. Send a POST to our API route, with this data.
    // REMEMBER that this is not JSON we're sending - we're sending multipart form data which is handled
    // by the multer middleware on our server.
    const response = await fetch(`${PUBLIC_API_BASE_URL}/users/register`, {
      method: "POST",
      body: formData
    });

    const serverResponse = await response.json();

    // const result = createAccount(user);
    // console.log("result", result);
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
      />
    </div>
  </div>

  <button
    on:click={handleRegister(
      firstName,
      lastName,
      email,
      dateOfBirth,
      userName,
      password,
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

    & > .content-container {
      display: flex;
      flex-direction: row;
      align-content: center;
      gap: 20px;

      & > .avatar-container {
        width: 50%;
      }
      & > .table-container {
        width: 48%;
      }
    }
  }
</style>
