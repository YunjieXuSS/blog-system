<!-- A universal button component -->

<script>
  import "$lib/css/button.css";

  export let buttonFunction = () => {};
  export let buttonLabel;
  export let buttonClass;
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
  disabled={buttonDisabled}
>
  <span>{buttonLabel}</span>
</button>
