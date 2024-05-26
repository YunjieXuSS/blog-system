<script>
  /** This component is for the input bar that is used to input the text for username, password, etc.
   * It defines the layout of the input bar. It is used in the login page and signup page.
   **/
  export let label = "";
  export let type = "text";
  export let value = "";
  export let placeholder = "";
  export let maxlength = "100";
  export let validate = async(value) => {
    return { result: true, errorMsg: "" };
  };
  export let validateResult = true;
  let errorMsg = "";
  async function checkValue() {
    const validation = await validate(value);
    errorMsg = validation.errorMsg;
    validateResult = validation.result;
    dispatch('validation', { validateResult, label });
  }
  function clearError() {
    errorMsg = "";
    validateResult = true;
  }
//create a dispatcher to send the validation result to the SignUpTable.svelte
  import { createEventDispatcher } from 'svelte';
  const dispatch = createEventDispatcher();
</script>



<div class="input-bar">
  <label for={label}>{label}</label>
  <div class="input-section">
    {#if type === "password"}
    
      <input
        class:active={!validateResult}
        id={label}
        type="password"
        {placeholder}
        {maxlength}
        bind:value
        on:blur={checkValue}
        on:focus={clearError}
      />
    {:else if type === "email"}
      <input
        class:active={!validateResult}
        id={label}
        type="email"
        {placeholder}
        {maxlength}
        bind:value
        on:blur={checkValue}
        on:focus={clearError}
      />
    {:else if type === "date"}
      <input
        class:active={!validateResult}
        id={label}
        type="date"
        {placeholder}
        {maxlength}
        bind:value
        on:blur={checkValue}
        on:focus={clearError}
      />
    {:else}
      <input
        class:active={!validateResult}
        id={label}
        type="text"
        {placeholder}
        {maxlength}
        bind:value
        on:blur={checkValue}
        on:focus={clearError}
      />
    {/if}
    {#if !validateResult}
      <p class="error">{errorMsg}</p>
    {/if}
  </div>
</div>

<style>
  .active {
    border: 1px solid rgba(255, 0, 0, 0.837);
  }
  .input-section {
    display: flex;
    align-items: center;
  }
  .input-bar {
    width: 350px;
    position: relative;
  }
  .error {
    color: rgba(255, 0, 0, 0.837);
    position: absolute;
    bottom: -1.3em;
    right: 0px;
    font-size: 0.8em;
  }
  label {
    display: block;
    margin-top: 1em;
    color:#808080;
  }
  input {
    outline: none;
    width: 350px;
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
  @media (max-width: 450px) {
    .input-bar {
      width: 100%;
      margin-bottom: 10px;
    }
    input {
      width: 100%;
    }
    .error{
      bottom:-2.2em;
    }
  }
</style>
