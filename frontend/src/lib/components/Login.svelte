<script>
  import { goto } from "$app/navigation";
  import { USER_URL } from "../js/apiUrls.js";
  import InputBar from "./InputBar.svelte";
  import ButtonText from "$lib/components/ButtonText.svelte";

  let userName;
  let password;
  let isvalidation = false;
  let loginFailed = false;

  $: isvalidation = validatePassword(password).result && validateUserName(userName).result;

  async function processLogin() {
    const response = await fetch(`${USER_URL}/login`, {
      method: "POST",
      credentials: "include",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ userName, password })
    });
    if (response.status === 200) {
      goto("/", { replaceState: true, invalidateAll: true });
    } else {
      loginFailed = true;
    }
  }

  function validateUserName(value) {
    if (!value) return { result: false, errorMsg: "Username cannot be empty" };
    if (value.length < 3) {
      return { result: false, errorMsg: "Username must be at least 3 characters long" };
    }
    return { result: true, errorMsg: "" };
  }

  function validatePassword(value) {
    if (!value) return { result: false, errorMsg: "Password cannot be empty" };
    if (value.length < 8) {
      return { result: false, errorMsg: "Password must be at least 8 characters long" };
    }
    return { result: true, errorMsg: "" };
  }
</script>

<div class="login-container">
  <h1>Welcome back!</h1>
  <p>Login using an existing account below</p>
  <div class="login-bar">
    <InputBar
      label="USERNAME:"
      type="text"
      placeholder="Enter your username"
      validate={validateUserName}
      maxlength="20"
      bind:value={userName}
    />

    <InputBar
      label="PASSWORD:"
      type="password"
      placeholder="Password (8+ characters)"
      validate={validatePassword}
      bind:value={password}
    />

    <div class="loginButtonContainer">
      <ButtonText
        buttonFunction={processLogin}
        buttonLabel="Login"
        buttonClass="confirmButton"
        buttonDisabled={!isvalidation}
      />
    </div>
  </div>
  
  <div class="login-error" style="display:{loginFailed ? 'block' : 'none'}">
    Invalid password or username. Try again.
  </div>
</div>

<style>
  .login-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: 0;
    border: 10px solid white;
    background-color: white;
    padding: 40px;
    height: 35em;
    width: 32em;
    color: #505050;

    & h1 {
      font-size: 3em;
      font-weight: 800;
      margin: 0;
    }
  }

  .login-container > p {
    font-size: 1.2em;
    margin: 20px 0 45px 0;
  }

  .login-bar {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .login-bar > * {
    margin: 0;
  }

  .login-error {
    color: red;
    margin-top: 20px;
    display: none;
  }
  @media (max-width: 1035px) {
    .login-container {
      width: 25em;
    }
  }

  .loginButtonContainer {
    margin: 30px 0 0 0;
  }
</style>
