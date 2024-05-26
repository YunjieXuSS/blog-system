<script>
    import Editor from '@tinymce/tinymce-svelte';
    export let article;
    $: title = article.title;
    $: value = article.content;

    function handleSubmit() {
        console.log(value);
    }

    $: console.log(value);

    // /** @type {import('tinymce').RawEditorOptions} */
    const conf = {
        plugins: [
      'advlist', 'autolink', 'link', 'image', 'lists', 'charmap', 'preview', 'anchor', 'pagebreak',
      'searchreplace', 'wordcount', 'visualblocks', 'visualchars', 'code', 'fullscreen', 'insertdatetime',
      'media', 'table', 'emoticons', 'help'
    ],
    toolbar: 'undo redo | styles | bold italic | alignleft aligncenter alignright alignjustify | ' +
      'bullist numlist outdent indent | link image | print preview media fullscreen | ' +
      'forecolor backcolor emoticons | help',
    menu: {
      favs: { title: 'My Favorites', items: 'code visualaid | searchreplace | emoticons' }
    },
    menubar: 'favxs file edit view insert format tools table help',
    
    };

    </script>



    <main>
        <form on:submit|preventDefault={handleSubmit}>
            <div class="title">
            <label for="title:">TITLE:</label>
            <input id="title" type="text" bind:value={title}/></div>
      <Editor
        apiKey="sra0m68u1hvp9tgk2ggky0dmfdf5yvr27x5x543k7ga6he82"
        bind:value
        {conf}
      />
     
    
    <button type="submit">Submit</button>
    </form>
    </main>