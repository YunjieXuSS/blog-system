import { PUBLIC_API_BASE_URL } from "$env/static/public";
import { writable, get} from "svelte/store";
export const articles = [];
export const articleStore = writable(articles);
import {queryStore} from "./store.js";
import {USER_URL} from "./apiUrls.js";


export async function checkUserIsRegisterd(userName) {
    //test code
    //get password from argument,pass it in POST Fetch method, and get the result back
    const response = await fetch(`${USER_URL}/${userName}`, {
        method: "GET",
    })
    const result = await response.json();
    return result;

}


export async function searchArticles() {
    const query = get(queryStore);
    let queryList = [];
    Object.keys(query).forEach((key)=>{
        if(query[key]!==undefined) queryList.push(`${key}=${query[key]}`);
    });
    const queryStatement = queryList.join("&");
    console.log("my final query statement",queryStatement);
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles?${queryStatement}`);
    if(response.status=== 200) {
        const articles = await response.json();
        articleStore.set(articles);
    }
    
}

// export async function refreshPage(articleStore) {
//     const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/`);
//     if (!response) return;//have to add some solution here
//     const articles = await response.json();
//     articleStore.set(articles);
//     return articles;
// }

export async function createAccount(user) {
    //test code
    //get password from argument,pass it in POST Fetch method, and get the result back
    const result = await fetch(`${USER_URL}/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(user)
    })
    return result;

}