<!-- A button component to be altered as needed -->

<script>
  export let buttonLabel;
  export let buttonPath;
  export let ref;
</script>

<a href={buttonPath}><button>{buttonLabel}</button></a>

<style>
  button {
    background-color: #B5C0D0;
    border-top-left-radius: 4px;
    border-bottom-left-radius: 4px;
    border-style: none;
    box-sizing: border-box;
    color: #fff;
    cursor: pointer;
    /* display: inline-block; */
    font-size: 18px;
    font-weight: 700;
    line-height: 1.5;
    margin: 0;
    max-width: 150px;
    min-height: 44px;
    min-width: 10px;
    outline: none;
    overflow: hidden;
    padding: 9px 20px 8px;
    position: relative;
    text-align: center;
    text-transform: none;
    user-select: none;
    -webkit-user-select: none;
    touch-action: manipulation;
    width: 100%;
  }

  button:hover,
  button:focus {
    opacity: 0.75;
  }

</style>
