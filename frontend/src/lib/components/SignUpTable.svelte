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
  import ArticleCard from "./ArticleCard.svelte";

  export let firstName, lastName, userName;
  export let email;
  export let dateOfBirth;
  export let password;
  export let description = "I know myself so well.";
  // export let validateResult;
  let confirmPassword;
  // define a function to get the first password.
  const getPassword = function () {
    return password;
  };
  // create closure function to validate two passwords.
  const confirmPasswordValidator = validateConfirmPassword(getPassword);


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

  <label for="description">DESCRIPTION:</label>
  <textarea class="description-textarea" name="description" rows="4" cols="50" bind:value={description}></textarea>
</div>

<style>
  .table-container {
    width: 48%;

    & label {
      display: block;
      margin-top: 1em;
      color: #808080;
    }
    & .description-textarea {
      outline: none;
      width: 335px;
      padding: 1em 0.5em;
      margin-top: 0.5em;
      margin-bottom: 1em;
      border: 1px solid #ddd;
      background-color: #ddd;
      color: #606060;
      &::placeholder {
        color: #909090;
      }
    }
  }
</style>
