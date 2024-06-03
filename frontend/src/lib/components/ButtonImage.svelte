<!-- A button component to be altered as needed -->

<script>
  export let imgSrc;
  export let imgAlt;
  export let buttonFunction = async () => {};
  export let bckgColour = "transparent";
  export let buttonWidth = "100%";
  export let borderRadius = "4px";
  export let imgButtonLabel = "";
  export let imgWidth = "50px";
</script>

<button
  on:click={buttonFunction}
  style="background-color:{bckgColour}; width:{buttonWidth}; border-radius:{borderRadius};">
  <img src="{imgSrc}" alt="{imgAlt}" height="{imgWidth}"/><p>{imgButtonLabel}</p>
</button>

<style>
  button {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    border-style: none;
    box-sizing: border-box;
    cursor: pointer;
    margin: 0;
    padding: 0;
    max-width: 200px;
    min-height: 20px;
    min-width: 20px;
    position: relative;
    text-align: center;
  }

  button:hover {
    transform: translateY(-3px);
    transition: 0.3s;
  }

  p {
    display: flex;
    align-items: center;
    margin: 0 0 0 10px;
    font-size: 1.1em;
    font-weight: 400;
  }
</style>
