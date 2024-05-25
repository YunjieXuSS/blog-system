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
  const user = await db.get("SELECT * from user WHERE username = ?", username );
  if (!user) return;
  console.log("user: ", user);
  const isValid = await bcrypt.compare(password, user.password);
  console.log("isValid: ", isValid);
  return isValid ? user : undefined;
}

/**
 * This schema defines a valid "create user" request.
 * These requests must have a userName, password, email, fisrtName, lastName, dateOfBirth and avatar(URL). Description is optional.
 */
const createUserSchema = yup
  .object({
    userName: yup.string().min(3).trim().required(),
    password: yup.string().min(8).required(),
    email: yup.string().required(),
    firstName: yup.string().trim().required(),
    lastName: yup.string().trim().required(),
    dateOfBirth: yup.date().required(),
    avatar: yup.string().required(),
    description: yup.string().optional(),
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
export async function getUserWithUserName(username) {
  const db = await getDatabase();
  return await db.get("SELECT * from user WHERE userName = ?", username);
}

/**
 * Retrieves an array of all users.
 *
 * @returns an array of all users
 */
export async function getUsers() {
  const db = await getDatabase();
  const users = await db.all("SELECT * FROM user");
  return users;
}


export function updateUser(id, user) {
  // ...
}


/**
 * Deletes the user with the given id, if any.
 *
 * @param {*} id the id of the user to delete. Will be converted to a number using parseInt().
 * @return true if a user was deleted, false otherwise.
 */
export async function deleteUser(userId) {
  const db = await getDatabase();
  const dbResult = await db.run("DELETE FROM user WHERE userId = ?", parseInt(userId));
  return dbResult.changes > 0;
}