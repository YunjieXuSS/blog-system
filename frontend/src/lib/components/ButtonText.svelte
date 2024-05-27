<!-- A button component to be altered as needed -->

<script>
  export let buttonFunction = () => {};
  export let buttonDisabled = false;
  export let buttonDisabledClass = "";
  export let buttonLabel;
  export let bckgColour;
  export let txtColour = "white";
  export let buttonWidth = "100%";
  export let borderRadius = "4px";

  function handleClick() {
    if (!buttonDisabled) {
      buttonFunction();
    }
  }
</script>

<button
  on:click={handleClick} class="{buttonDisabled ? 'disabled' + buttonDisabledClass : buttonDisabledClass}" {buttonDisabled}
  style="background-color:{bckgColour}; color:{txtColour}; border-radius:{borderRadius}; width:{buttonWidth};"
  >{buttonLabel}
</button>

<style>
  button {
    display: flex;
    justify-content: center;
    border-style: none;
    box-sizing: border-box;
    font-family: "Nunito", sans-serif;
    font-size: 17px;
    font-weight: 800;
    cursor: pointer;
    line-height: 1.5;
    margin: 0;
    max-width: 200px;
    min-height: 45px;
    min-width: 100px;
    padding: 9px 20px 8px;
    position: relative;
    text-align: center;
  }

  button:hover {
    opacity: 0.75;
  }

  .disabled {
    cursor: not-allowed;
  }
</style>
