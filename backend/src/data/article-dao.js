// This file contains the functions for processing requests to the article API and their comments and likes.
// The article-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
import { getDatabase } from "./database.js";
import yup from "yup";

/**
 * This schema defines a valid "create article" request.
 * These requests must have a title, content and createDate. Uploading image is optional.
 */
const createArticleSchema = yup
  .object({
    title: yup.string().required(),
    content: yup.string().required(),
    createDate: yup.date().default(() => new Date()), // Setting default value to current date
    imgUrl: yup.string().optional()
  })
  .required();

/**
 * Creates a new article and returns it. Throws an error if any of the required data is undefined.
 *
 * @param {any} articleData Must contain a title, content, and createDate.
 *
 * @returns the newly created article
 * @throws an error if the input does not contain the required data.
 */
export async function createArticle(articleData) {
  const newArticle = createArticleSchema.validateSync(articleData, {
    abortEarly: false,
    stripUnknown: true
  });

  // Insert new article into database
  const db = await getDatabase();
  const dbResult = await db.run(
    "INSERT INTO article(title, content, createDate, updateDate, userId) VALUES(?, ?, ?, ?,?)",
    newArticle.title,
    newArticle.content,
    newArticle.createDate,
    newArticle.userId
  );

  // Give the returned article an ID, which was created by the database, then return.
  newArticle.articleId = dbResult.lastID;
  return newArticle;
}

/**
 * Retrieves an array of all articles.
 *
 * @returns an array of all articles
 */
export async function getArticles(pageSize = 10, pageNumber = 1) {
  const db = await getDatabase();
  const offset = (pageNumber - 1) * pageSize;
  const articles = await db.all("SELECT * FROM article LIMIT ? OFFSET ?", pageSize, offset);
  return articles;
}

export async function getArticlesByUserId(userId) {
  const db = await getDatabase();
  const articlesOfUser = await db.all("SELECT * FROM article WHERE userId = ?", parseInt(userId));
  console.log(articlesOfUser);
  return articlesOfUser;
}

export async function getArticlesByTitle(title) {
  const db = await getDatabase();
  const lowercaseTitle = title.toLowerCase();
  const articles = await db.all(
    "SELECT * FROM article WHERE LOWER(title) LIKE ?",
    `%${lowercaseTitle}%`
  );

  return articles;
}

export async function getArticlesByContent(content) {
  const db = await getDatabase();
  const lowercaseContent = content.toLowerCase();
  const articles = await db.all(
    "SELECT * FROM article WHERE LOWER(content) LIKE ?",
    `%${lowercaseContent}%`
  );

  return articles;
}

export async function getArticlesByDate(createDate) {
  const db = await getDatabase();
  const articles = await db.all("SELECT * FROM article WHERE DATE(createDate) = ?", [createDate]);
  return articles;
}

/**
 * Retrieves an article with the matching id. Returns undefined if no match.
 * @param {*} id the id to match. Will be converted to a number using parseInt().
 * @returns a specific article, or undefined.
 */
export async function getArticlesById(articleId) {
  const db = await getDatabase();
  const article = await db.get("SELECT * FROM article WHERE articleId = ?", parseInt(articleId));
  return article;
}

export async function getArticlesByUserName(userName) {
  console.log("dao-username",userName)
  const db = await getDatabase();
  // SQL query to join user and article tables and fetch articles by userName
  const articles = await db.all(
    "SELECT a.* FROM article AS a JOIN user AS u ON a.userId = u.userId WHERE u.userName like ?",
    `%${userName}%`
  );
  return articles;
}

/**
 * This schema defines a valid "update article" request.
 * We can update as many or as few of values as we like.
 */
const updateArticleSchema = yup
  .object({
    title: yup.string().min(1).optional(),
    content: yup.string().min(1).optional(),
    createDate: yup.date().default(() => new Date()), // Setting default value to current date
    imgUrl: yup.string().optional()
  })
  .required();

/**
 * Updates the article with the given id, if it exists and the provided update data is valid.
 *
 * @param {*} articleId the id to match. Will be converted to a number using parseInt().
 * @param {*} updateData The data to update. Any included title, content, createDate and imgUrl properties
 *            will replace those existing values for the matching article. Any other properties will be ignored.
 *
 * @return true if the database was updated, false otherwise.
 * @throws an error if updateData contains invalid data.
 */
export async function updateArticle(articleId, updateData) {
  //Validated update data (will throw exception if updateData is invalid).
  const validatedUpdateData = updateArticleSchema.validateSync(updateData, {
    abortEarly: true,
    stripUnknown: true
  });

  // Build the update statement. title, content, and imgUrl are all optional so we can't just write one SQL query
  // that updates all three, if all three aren't used. We must consider each one one-by-one.
  const updateOperations = [];
  const updateParams = [];
  if (validatedUpdateData.title) {
    updateOperations.push("title = ?");
    updateParams.push(validatedUpdateData.title);
  }
  if (validatedUpdateData.content) {
    updateOperations.push("content = ?");
    updateParams.push(validatedUpdateData.content);
  }
  if (validatedUpdateData.imgUrl) {
    updateOperations.push("imgUrl = ?");
    updateParams.push(validatedUpdateData.imgUrl);
  }

  // If we aren't actually updating anything just get outta here.
  if (updateParams.length === 0) return false;

  // Build actual SQL statement
  const sql = `UPDATE article SET ${updateOperations.join(", ")} WHERE articleId = ?`;
  console.log(sql);

  // Execute SQL
  const db = await getDatabase();
  const dbResult = await db.run(sql, ...updateParams, parseInt(articleId));

  // Return true if changes were made, false otherwise.
  return dbResult.changes > 0;
}

/**
 * Deletes the article with the given id, if any.
 *
 * @param {*} articleId the id of the article to delete. Will be converted to a number using parseInt().
 * @return true if an article was deleted, false otherwise.
 */
export async function deleteArticle(articleId) {
  const db = await getDatabase();
  const dbResult = await db.run("DELETE FROM article WHERE articleId = ?", parseInt(articleId));
  return dbResult.changes > 0;
}

//Like an article
export async function likeArticle(userId, articleId) {
  const db = await getDatabase();
  const dbResult = await db.run("INSERT INTO like (userId, articleId) VALUES (?,?)", userId, articleId);
  return dbResult.changes > 0;
}

//Unlike an article
export async function unlikeArticle(userId, articleId) {
  const db = await getDatabase();
  const dbResult = await db.run("DELETE FROM like WHERE userId = ? AND articleId = ?", userId, articleId);
  return dbResult.changes > 0;
}