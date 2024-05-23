import { PUBLIC_API_BASE_URL } from "$env/static/public";
import{ARTICLES_URL} from "../lib/js/apiUrls.js";



//it won't work untill the relative api is done
// export async function load({ fetch }) {

//     //Get the user info
//     const response = await fetch(`{PUBLIC_API_BASE_URL}/login`, { credentials: "include" });
//     if (response.status === 401) return { isLoggedIn: false };

//     const user = await response.json();
//     const isLoggedIn = !!user;
//     return { user, isLoggedIn };
//   }


// export async function load({ fetch }) {
//     console.log("Start Searching Articles");
//     const response = await fetch(`${ARTICLES_URL}`, {
//         method: "GET",
//     });
//     const articles = await response.json();
//     console.log(articles);
//     return { articles };
// }