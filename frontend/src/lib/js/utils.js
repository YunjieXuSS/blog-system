import {PUBLIC_API_BASE_URL} from "$env/static/public";
import { writable } from "svelte/store";
export const articles =[ {
    articleId: 1,
    title: 'Understanding Flexbox: Everything you need to know',
    content: 'Flexbox is a powerful layout module...',
    createDate: '2024-01-01',
    updateDate: '2024-01-02',
    imgUrl: 'img1.jpg',
    userId: 1
}];
export const articleStore = writable(articles);

export async function getPasswordHashSalt(user_password) {

    //test code
    // console.log(user_password);
    // console.log(PUBLIC_API_BASE_URL);

    //get password from argument,pass it in POST Fetch method, and get the result back
    const password = user_password;
    const result = await fetch(`${PUBLIC_API_BASE_URL}/users/register`,{
        method:"POST",
        headers: { "Content-Type": "application/json" },
        body:JSON.stringify({password})
    })
    return result;

}


export async function searchArticles(articleStore,selectedCategory, searchTerm) {
    console.log("Start Searching Articles");
    const response = await fetch(
      `${PUBLIC_API_BASE_URL}/articles/search?${selectedCategory}=${searchTerm}`,
      {
        method: "GET"
      }
    );
    const articles = await response.json();
    // testing code
    // console.log(articles);
    articleStore.set(articles);
    // testing code
    // console.log("store in articleStore",$articleStore);
    return articleStore;
  }

  export async function refreshPage(articleStore) {
    console.log("refresh page start");
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/`);
    if(!response) return ;//have to add some solution here
    const articles = await response.json();
    // testing coded
    // console.log(articles);
    articleStore.set(articles);
    // console.log(articles);
    return articleStore;
  }

