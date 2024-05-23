<!-- A button component to be altered as needed -->

<script>
  export let buttonLabel;
  export let buttonPath;
  export let bckgColour;
  export let txtColour = "white";
  export let borderRadius = "4px";
</script>

<a href={buttonPath}><button style="background-color:{bckgColour}; color:{txtColour}; border-radius:{borderRadius}">{buttonLabel}</button></a>

<style>
  button {
    border-style: none;
    box-sizing: border-box;
    font-family: 'Nunito', sans-serif;
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
    width: 100%;
  }

  button:hover {
    opacity: 0.75;
  }

</style>
