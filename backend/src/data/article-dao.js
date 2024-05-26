// This file contains the functions for processing requests to the article API and their comments and likes.
// The article-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
import { start } from "repl";
import { getDatabase } from "./database.js";
import yup from "yup";

const getArticleSchema = yup
  .object({
    title: yup.string().optional(),
    userName: yup.string().optional(),
    startDate: yup.date().optional(),
    endDate: yup.date().optional(),
    sortBy: yup
      .string()
      .oneOf(["title", "userName", "createDate"])
      .default("createDate")
      .optional(),
    sortOrder: yup.number().oneOf([0, 1]).default(1).optional()
  })
  .required();
export async function getArticlesByKeywords(query) {
  const validatedQuery = getArticleSchema.validateSync(query, {
    abortEarly: false,
    stripUnknown: true
  });

  const { title, userName, startDate, endDate, sortBy, sortOrder } = validatedQuery;
  const values = [];
  let sql = "SELECT a.*, u.userName, u.avatar FROM article a JOIN user u WHERE a.userId = u.userId";
  if (title) {
    sql += " AND title LIKE ?";
    values.push(`%${title}%`);
  }

  if (userName) {  
    sql += " AND a.userId in (SELECT userId FROM user WHERE userName LIKE ?)";
    values.push(`%${userName}%`);
  }

  if (startDate) {
    sql += " AND createDate >= ?";
    values.push(startDate);
  }
  if (endDate) {
    sql += " AND createDate <= ?";
    values.push(endDate);
  }
  sql += ` ORDER BY ${sortBy} ${sortOrder === 1 ? "DESC" : "ASC"}`;
  console.log("sql", sql);
  console.log("values", values);
  const db = await getDatabase();
  const articles = await db.all(sql, values);

  return articles;
}
/**
 * Retrieves an array of all articles.
 * 10 articles in a page and displaying descendingly
 * @returns an array of all articles
 */
export async function getArticles(pageSize = 10, pageNumber = 1) {
  const db = await getDatabase();
  const offset = (pageNumber - 1) * pageSize;
  console.log(222);
  const articles = await db.all(
    `SELECT a.*, u.userName, u.userId FROM article a JOIN user u ON a.userId = u.userId ORDER BY a.createDate DESC 
    LIMIT ? OFFSET ?`,
    pageSize,
    offset
  );
  return articles;
}

//Get all articles and display them ascendingly base on their updateDate
//from oldest to the newest
export async function sortArticlesAsce(pageSize = 10, pageNumber = 1) {
  const db = await getDatabase();
  const offset = (pageNumber - 1) * pageSize;
  const articles = await db.all(
    "SELECT * FROM article ORDER BY updateDate ASC LIMIT ? OFFSET ?",
    pageSize,
    offset
  );
  return articles;
}

export async function getArticlesByUserId(userId) {
  const db = await getDatabase();
  const articlesOfUser = await db.all(
    `SELECT article.articleId, article.title, article.content, article.createDate, article.updateDate, article.imgUrl, user.userId, user.userName 
     FROM article 
     INNER JOIN user ON article.userId = user.userId WHERE userId = ?`,
    parseInt(userId)
  );
  return articlesOfUser;
}

export async function getArticlesByTitle(title) {
  const db = await getDatabase();
  const lowercaseTitle = title.toLowerCase();
  const articles = await db.all(
    `SELECT article.articleId, article.title, article.content, article.createDate, article.updateDate, article.imgUrl, user.userId, user.userName 
     FROM article 
     INNER JOIN user ON article.userId = user.userId WHERE title LIKE ?`,
    `%${lowercaseTitle}%`
  );

  return articles;
}

export async function getArticlesByContent(content) {
  const db = await getDatabase();
  const lowercaseContent = content.toLowerCase();
  const articles = await db.all(
    `SELECT article.articleId, article.title, article.content, article.createDate, article.updateDate, article.imgUrl, user.userId, user.userName 
    FROM article 
    INNER JOIN user ON article.userId = user.userId WHERE content LIKE ?`,
    `%${lowercaseContent}%`
  );

  return articles;
}

