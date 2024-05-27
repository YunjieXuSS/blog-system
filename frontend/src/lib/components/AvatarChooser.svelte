<script>
  export let selectedImage = "";
  import { onMount } from "svelte";
  export let onMountTriggered = true;
  let images = [
    "/defaultAvatars/userDefaultIcon1.png",
    "/defaultAvatars/userDefaultIcon2.png",
    "/defaultAvatars/userDefaultIcon3.png",
    "/defaultAvatars/userDefaultIcon4.png",
    "/defaultAvatars/userDefaultIcon5.png",
    "/defaultAvatars/userDefaultIcon6.png",
    "/defaultAvatars/userDefaultIcon7.png",
    "/defaultAvatars/userDefaultIcon8.png",
    "/defaultAvatars/userDefaultIcon9.png",
  ];
  //update the path of images
  function selectImage(image) {
    selectedImage = image;
  }

  if (onMountTriggered) {
    //default image when the page is loaded
    onMount(() => {
      if (images.length > 0 && !selectedImage) {
        selectImage(images[0]);
      }
    });
  }
</script>

<div class="image-grid">
  {#each images as image}
    <button
      type="button"
      class="image-item"
      on:click={() => selectImage(image)}
      aria-pressed={selectedImage === image}
    >
      <img src={image} alt="Predefined avatar" class:selected={selectedImage === image} />
    </button>
  {/each}
</div>

<style>
  .image-grid {
    display: grid;
    grid-template-columns: repeat(3, 0.2fr);
    justify-content: center;
    gap: 10px;
    width: 100%;
  }
  /* hide the button css */
  .image-item {
    padding: 0;
    border: none;
    background: none;
    cursor: pointer;
    border-radius: 10px;
  }
  .image-item img {
    width: 100%;
    height: auto;
    display: block;
    border: 2px solid transparent;
  }
  .image-item img.selected {
    border-width: 3px;
    border-color: rgb(255, 72, 0);
    border-radius: 10px;
  }
</style>
