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

  export let firstName, lastName, userName;
  export let email;
  export let dateOfBirth;
  export let password;
 let confirmPassword;

  $: console.log("confirmPassword", confirmPassword);

  // define a function to get the first password.
  const getPassword = function () {
    return password;
  };
  // create closure function to validate two passwords.
  const confirmPasswordValidator = validateConfirmPassword(getPassword);


  async function handleRegister(firstName, lastName, email, dateOfBirth, userName, password) {
    const user = { firstName, lastName, email, dateOfBirth, userName, password };
    console.log("register", user);
    const result = createAccount(user);
    console.log("result", result);
  }
</script>

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
    bind:value={dateOfBirth}
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

<style>
  .table-container {
    width: 48%;
  }
</style>
