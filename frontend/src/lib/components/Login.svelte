<script>
  import { goto } from "$app/navigation";
  import InputBar from "./InputBar.svelte";
  import {USER_URL} from "../js/apiUrls.js";
  let userName;
  let password;
  let isvalidation = false;
  let loginFailed = false;
  $: isvalidation = validatePassword(password).result && validateUserName(userName).result;
  async function processLogin() {
    console.log("Processing login start");
    const response = await fetch(`${USER_URL}/login`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ userName, password }),
    });
    if(response.status === 200){
      goto("/", { replaceState: true, invalidateAll: true });
    }
    loginFailed = true;
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
  async function validateUserNameTest(value){
    const response = await fetch(`${USER_URL}/username/${value}`);
    if(response.status === 200){
      return { result: false, errorMsg: "Username already exists" };
    }
  }

</script>

<div class="login-container">
  <strong>Welcome back!</strong>
  <p>Login using an existing account below</p>
  <div class="login-bar">
    <InputBar
      label="USERNAME:"
      type="text"
      placeholder="Enter your username"
      validate={validateUserNameTest}
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
    <button class:diabled={!isvalidation} on:click={processLogin} disabled={!isvalidation}>LOGIN</button>
  </div>
  <div class="login-error" style = "display:{loginFailed?'block':'none'}">Invalid password or username. Try again.</div>
</div>

<style>
  .login-container > strong {
    font-size: 3em;
    margin-bottom: 10px;
    color: #505050;
    text-align: center;
  }
  .login-container > p {
    font-size: 1.3em;
    margin-bottom: 20px;
    color: #505050;
    text-align: center;
  }
  .login-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: 20px 2% 20px 10%;
    border: 1px solid #505050;
    padding: 80px 50px 50px 40px;
  }
  .login-bar {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-top: 40px;
  }
  button {
    margin-top: 20px;
    padding: 10px;
    background-color: #303030;
    color: white;
    border: none;
    cursor: pointer;
    width: 120px;
  }
  button:hover {
    background-color: #909090;
  }
  button:disabled {
    background-color: #ccc;
    cursor: not-allowed;
  }
  .login-error {
    color: red;
    margin-top: 20px;
    display: none;
  }
  @media (max-width: 450px) {
    .login-container {
      margin: 20px 2% 20px 2%;
    }
  }
</style>
