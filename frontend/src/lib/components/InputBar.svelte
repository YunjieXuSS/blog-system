<script>
  import { createEventDispatcher } from "svelte";

  export let variableName = "";
  export let label = "";
  export let type = "text";
  export let value = "";
  export let placeholder = "";
  export let maxlength = "100";
  export let validate = async (value) => {
    return { result: true, errorMsg: "" };
  };
  export let validateResult = true;

  const dispatch = createEventDispatcher();
  let errorMsg = "";

  async function checkValue() {
    const validation = await validate(value);
    errorMsg = validation.errorMsg;
    validateResult = validation.result;
    dispatch("validation", { variableName, validateResult });
  }

  function clearError() {
    errorMsg = "";
    validateResult = true;
  }
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
        on:input={checkValue}
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

  .input-section > * {
    margin: 0 0 15px 0;
  }

  .input-bar {
    width: 350px;
    position: relative;
  }
  .error {
    color: rgba(255, 0, 0, 0.837);
    position: absolute;
    top: +5.1em;
    right: 0px;
    font-size: 0.8em;
    white-space: normal;
  }

  label {
    display: block;
    color: #808080;
  }
  input {
    outline: none;
    width: 350px;
    padding: 1em 0.5em;
    margin-top: 0.5em;
    margin-bottom: 1em;
    border: 1px solid #ddd;
    background-color: "white";
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
    .error {
      bottom: -2.2em;
    }
  }
</style>
