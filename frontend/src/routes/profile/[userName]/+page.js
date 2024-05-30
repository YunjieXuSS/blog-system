// ---routes/profile/[userName]/+page.js
// pre-load profile and articles data
// API: GET /api/users/username/:userName
// API: GET /api/articles by username/title/createDate i.e https://api.example.com/resource?param1=value1&param2=value2&param3=value3&param4=value4

import { ARTICLES_URL, USER_URL } from "../../../lib/js/apiUrls";
export async function load({ params, fetch }) {
    const userName  = params.userName;
    async function getUserInfo() {
      const res = await fetch(`${USER_URL}/${userName}/info`);
  
      if (res.status === 200) {
        const data = await res.json();
        return data;
      } else {
        throw Error("Failed to fetch user info by username.");
      }
    }
    async function getArticles() {
      const res = await fetch(`${ARTICLES_URL}/search?userName=${userName}`);

      if (res.status === 200) {
        const data = await res.json();
        return data;
        
      } else {
        throw Error("Failed to fetch articles by username.");
      }
    }
  
    let articlesOfUser = {};
    let userInfo = {};
    try {
        articlesOfUser = await getArticles();
        userInfo = await getUserInfo();
    } catch (error) {
      console.error(error);
    }
    return { articlesOfUser, userInfo};
  }