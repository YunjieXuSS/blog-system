import { getUsernameFromJWT } from "../utils/jwt-utils.js";
import { getUserWithUserName } from "../data/user-dao.js";

export async function getUserIdByCookie(req, _, next) {
  if (!req.cookies.authToken) {
    next();
  } else {
    const userName = getUsernameFromJWT(req.cookies.authToken);
    const user = await getUserWithUserName(userName);
    if (!user) {
      next();
    } else {
      req.user = user;
      next();
    }
  }
}
