<!-- A button component to be altered as needed -->

<script>
  import "$lib/css/button.css";
  export let buttonFunction = () => {};
  export let buttonClass;
  export let buttonLabel;
  export let buttonDisabled = false;


  function handleClick() {
    if (!buttonDisabled) {
      buttonFunction();
    }
  }
</script>

<button
  on:click={handleClick}
  class={buttonDisabled ? "disabledButton" : buttonClass}
  disabled={buttonDisabled}>
  <span>{buttonLabel}</span>
</button>

<!-- <button
  on:click={handleClick}
  class={buttonDisabled ? "disabledButton" : buttonClass}
  disabled={buttonDisabled}
  style="background-color:{buttonDisabled ? disabledBckgColour : bckgColour}; 
  color:{buttonDisabled ? disabledTxtColour : txtColour}; 
  border-radius:{borderRadius}; width:{buttonWidth}; height:{buttonHeight};
  "
>
  <span>{buttonLabel}</span>
</button> -->
