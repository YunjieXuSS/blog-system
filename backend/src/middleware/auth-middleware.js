// Middleware for authentication
import { getUsernameFromJWT } from "../utils/jwt-utils.js";
import bcrypt from "bcrypt";

export function authenticateUser(req, res, next) {
  // ...
}

export function authenticateAdmin(req, res, next) {
  // ...
}



export async function createPasswordHashSalt(req, res, next) {
  // ...
  const password = req.body.password;

  if (!password) return res.status(404).json(`Password not found!`);

  console.log(password)
  const password_salt = bcrypt.genSaltSync(12);
  const password_hash = await bcrypt.hash(password, password_salt);
  console.log(password_salt,password_hash)

  req.password_salt = password_salt;
  req.password_hash = password_hash;
  return next();

}