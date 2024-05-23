<!-- A button component to be altered as needed -->

<script>
  export let buttonLabel;
  export let buttonPath;
  export let bckgColour;
</script>

<a href={buttonPath}><button style="background-color:{bckgColour}">{buttonLabel}</button></a>

<style>
  button {
    border-top-left-radius: 4px;
    border-bottom-left-radius: 4px;
    border-style: none;
    box-sizing: border-box;
    color: #fff;
    cursor: pointer;
    font-size: 17px;
    font-weight: 700;
    line-height: 1.5;
    margin: 0;
    max-width: 150px;
    min-height: 45px;
    min-width: 100px;
    padding: 9px 20px 8px;
    position: relative;
    text-align: center;
    width: 100%;
  }

  button:hover,
  button:focus {
    opacity: 0.75;
  }

</style>
