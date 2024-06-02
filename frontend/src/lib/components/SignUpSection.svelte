<!-- A component for the area right of the log in component. Contains a button that takes the user to the create account page -->
<script>
  import ButtonText from "$lib/components/ButtonText.svelte";

  function openSignUpPage() {
    window.location = "/signup";
  }
</script>

<div class="newHere">
  <h1>New here?</h1>
  <p>Welcome to chars! <br /> Join our community by creating a free account</p>

  <ButtonText
    buttonFunction={openSignUpPage}
    buttonLabel="Create Account"
    buttonClass="createAccountButton"
  />
</div>

<style>
  .newHere {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 40px;
    height: 35em;
    width: 19em;
    background-color: #9eb384;
    border: 10px solid #9eb384;
    color: white;

    & h1 {
      font-size: 3em;
      font-weight: 800;
      margin: 0;
    }

    & p {
      font-size: 1.2em;
      margin: 20px 0 45px 0;
    }
  }

  @media (max-width: 1035px) {
    .newHere {
      width: 25em;
    }
  }
</style>
