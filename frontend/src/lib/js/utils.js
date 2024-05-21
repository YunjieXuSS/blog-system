import {PUBLIC_API_BASE_URL} from "$env/static/public";


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

//test code
// postPassword();