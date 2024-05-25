// This file contains the functions for processing requests to the comments API. The comment-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
import { getDatabase } from "./database.js";

//Create a new comment on an article
export async function createComment(userId, articleId, parentCommentId) {
    const db = await getDatabase();
    const dbResult = await db.run("INSERT INTO comment (content, createDate, parentCommentId, userId, articleId, isDeleted) VALUES (?,?,?,?,?,?)",
        content,
        createDate,
        parentCommentId,
        userId,
        articleId,
        isDeleted
    );
    return dbResult.changes > 0;
}

export async function getComments(articleId) {
    const db = await getDatabase();
    const comment = await db.all("SELECT * FROM comment WHERE articleId = ?", parseInt(articleId));
    return comment;
}

//Delete a comment
export async function deleteComment(commentId) {
    const db = await getDatabase();
    const dbResult = await db.run("UPDATE comment SET content = 'This message has been deleted', isDeleted = 'TRUE' WHERE commentID = ?", commentId,);
    return dbResult.changes > 0;
}