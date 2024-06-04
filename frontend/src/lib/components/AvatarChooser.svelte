<script>
  import { onMount } from "svelte";
  export let selectedImage = "";
  export let onMountTriggered = true;
  export let isSelectedDefaultImg = true;
  let images = [
    "/images/userDefaultIcon1.png",
    "/images/userDefaultIcon2.png",
    "/images/userDefaultIcon3.png",
    "/images/userDefaultIcon4.png",
    "/images/userDefaultIcon5.png",
    "/images/userDefaultIcon6.png",
    "/images/userDefaultIcon7.png",
    "/images/userDefaultIcon8.png",
    "/images/userDefaultIcon9.png"
  ];

  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  function selectImage(image) {
    selectedImage = image;
    isSelectedDefaultImg = true;
    dispatch("selectedImage", { isSelectedDefaultImg: true });
  }

  if (onMountTriggered) {
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
    grid-template-columns: repeat(3, 0.3fr);
    justify-content: center;
    gap: 10px;
    width: 100%;
  }
  .image-item {
    padding: 5px;
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
    border-color: #9eb384;
    border-radius: 50%;
  }
</style>
