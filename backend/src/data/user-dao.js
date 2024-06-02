/**
 * This file contains the functions for processing requests to the user API.
 * The user-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
 */

import yup from "yup";
import { getDatabase } from "./database.js";
import bcrypt from "bcrypt";
import { createPasswordHashSalt } from "../utils/hash-utils.js";

/**
 * Retrieves a user from the database using the provided username and password.
 *
 * @param {string} username - The username of the user to retrieve.
 * @param {string} password - The password of the user to retrieve.
 * @returns {Promise<Object|undefined>} - A promise that resolves to the user object if the credentials are valid, or undefined if the user is not found or the credentials are invalid.
 */
export async function getUserWithCredentials(username, password) {
  const db = await getDatabase();
  const user = await db.get("SELECT * from user WHERE username = ?", username);
  if (!user) return;
  user.isAdmin = !!user.isAdmin;
  const isValid = await bcrypt.compare(password, user.password);
  return isValid ? user : undefined;
}

/**
 * This schema defines a valid "create user" request.
 * These requests must have a userName, password, email, fisrtName, lastName, dateOfBirth and avatar(URL). Description is optional.
 */
const createUserSchema = yup
  .object({
    userName: yup.string().min(3).max(20).trim().required(),
    password: yup.string().min(8).max(20).required(),
    email: yup.string().required(),
    firstName: yup.string().trim().required(),
    lastName: yup.string().trim().required(),
    dateOfBirth: yup.date().required(),
    avatar: yup.string().required(),
    description: yup.string().optional()
  })
  .required();

export async function createUser(user) {
  const newUser = createUserSchema.validateSync(user, {
    abortEarly: false,
    stripUnknown: true
  });

  // Insert new user into database
  const db = await getDatabase();
  newUser.password = await createPasswordHashSalt(newUser.password);
  if (newUser.description === undefined) newUser.description = "I know myself so well.";
  const dbResult = await db.run(
    "INSERT INTO user(userName, password, email, firstName, lastName, dateOfBirth, avatar, description ) VALUES(?, ?, ?, ?, ?, ?, ?, ?)",
    newUser.userName,
    newUser.password,
    newUser.email,
    newUser.firstName,
    newUser.lastName,
    newUser.dateOfBirth,
    newUser.avatar,
    newUser.description
  );

  // Give the returned user an ID, which was created by the database, then return.
  newUser.userId = dbResult.lastID;
  return newUser;
}

export async function getUserById(userId) {
  const db = await getDatabase();
  return await db.get("SELECT * from user WHERE userId = ?", userId);
}

/**
 * Gets the user with the given username, if it exists.
 *
 * @param {string} userName the username to search
 * @returns the user with the matching username, or undefined.
 */
export async function getUserWithUserName(userName) {
  const db = await getDatabase();
  let user = await db.get("SELECT * from user WHERE userName = ?", userName);
  if(user){
  const numOfPosts = await db.get("SELECT COUNT(*) as numOfPosts FROM article WHERE userId = ?", user.userId);
  const numOfLikes = await db.get("SELECT COUNT(*) as numOfLikes FROM like WHERE articleId IN (SELECT articleId FROM article WHERE userId =?)", user.userId);
  user = {...user, ...numOfPosts, ...numOfLikes};
}
  if (user) delete user.password;
  return user;
}

/**
 * Retrieves an array of all users.
 *
 * @returns an array of all users
 */
export async function getUsers() {
  const db = await getDatabase();
  const users = await db.all("SELECT * FROM user");
  users.forEach((user) => {
    user.isAdmin = !!user.isAdmin;
  });
  return users;
}

const updateUserSchema = yup
  .object({
    userName: yup.string().min(3).max(20).trim().optional(),
    password: yup.string().min(8).max(20).optional(),
    email: yup.string().optional(),
    firstName: yup.string().trim().optional(),
    lastName: yup.string().trim().optional(),
    dateOfBirth: yup.date().optional(),
    avatar: yup.string().optional(),
    description: yup.string().optional()
  })
  .required();

export async function updateUser(userId, udpateData) {
  // Find the user with the given id, get outta here if doesn't exist.
  const db = await getDatabase();
  const user = db.get("SELECT * FROM user WHERE userId = ?", userId);
  if (!user) return false;

  // Validate incoming data (throw error if invalid)
  const parsedUpdateData = updateUserSchema.validateSync(udpateData, {
    abortEarly: false,
    stripUnknown: true
  });
  if(parsedUpdateData.password) parsedUpdateData.password = await createPasswordHashSalt(parsedUpdateData.password);

  // Do the update
  if(!parsedUpdateData) return;
  const setStatement = Object.keys(parsedUpdateData)
    .map((key) => `${key} = ?`)
    .join(", ");
  await db.run(`UPDATE user SET ${setStatement} WHERE userId = ?`, [
    ...Object.values(parsedUpdateData),
    userId
  ]);
  return getUserById(userId);
}

/**
 * Deletes the user with the given id, if any.
 *
 * @param {*} id the id of the user to delete. Will be converted to a number using parseInt().
 * @return true if a user was deleted, false otherwise.
 */
export async function deleteUser(userId) {
  const db = await getDatabase();
  const dbResult = await db.run("DELETE FROM user WHERE userId = ? AND isAdmin = FALSE", parseInt(userId));
  return dbResult.changes > 0;
}
