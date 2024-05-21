import {PUBLIC_API_BASE_URL} from "$env/static/public"


export async function postPassword(user_password) {
    console.log(user_password);
    const password = user_password;
    const result = await fetch(`http://localhost:3000/api/users/register`,{
        method:"POST",
        headers: { "Content-Type": "application/json" },
        body:JSON.stringify({password})
    })
    return result;

}

postPassword();