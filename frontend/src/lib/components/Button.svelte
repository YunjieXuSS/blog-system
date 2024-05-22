<!-- A button component to be altered as needed -->

<script>
    export let buttonLable;
    export let buttonPath;
    export function buttonClickFunction(){
        window.location={buttonPath};
    }
</script>

<button onclick="buttonClickFunction()">{buttonLable}</button>

