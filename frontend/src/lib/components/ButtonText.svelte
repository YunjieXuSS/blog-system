<!-- A button component to be altered as needed -->

<script>
  export let buttonFunction = () => {};
  export let buttonDisabled = false;
  export let buttonLabel;
  export let bckgColour;
  export let disabledBckgColour = "gray";
  export let txtColour = "white";
  export let disabledTxtColour = "white";
  export let buttonWidth = "100%";
  export let buttonHeight = "45px";
  export let borderRadius = "8px";

  function handleClick() {
    if (!buttonDisabled) {
      buttonFunction();
    }
  }
</script>

<button
  on:click={handleClick}
  class={buttonDisabled ? "disabled" : ""}
  disabled={buttonDisabled}
  style="background-color:{buttonDisabled ? disabledBckgColour : bckgColour}; 
  color:{buttonDisabled ? disabledTxtColour : txtColour}; 
  border-radius:{borderRadius}; width:{buttonWidth}; height:{buttonHeight};
  "
>
  <span>{buttonLabel}</span>
</button>

<style>
  button {
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    border-style: none;
    box-sizing: border-box;
    font-family: "Nunito", sans-serif;
    font-size: 17px;
    font-weight: 800;
    cursor: pointer;
    line-height: 1.5;
    margin: 0;
    max-width: 200px;
    min-height: 35px;
    min-width: 70px;
    padding: 9px 20px 8px;
    position: relative;
    overflow: hidden;
  }

  button:hover:not(:disabled)::before {
    content: "";
    top: 0;
    position: absolute;
    left: -70%;
    width: 50%;
    height: 100%;
    background: rgba(255, 255, 255, 0.4);
    transform: skew(-20deg);
    animation: shine 0.85s forwards;
  }

  @keyframes shine {
    0% {
      left: -70%;
    }
    100% {
      left: 130%;
    }
  }

  .disabled {
    cursor: not-allowed;
    opacity: 0.5;
  }
</style>
