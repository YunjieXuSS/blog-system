// Middleware for authentication
import { getUsernameFromJWT } from "../utils/jwt-utils.js";
import bcrypt from "bcrypt";

export function authenticateUser(req, res, next) {
  if (!req.cookies.authToken) return res.sendStatus(401);
  try {
    const username = getUsernameFromJWT(req.cookies.authToken);
    const user = getUserWithUsername(username);
    if (!user) return res.sendStatus(401);
    req.user = user;
    next();
  } catch (err) {
    return res.sendStatus(401);
  }
}

export function authenticateAdmin(req, res, next) {
  if (!req.cookies.authToken) return res.sendStatus(401);
  try {
    const username = getUsernameFromJWT(req.cookies.authToken);
    const user = getUserWithUsername(username);
    if (!user) return res.sendStatus(401);
    req.user = user;
    if (!user.isAdmin) return res.sendStatus(403);
    req.admin = user;
    next();
  } catch (err) {
    return res.sendStatus(401);
  }
}



export async function createPasswordHashSalt(req, res, next) {
  // Get user's password from req.body
  const password = req.body.password;

  //If  password is null return 404
  if (!password) return res.status(404).json(`Password not found!`);

  //test code
  // console.log(password)

  //create salt and hash
  const password_salt = bcrypt.genSaltSync(12);
  const password_hash = await bcrypt.hash(password, password_salt);

  //test code
  // console.log(password_salt,password_hash)


  //Return salt and hash
  req.password_salt = password_salt;
  req.password_hash = password_hash;
  return next();

}



export async function createPasswordHashSalt(req, res, next) {
  // Get user's password from req.body
  const password = req.body.password;

  //If  password is null return 404
  if (!password) return res.status(404).json(`Password not found!`);

  //test code
  // console.log(password)

  //create salt and hash
  const password_salt = bcrypt.genSaltSync(12);
  const password_hash = await bcrypt.hash(password, password_salt);

  //test code
  // console.log(password_salt,password_hash)


  //Return salt and hash
  req.password_salt = password_salt;
  req.password_hash = password_hash;
  return next();

}