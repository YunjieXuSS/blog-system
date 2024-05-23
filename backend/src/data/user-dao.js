// This file contains the functions for processing requests to the user API. 
//The user-dao.js file is responsible for interacting with the database and performing the necessary operations to process the requests.
import yup from "yup";
import { getDatabase } from "./database.js";
import bcrypt from "bcrypt";

export async function getUserWithCredentials(username, password) {
  const db = await getDatabase();
  const user = await db.get("SELECT * from user WHERE username = ?", username );
  if (!user) return;
  console.log("user: ", user);
  const isValid = await bcrypt.compare(password, user.password);
  console.log("isValid: ", isValid);
  return isValid ? user : undefined;
}

export function createUser(user) {
  // ...
}

export function getUserById(userId) {
  // ...
}

/**
 * Gets the user with the given username, if it exists.
 *
 * @param {string} username the username to search
 * @returns the user with the matching username, or undefined.
 */
export async function getUserWithUsername(username) {
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