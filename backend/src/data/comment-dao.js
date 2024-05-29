// This file contains the functions for processing requests to the comments API. The comment-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
import { getDatabase } from "./database.js";
import yup from "yup";
import { getArticleById } from "./article-dao.js";
import { get } from "http";

//Create a new comment on an article
const createCommentSchema = yup
  .object({
    content: yup.string().required(),
    parentCommentId: yup.number().optional().nullable(),
    userId: yup.number().required(),
    articleId: yup.number().required()
  })
  .required();
export async function createComment(comment) {
  const newComment = createCommentSchema.validateSync(comment, {
    abortEarly: false,
    stripUnknown: true
  });
  const article = await getArticleById(newComment.articleId);
  if (!article) {
    throw "Article not found.";
  }
  if (newComment.parentCommentId) {
    const parentComment = await getCommentById(newComment.parentCommentId);
    if (
      !parentComment ||
      parentComment.articleId !== newComment.articleId ||
      parentComment.isDeleted
    ) {
      throw "Invalid Parent comment.";
    }
  }
  const db = await getDatabase();
  const dbResult = await db.run(
    "INSERT INTO comment (content, createDate, parentCommentId, userId, articleId) VALUES (?,?,?,?,?)",
    newComment.content,
    Date.now(),
    newComment.parentCommentId,
    newComment.userId,
    newComment.articleId
  );
  newComment.commentId = dbResult.lastID;
  return newComment;
}

export async function getCommentById(commentId) {
  const db = await getDatabase();
  const comment = await db.get("SELECT * FROM comment WHERE commentId = ?", commentId);
  return comment;
}

//Get comments
export async function getComments(articleId) {
  const db = await getDatabase();
  const comments = await db.all(
    "SELECT c.*, u.userName, u.avatar FROM comment c JOIN user u ON c.userId = u.userId WHERE articleId = ?",
    articleId
  );
  return comments;
}

//Delete a comment
export async function deleteComment(commentId, userId) {
  const db = await getDatabase();
  const authorUserId = await db.get("SELECT userId FROM comment WHERE commentId = ?", commentId);
  const articleUserId = await db.get(
    "SELECT userId FROM article WHERE articleId = (SELECT articleId FROM comment WHERE commentId = ?)",
    commentId
  );
  if (authorUserId.userId !== userId && articleUserId.userId !== userId) {
    throw "You are not authorized to delete this comment.";
  }
  let dbResult;
    const isParentComment = await db.get("SELECT * FROM comment WHERE parentCommentId = ?", commentId);
    if (isParentComment) {
      dbResult = await db.run(
        "UPDATE comment SET content = 'This message has been deleted', isDeleted = TRUE WHERE commentId = ? AND isDeleted = FALSE",
        commentId
      );
    } else {
    dbResult = await db.run("DELETE FROM comment WHERE commentId = ?", commentId);
  }
  return dbResult.changes > 0;
}

//Get num of comments on a given article
export async function getNumComments() {
  const db = await getDatabase();
  const comments = await db.get(
    "SELECT COUNT(*) as commentsCount FROM comment WHERE articleId = ?",
    articleId
  );
  return comments;
}
