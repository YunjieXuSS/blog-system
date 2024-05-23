<script>
  import InputBar from "./InputBar.svelte";
  import { createAccount } from "../js/utils.js";
  import {
    validateRegisterUserName,
    validateRegisterPassword,
    validateConfirmPassword,
    validateRegisterEmail,
    validateRegisterDate
  } from "../js/validation.js";
  import AvatarUpload from "./AvatarUpload.svelte";

  let firstName, lastName, userName;
  let password;
  let email;
  let birthday;
  let confirmPassword;

  $: console.log("confirmPassword", confirmPassword);

  // define a function to get the first password.
  const getPassword = function () {
    return password;
  };
  // create closure function to validate two passwords.
  const confirmPasswordValidator = validateConfirmPassword(getPassword);

  async function handleRegister(firstName, lastName, email, birthday, userName, password) {
    const user={firstName,lastName, email, birthday, userName, password};
    console.log("register",user);
    const result = createAccount(user);
    console.log("result",result);
  }
</script>

<div class="page-container">
  <div class="page-title"><h2>Create account</h2></div>
  <div class="content-container">
    <div class="avatar-container">
      <AvatarUpload />
    </div>
    <div class="table-container">
      <InputBar
        label="FIRTST NAME:"
        type="text"
        placeholder="Enter your first name"
        validate={validateRegisterUserName}
        maxlength="20"
        bind:value={firstName}
      />
      <InputBar
        label="LAST NAME:"
        type="text"
        placeholder="Enter your second name"
        validate={validateRegisterUserName}
        maxlength="20"
        bind:value={lastName}
      />
      <InputBar
        label="EMAIL:"
        type="email"
        placeholder="Enter your user email"
        validate={validateRegisterEmail}
        maxlength="20"
        bind:value={email}
      />

      <InputBar
        label="DAY OF BIRTH:"
        type="date"
        placeholder="Enter your user birthday"
        validate={validateRegisterDate}
        maxlength="20"
        bind:value={birthday}
      />

      <InputBar
        label="USERNAME:"
        type="text"
        placeholder="Enter your user name"
        validate={validateRegisterUserName}
        maxlength="20"
        bind:value={userName}
      />
      <InputBar
        label="PASSWORD:"
        type="password"
        placeholder="Enter your password"
        validate={validateRegisterPassword}
        maxlength="20"
        bind:value={password}
      />
      <InputBar
        label="CONFIRM PASSWORD:"
        type="password"
        placeholder="Re-enter your password"
        validate={confirmPasswordValidator}
        maxlength="20"
        bind:value={confirmPassword}
      />
    </div>
  </div>

  <button on:click={handleRegister(firstName, lastName, email, birthday, userName, password)}>
    Create account</button
  >
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
