<script>
  import InputBar from "$lib/components/InputBar.svelte";
  import {
    validateRegisterName,
    validateRegisterUserName,
    validateRegisterPassword,
    validateConfirmPassword,
    validateRegisterEmail,
    validateRegisterDate
  } from "$lib/js/validation.js";

  export let userNamehasChanges = false;
  export let isUpdateMode = false;
  export let firstName, lastName, userName;
  export let email;
  export let dateOfBirth;
  export let password;
  export let description = "I know myself so well.";
  export let confirmPassword;

  const getPassword = function () {
    return password;
  };

  const confirmPasswordValidator = validateConfirmPassword(getPassword);

  let label = "";
  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  function handleValidation(event) {
    const { variableName, validateResult } = event.detail;
    dispatch("validation", { variableName, validateResult });
  }

  function handleUserNameValidation() {
    if (isUpdateMode && userNamehasChanges) {
      return validateRegisterUserName(userName);
    } else if (!isUpdateMode) {
      return validateRegisterUserName(userName);
    } else if (isUpdateMode && !userNamehasChanges) {
      return { result: true, errorMsg: "user hasn't been changed" };
    }
  }
</script>

<div class="table-container">
  <InputBar
    label="FIRST NAME:"
    type="text"
    placeholder="Enter your first name"
    validate={validateRegisterName}
    maxlength="30"
    bind:value={firstName}
    on:validation={handleValidation}
    variableName="firstName"
  />
  <InputBar
    label="LAST NAME:"
    type="text"
    placeholder="Enter your surname"
    validate={validateRegisterName}
    maxlength="30"
    bind:value={lastName}
    on:validation={handleValidation}
    variableName="lastName"
  />
  <InputBar
    label="EMAIL:"
    type="email"
    placeholder="Enter your email"
    validate={validateRegisterEmail}
    maxlength="64"
    bind:value={email}
    on:validation={handleValidation}
    variableName="email"
  />

  <InputBar
    label="DATE OF BIRTH:"
    type="date"
    placeholder="Enter your date of birth"
    validate={validateRegisterDate}
    maxlength="20"
    bind:value={dateOfBirth}
    on:validation={handleValidation}
    variableName="dateOfBirth"
  />

  <InputBar
    label="USERNAME:"
    type="text"
    placeholder="Enter your username"
    validate={handleUserNameValidation}
    maxlength="20"
    bind:value={userName}
    on:validation={handleValidation}
    variableName="userName"
  />
  <InputBar
    label="PASSWORD:"
    type="password"
    placeholder="Enter your password"
    validate={validateRegisterPassword}
    maxlength="30"
    bind:value={password}
    on:validation={handleValidation}
    variableName="password"
  />
  <InputBar
    label="CONFIRM PASSWORD:"
    type="password"
    placeholder="Re-enter your password"
    validate={confirmPasswordValidator}
    maxlength="30"
    bind:value={confirmPassword}
    on:validation={handleValidation}
    variableName="confirmPassword"
  />

  <label for="description">DESCRIPTION:</label>
  <textarea
    class="description-textarea"
    name="description"
    rows="4"
    cols="50"
    bind:value={description}
  />
</div>

<style>
  .table-container {
    width: 22em;

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
