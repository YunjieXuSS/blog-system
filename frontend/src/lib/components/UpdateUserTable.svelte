<script>
  import InputBar from "./InputBar.svelte";
  import {
    validateRegisterName,
    validateRegisterUserName,
    validateUpdateUserName,
    validateRegisterPassword,
    validateConfirmPassword,
    validateRegisterEmail,
    validateRegisterDate
  } from "../js/validation.js";
  export let userData;
  export let firstName, lastName, userName;
  export let email;
  export let dateOfBirth;
  export let password;
  export let description = "I know myself so well.";
  import { createEventDispatcher } from "svelte";

  // export let validateResult;
  let confirmPassword;
  // define a function to get the first password.
  const getPassword = function () {
    return password;
  };
  // create closure function to validate two passwords.
  const confirmPasswordValidator = validateConfirmPassword(getPassword);

  let label = "";

  const dispatch = createEventDispatcher();
  //create a dispatcher to send the validation result to the SignUpPage.svelte
  //Get validateResult, label from the event.detail (CustomEvent)
  //validation event is dispatched from the InputBar.svelte's checkValue function
  function handleValidation(event) {
    const { validateResult, label } = event.detail;
    dispatch("validation", { validateResult, label });
  }

  function handleUserNameValidation(event) {
    if (userData.userName === userName) {
      return { result: true, errorMsg: "user hasn't been changed" };
    } else {
      return validateRegisterUserName(userName);
    }
  }

  function handlePasswordValidation(event) {
    if (password == "") {
      return { result: true, errorMsg: "Password is empty" };
    } else {
      return validateRegisterPassword(password);
    }
  }

  function handleConfirmedPasswordValidation(event) {
    if (confirmPassword == "") {
      return { result: true, errorMsg: "ConfirmPassword is empty" };
    } else {
      return confirmPasswordValidator(confirmPassword);
    }
  }
</script>

<div class="table-container">
  <InputBar
    label="FIRTST NAME:"
    type="text"
    placeholder="Enter your first name"
    validate={validateRegisterName}
    maxlength="30"
    bind:value={firstName}
    on:validation={handleValidation}
  />
  <InputBar
    label="LAST NAME:"
    type="text"
    placeholder="Enter your second name"
    validate={validateRegisterName}
    maxlength="30"
    bind:value={lastName}
    on:validation={handleValidation}
  />
  <InputBar
    label="EMAIL:"
    type="email"
    placeholder="Enter your user email"
    validate={validateRegisterEmail}
    maxlength="64"
    bind:value={email}
    on:validation={handleValidation}
  />

  <InputBar
    label="DAY OF BIRTH:"
    type="date"
    placeholder="Enter your user birthday"
    validate={validateRegisterDate}
    maxlength="20"
    bind:value={dateOfBirth}
    on:validation={handleValidation}
  />

  <InputBar
    label="USERNAME:"
    type="text"
    placeholder="Enter your user name"
    validate={handleUserNameValidation}
    maxlength="30"
    bind:value={userName}
    on:validation={handleValidation}
  />

  <InputBar
    label="RESET PASSWORD:"
    type="password"
    placeholder="Enter your password"
    validate={handlePasswordValidation}
    maxlength="30"
    bind:value={password}
    on:validation={handleValidation}
  />
  <InputBar
    label="CONFIRM PASSWORD:"
    type="password"
    placeholder="Re-enter your password"
    validate={handleConfirmedPasswordValidation}
    maxlength="30"
    bind:value={confirmPassword}
    on:validation={handleValidation}
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
