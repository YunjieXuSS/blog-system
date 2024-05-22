<!-- Displays the user's information (username, name, avatar, description) on their profile. -->

<script>
    export let username = "username";
    export let firstName = "fName";
    export let lastName = "lName";
    export let avatarURL = "avatarURL.jpg";
    export let description = "description";
</script>

<div class="profileAvatar">
    <img src="{avatarURL}" alt="User avatar" />
</div>

<div class="profileInfo">
    <h2>{username}</h2>
    <h5>{firstName} {lastName}</h5>
    <p>{description}</p>
</div>

<style>
    * {
        border: 1px solid black;
    }
</style>