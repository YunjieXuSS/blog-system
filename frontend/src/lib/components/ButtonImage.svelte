<!-- A button component to be altered as needed -->

<script>
  export let imgSrc;
  export let imgAlt;
  export let buttonFunction = () => {};
  export let bckgColour = "transparent";
  export let txtColour = "white";
  export let buttonWidth = "100%";
  export let borderRadius = "4px";
</script>

<button
  on:click={buttonFunction}
  style="background-color:{bckgColour}; color:{txtColour}; border-radius:{borderRadius}; width:{buttonWidth};">
  <img src="{imgSrc}" alt="{imgAlt}" height="50px"/>
</button>

<style>
  * {
    /* border: black solid 1px; */
  }

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
    min-width: 50px;
    padding: 9px 20px 8px;
    position: relative;
    text-align: center;
  }

  button:hover {
    opacity: 0.75;
  }
</style>