export async function getArticlesByDate(createDate) {
  const db = await getDatabase();
  const articles = await db.all(
    `SELECT article.articleId, article.title, article.content, article.createDate, article.updateDate, article.imgUrl, user.userId, user.userName 
  FROM article 
  INNER JOIN user ON article.userId = user.userId WHERE DATE(createDate) = ?`,
    [createDate]
  );
  return articles;
}

/**
 * Retrieves an article with the matching id. Returns undefined if no match.
 * @param {*} id the id to match. Will be converted to a number using parseInt().
 * @returns a specific article, or undefined.
 */
export async function getArticleById(articleId) {
  const db = await getDatabase();
  const article = await db.get(
    `SELECT article.articleId, article.title, article.content, article.createDate, article.updateDate, article.imgUrl, user.userId, user.userName 
  FROM article 
  INNER JOIN user ON article.userId = user.userId WHERE  articleId = ?`,
    parseInt(articleId)
  );
  return article;
}

export async function getArticlesByUserName(userName) {
  console.log("dao-username", userName);
  const db = await getDatabase();
  const lowercaseUserName = userName.toLowerCase();
  // SQL query to join user and article tables and fetch articles by userName
  const articles = await db.all(
    `SELECT article.articleId, article.title, article.content, article.createDate, article.updateDate, article.imgUrl, user.userId, user.userName 
    FROM article 
    INNER JOIN user ON article.userId = user.userId WHERE LOWER(u.userName) LIKE ?`,
    `%${lowercaseUserName}%`
  );
  return articles;
}

/**
 * This schema defines a valid "create article" request.
 * These requests must have a title, content and createDate. Uploading image is optional.
 */
const createArticleSchema = yup
  .object({
    title: yup.string().required(),
    content: yup.string().required(),
    createDate: yup.date().default(() => new Date()), // Setting default value to current date
    updateData: yup.date().default(() => new Date()),
    imgUrl: yup.string().optional(),
    userId: yup.number().required()
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
  ("SELECT * FROM user WHERE userId = ?");
  if (!articleData.userId) {
    throw new Error("You need to log in before creating an article.");
  }
  if (newArticle.imgUrl === undefined) newArticle.imgUrl = null;

  const dbResult = await db.run(
    "INSERT INTO article(title, content, createDate, updateDate, imgUrl, userId) VALUES(?, ?, ?, ?,?,?)",
    newArticle.title,
    newArticle.content,
    newArticle.createDate,
    newArticle.updateData,
    newArticle.imgUrl,
    newArticle.userId
  );
  console.log("Article created successfully");

  // Give the returned article an ID, which was created by the database, then return.
  newArticle.articleId = dbResult.lastID;
  return newArticle;
}

/**
 * This schema defines a valid "update article" request.
 * We can update as many or as few of values as we like.
 */
const updateArticleSchema = yup
  .object({
    title: yup.string().min(1).optional(),
    content: yup.string().min(1).optional(),
    updateDate: yup.date().default(() => new Date()), // Setting default value to current date
    imgUrl: yup.string().optional(),
    userId: yup.number().required()
  })
  .required();

/**
 * Updates the article with the given id, if it exists and the provided update data is valid.
 *
 * @param {*} articleId the id to match. Will be converted to a number using parseInt().
 * @param {*} updateData The data to update. Any included title, content, updateDate and imgUrl properties
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
  const dbResult = await db.run(sql, [...updateParams, parseInt(articleId)]);

  // Return updated content if changes were made, false otherwise.
  if (dbResult.changes > 0)
    return db.get("Select * FROM article WHERE articleId = ?", parseInt(articleId));
  return false;
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
  const dbResult = await db.run(
    "INSERT INTO like (userId, articleId) VALUES (?,?)",
    userId,
    articleId
  );
  return dbResult.changes > 0;
}

//Unlike an article
export async function unlikeArticle(userId, articleId) {
  const db = await getDatabase();
  const dbResult = await db.run(
    "DELETE FROM like WHERE userId = ? AND articleId = ?",
    userId,
    articleId
  );

  return dbResult.changes > 0;
}
