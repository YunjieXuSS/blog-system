<script lang="ts">
    import Editor from '@tinymce/tinymce-svelte';
    export let text = '';
    let value = 'some content';

    function handleSubmit() {
        console.log(text);
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
    menubar: 'favs file edit view insert format tools table help',
    
	};

    </script>



    <main>



        
        <form on:submit|preventDefault={handleSubmit}>
      <Editor
        apiKey="sra0m68u1hvp9tgk2ggky0dmfdf5yvr27x5x543k7ga6he82"
        bind:text
        bind:value
        {conf}
      />
     
    
    <button type="submit">Submit</button>
    </form>
    </main>


