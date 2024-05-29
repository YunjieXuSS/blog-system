<!-- A button component to be altered as needed -->

<script>
  export let imgSrc;
  export let imgAlt;
  export let buttonFunction = () => {};
  export let bckgColour = "transparent";
  export let buttonWidth = "100%";
  export let borderRadius = "4px";
  export let imgButtonLabel = "";
</script>

<button
  on:click={buttonFunction}
  style="background-color:{bckgColour}; width:{buttonWidth}; border-radius:{borderRadius};">
  <img src="{imgSrc}" alt="{imgAlt}" height="50px"/><p>{imgButtonLabel}</p>
</button>

<style>
  /* * {
    border: black solid 1px;
  } */

  button {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    border-style: none;
    box-sizing: border-box;
    cursor: pointer;
    margin: 0;
    max-width: 200px;
    min-height: 50px;
    min-width: 50px;
    padding: 9px 20px 8px;
    position: relative;
    text-align: center;
  }

  button:hover {
    opacity: 0.75;
  }

  p {
    display: flex;
    align-items: center;
    margin: 0 0 0 20px;
    font-size: 1.4em;
  }
</style>
