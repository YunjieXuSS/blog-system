<!-- A component for the area right of the log in component. Contains a button that takes the user to the create account page -->

<script>
    import Button from "$lib/components/Button.svelte";
</script>

<h1>New here?</h1>
<p>Welcome to chars!</p>
<p>Join our community by creating a free account.</p>

<Button buttonLable="Create Account" buttonPath="'/signup'"/>