// This file contains the functions for processing requests to the article API and their comments and likes. 
//The article-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
import { getDatabase } from "./database.js";
export function createArticle(articleData) {
    // ...
  }
  
// Get a list of articles with optional search and sort
export function getArticles({ search, sort, pageSize = 10, pageNumber = 1 }){
    // ...
}

// Get details of a specific article
export function getArticleById(articleId){
    //...
}

// Edit/Update an existing article
export function editArticle(articleId){
    //...
}

//Delete an article
export function deleteArticle(articleId){
    //...
}

//Like an article
export function likeArticle(articleId){
    //...
}

//Unlike an article
export function unlikeArticle(articleId){
    //...
}