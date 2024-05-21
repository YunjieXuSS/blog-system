<script>
  import { goto } from "$app/navigation";
  import InputBar from "../../lib/components/InputBar.svelte";
  let userName;
  $: console.log(userName);
  let password;
  $: console.log(password);
  function processLogin() {
    console.log("Processing login");
    console.log(userName);
  }
  function validateUserName(value) {
    if (value.length < 3) {
        return {result:false, errorMsg:"Username must be at least 3 characters long"}
    }
    return { result: true, errorMsg: "" };
  }
  function validatePassword(value) {
    if (value.length < 8) {
      return {result:false, errorMsg:"Password must be at least 8 characters long"}
    }
    return { result: true, errorMsg: "" };
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
      validate={validateUserName}
      maxlength = "20"
      bind:value={userName}
    />

    <InputBar
      label="PASSWORD:"
      type="password"
      placeholder="Password (8+ characters)"
      validate={validatePassword}
      bind:value={password}
    />

    <button on:click={processLogin}>LOGIN</button>
  </div>
</div>

<style>
    .login-container>strong {
        font-size: 3em;
        margin-bottom: 10px;
        color:#505050;
    }
    .login-container>p {
        font-size: 1.3em;
        margin-bottom: 20px;
        color:#505050;
    }  
.login-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        margin: 10% 2% 20% 10%;
        border: 1px solid #505050;
        padding: 80px 50px 50px 40px;
    }
  .login-bar {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-top: 10%;
  }
  button {
    margin-top: 20px;
    padding: 10px;
    background-color: #bbb;
    color: white;
    border: none;
    cursor: pointer;
    width: 120px;
  }
  button:hover {
    background-color: #202020;
  }
</style>
