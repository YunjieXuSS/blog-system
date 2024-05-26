// import { PUBLIC_API_BASE_URL } from "$env/static/public";
import { USER_URL } from "../lib/js/apiUrls.js";



// it won't work untill the relative api is done
export async function load({ fetch }) {
    const response = await fetch(USER_URL, { credentials: "include" });
    if (response.status === 200) return { isLoggedIn: true, user: await response.json()};
    else return { isLoggedIn: false }; 
  }
