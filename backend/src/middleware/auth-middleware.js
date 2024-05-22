// Middleware for authentication
import { getUsernameFromJWT } from "../utils/jwt-utils.js";

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