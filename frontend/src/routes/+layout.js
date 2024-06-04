import { USER_URL } from "$lib/js/apiUrls.js";

export async function load({ fetch }) {
    const response = await fetch(USER_URL, { credentials: "include" });
    if (response.status === 200) return { isLoggedIn: true, user: await response.json()};
    else return { isLoggedIn: false }; 
  }
