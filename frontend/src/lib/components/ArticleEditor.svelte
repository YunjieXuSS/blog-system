<script>
  import { goto } from "$app/navigation";
  import { ARTICLES_URL, BASE_URL } from "./../js/apiUrls.js";
  import Editor from "@tinymce/tinymce-svelte";
  import PopupBox from "./PopupBox.svelte";
  let showPopupBox = false;
  let popupMessage = "";
  let redirectUrl = "/";

  export let article;
  let value = article.content;
  let title = article.title;
  const articleId = article.articleId;
  let imgSrc = article.imgUrl || "";
  let onValueError = false;
  let onTitleError = false;

  let fileToUpload = [];

  $: {
    const [file] = fileToUpload;
    if (file) {
      imgSrc = URL.createObjectURL(file);
    }
  }

  const body = new FormData();
  $: {
    onValueError = !value;
    onTitleError = !title;
    body.set("content", value);
    body.set("title", title);
  }

  function handleUpdatePopupBox() {
    popupMessage = "Article has been updated.";
    showPopupBox = true;
    redirectUrl = `/article/${articleId}`
  }

  async function handleSubmit() {
    if (onTitleError || onValueError) return;
    if (fileToUpload.length) {
      body.set("imgUrl", fileToUpload[0]);
    } else if (!imgSrc) {
      body.set("imgUrl", "");
    }
    const res = await fetch(`${ARTICLES_URL}/${articleId}`, {
      credentials: "include",
      method: "PATCH",
      body
    });
    if (res.ok) {
      handleUpdatePopupBox();
      invalidate(ARTICLES_URL);
      // goto(`/article/${articleId}`, { invalidateAll: true });
    }
  }

  function removeImage() {
    imgSrc = "";
    fileToUpload = [];
  }

  // /** @type {import('tinymce').RawEditorOptions} */
  const conf = {
    plugins: ["lists"],
    toolbar:
      "undo redo | styles | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist",
    menubar: "favxs file edit view insert format tools table help"
  };
</script>

<main>
  <form>
    <div class="title">
      <label for="title:">TITLE:</label>
      <input
        id="title"
        type="text"
        bind:value={title}
        style="border: {onTitleError ? 'solid 1px red' : ''}"
      />
    </div>
    <article class="edit-area" style="border-color: {onValueError ? 'red' : ''}">
      <Editor apiKey="sra0m68u1hvp9tgk2ggky0dmfdf5yvr27x5x543k7ga6he82" bind:value {conf} />
    </article>
    {#if imgSrc !== ""}
      <img
        src={!fileToUpload.length ? `http://localhost:3000${imgSrc}` : imgSrc}
        alt="failed to load"
        class="img"
      />
    {/if}
    {#if imgSrc || fileToUpload.length}
      <button class="remove" on:click={removeImage}>Remove Image</button>
    {:else}
      <div>
        <input
          type="file"
          id="files"
          class="hidden"
          multiple={false}
          name="image-file"
          accept="image/png, image/jpeg"
          bind:files={fileToUpload}
        />
        <label class="upload-image" for="files">Add/Update image</label>
      </div>
    {/if}
    <button class="submit" on:click={handleSubmit}>Submit</button>
  </form>
</main>
<PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox/>

<style>
  .hidden {
    display: none;
  }
  main {
    width: 900px;

    & form {
      width: 100%;
    }
  }
  .img {
    width: 100%;
    height: auto;
  }
  .title {
    margin: 8px 0;
    display: flex;
    align-items: center;
    & label {
      font-weight: 700;
    }

    & #title {
      margin-left: 8px;
      padding: 4px;
      flex: 1;
    }
  }

  button.submit {
    display: block;
    margin: 16px 0;
    padding: 8px;
    border-radius: 4px;
    background: #444;
    color: #eee;
    border: none;
  }

  .upload-image {
    display: block;
    text-align: center;
    background: #eee;
    padding: 16px 0;
    color: #252525;
  }

  button.remove {
    margin: 16px 0;
    padding: 8px;
    border-radius: 4px;
    background: #444;
    color: #eee;
    border: none;
    display: block;
  }

  .edit-area {
    border: #252525 solid 1px;
  }

  @media screen and (max-width: 600px) {
    main {
      width: 300px;
    }
  }
</style>
