import {PUBLIC_API_BASE_URL} from "$env/static/public";


//it won't work untill the relative api is done
// export async function load({ fetch }) {

//     //Get the user info
//     const response = await fetch(`{PUBLIC_API_BASE_URL}/login`, { credentials: "include" });
//     if (response.status === 401) return { isLoggedIn: false };
  
//     const user = await response.json();
//     const isLoggedIn = !!user;
//     return { user, isLoggedIn };
//   }