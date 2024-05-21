// This file contains the functions for processing requests to the comments API. The comment-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
import { getDatabase } from "./database.js";

//Create a new comment on an article
export function createComment(articleId, parentCommentID){
    //...
}

export function getComments(articleId){
    //...
}

//Delete a comment
export function deleteComment(articleId, parentCommentID, commentID){
    //...
}