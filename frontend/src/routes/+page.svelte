<script>
  import ArticleCard from "../lib/components/ArticleCard.svelte";
 const article1 = {
    title: "hello",
    imgUrl: "./images/pexels-busra-yaman-54874398-23600785.jpg",
    userName:"Luna_Chen",
    createDate:"2024-05-20",
    content: "dwdjefhfi chehh etey sjskwa jcdueh dcs la;eid nid nwid shia shd This property allows long words to be broken and wrapped onto the next line. This is particularly useful for preventing long URLs or unbreakable strings from overflowing their container."
 };
 const article2 = {
   title: "hello",
    imgUrl: "./favicon.png",
    userName:"Luna_Chen",
    createDate:"2024-05-20",
    content: "dwdjefhfi chehh etey sjskwa jcdueh dcs la;eid nid nwid shia shd This property allows long words to be broken and wrapped onto the next line. This is particularly useful for preventing long URLs or unbreakable strings from overflowing their container."
 };
</script>
// ---/routes/+page.svelte
// This file is our homepage. It displays sort bar and list of articles.
<ArticleCard article = {article1} />
<ArticleCard article = {article2} />