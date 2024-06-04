import { PUBLIC_API_BASE_URL } from "$env/static/public";
import { writable, get} from "svelte/store";
export const articles = [];
export const articleStore = writable(articles);
import {queryStore} from "$lib/js/store.js";
import {USER_URL} from "$lib/js/apiUrls.js";


export async function checkUserIsRegisterd(userName) {
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
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles?${queryStatement}`, {credentials: "include"});
    if(response.status=== 200) {
        const articles = await response.json();
        articleStore.set(articles);
    }
}

export async function createAccount(user) {
    const result = await fetch(`${USER_URL}/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(user)
    })
    return result;
}