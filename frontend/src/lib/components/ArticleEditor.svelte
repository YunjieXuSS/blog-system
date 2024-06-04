<script>
  import { goto } from "$app/navigation";
  import { ARTICLES_URL, SERVER_URL } from "./../js/apiUrls.js";
  import Editor from "@tinymce/tinymce-svelte";
  import PopupBox from "./PopupBox.svelte";
  import Modal from "./Modal.svelte";
  import ButtonText from "$lib/components/ButtonText.svelte";

  let showPopupBox = false;
  let showEditPopupBox = false;
  let popupMessage = "";
  let redirectUrl = "/";
  let errorMsg = "";
  let isSubmitError = false;

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
    redirectUrl = `/article/${articleId}`;
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
    } else {
      isSubmitError = true;
      const resBody = await res.json();
      if (resBody.error) errorMsg = resBody.error;
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
    menubar: "favxs"
  };
</script>

<main>
  <form>
    <div class="title">
      <label for="title:">TITLE:</label>
      <input
        id="title"
        type="text"
        maxlength="60"
        bind:value={title}
        style="border: {onTitleError ? 'solid 1px red' : ''}"
      />
    </div>
    <article class="edit-area" style="border-color: {onValueError ? 'red' : ''}">
      <Editor apiKey="sra0m68u1hvp9tgk2ggky0dmfdf5yvr27x5x543k7ga6he82" bind:value {conf} />
    </article>
    <div class="img-controller">
      {#if imgSrc !== ""}
        <img
          src={!fileToUpload.length ? SERVER_URL + imgSrc : imgSrc}
          alt="failed to load"
          class="img"
        />
      {/if}
      {#if imgSrc || fileToUpload.length}
        <div class="remove-img-button">
          <ButtonText
            buttonFunction={removeImage}
            buttonLabel="Remove image"
            buttonClass="deleteButton"
          />
        </div>
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
          <label class="upload-image" for="files">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="icon icon-tabler icon-tabler-photo-plus"
              width="150"
              height="150"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="#435334"
              fill="none"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path stroke="none" d="M0 0h24v24H0z" fill="none" />
              <path d="M15 8h.01" />
              <path d="M12.5 21h-6.5a3 3 0 0 1 -3 -3v-12a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v6.5" />
              <path d="M3 16l5 -5c.928 -.893 2.072 -.893 3 0l4 4" />
              <path d="M14 14l1 -1c.67 -.644 1.45 -.824 2.182 -.54" />
              <path d="M16 19h6" />
              <path d="M19 16v6" />
            </svg></label
          >
        </div>
      {/if}
    </div>
    <br />
    <div class="submit-controller">
      <button class="cancel-edit" on:click={() => (showEditPopupBox = true)}>Cancel</button>
      <ButtonText
        buttonFunction={handleSubmit}
        disabled={onValueError || onTitleError}
        buttonLabel="Submit"
        buttonClass="confirmButton"
      />
    </div>
  </form>
  <div class="error" style="display:{isSubmitError ? '' : 'none'}">{errorMsg}</div>
  {#if showEditPopupBox}
    <Modal
      showPopupBox={showEditPopupBox}
      description="Do you want to abort your editing?"
      buttons={[
        {
          text: "Continue Editing",
          onClick: () => {
            showEditPopupBox = false;
          }
        }
      ]}
      cancellCallback={() => {
        goto(`/article/${articleId}`);
      }}
      lightText="Yes"
    />
  {/if}
</main>
<PopupBox {popupMessage} {redirectUrl} countdown={3} bind:showPopupBox />

<style>
  .remove-img-button {
    margin-top: 10px;
  }
  .hidden {
    display: none;
  }
  main {
    width: 900px;
    margin: 0 auto;

    & form {
      width: 100%;
    }
  }
  .img {
    width: 70%;
    height: auto;
    margin: 10px;
  }
  .title {
    margin: 20px 0;
    display: flex;
    align-items: center;
  }
  .title > label {
    font-weight: 700;
  }
  #title {
    margin-left: 8px;
    padding: 4px;
    border: none;
    border-bottom: 2px solid #252525;
    width: 390px;
    background-color: transparent;
  }
  #title:focus {
    outline: none;
  }

  .upload-image {
    display: block;
    padding: 16px 0;
    color: #252525;
  }

  .edit-area {
    border: #252525 solid 1px;
  }

  .img-controller {
    display: flex;
    justify-content: center;
    align-items: flex-start;
  }

  .submit-controller {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  button.cancel-edit {
    background-color: transparent;
    border: none;
  }
  .cancel-edit:hover {
    color: #435334;
    text-decoration: underline;
  }
  .error {
    color: red;
    text-align: center;
  }
  @media screen and (max-width: 950px) {
    main {
      width: 500px;
    }
  }
  @media screen and (max-width: 600px) {
    main {
      width: 300px;
    }
  }
</style>
