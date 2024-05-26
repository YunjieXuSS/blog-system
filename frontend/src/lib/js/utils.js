import { PUBLIC_API_BASE_URL } from "$env/static/public";
import { writable } from "svelte/store";
export const articles = [];
export const articleStore = writable(articles);

export async function checkUserIsRegisterd(userName) {
    //test code
    //get password from argument,pass it in POST Fetch method, and get the result back
    const result = await fetch(`${PUBLIC_API_BASE_URL}/users/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ password })
    })
    return result;

}


export async function searchArticles(articleStore, selectedCategory, searchTerm) {
    // console.log("Start Searching Articles");
    let response;

    if (searchTerm!=="") {
         response = await fetch(
            `${PUBLIC_API_BASE_URL}/articles/search?${selectedCategory}=${searchTerm}`,
            {
                method: "GET"
            }
        );
    } else {
         response = await fetch(
            `${PUBLIC_API_BASE_URL}/articles/`,
            {
                method: "GET"
            }
        );
    }
    const articles = await response.json();
    articleStore.set(articles);
}

export async function refreshPage(articleStore) {
    // console.log("refresh page start");
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/`);
    if (!response) return;//have to add some solution here
    const articles = await response.json();
    articleStore.set(articles);
    return articles;
}

export async function createAccount(user) {
    //test code
    //get password from argument,pass it in POST Fetch method, and get the result back
    console.log("createAccount", user);
    const result = await fetch(`${PUBLIC_API_BASE_URL}/users/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(user)
    })
    return result;

}