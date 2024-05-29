<!-- Displays the amount of likes and comments at the bottom of an article in article viewer and article card -->

<script>
  import LikeButton from "$lib/components/LikeButton.svelte";
  export let data;
  import ButtonImage from "$lib/components/ButtonImage.svelte";
  import { goto } from "$app/navigation";
  export let numComments = 0;
</script>

<LikeButton data={data} />

