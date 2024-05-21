<script>
  import { getPasswordHashSalt } from "../lib/js/utils";

  let result = {};
  let salt, hash;
  async function clickBTN() {
    const response = await getPasswordHashSalt("password");
    result = await response.json();
    console.log(response);
    console.log(result);
    salt = result.password_salt;
    hash = result.password_hash;
    console.log(hash);
  }
 
</script>

// ---/routes/+page.svelte // This file is our homepage. It displays sort bar and list of articles.

<span>{result}</span>
<span>{salt}</span>
<button on:click={clickBTN}>test</button>
