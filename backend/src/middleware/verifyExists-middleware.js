import { getUserWithUserName } from "../data/user-dao.js";
import fsExtra from "fs-extra";

export async function verifyUserExists(req, res, next) {
  const userName = req.body.userName;
  if (!userName) {
    await fsExtra.emptyDir("temp");
    return res.status(422).json({ error: "Username is required." });
  }
  const user = await getUserWithUserName(userName);
  if (user) {
    await fsExtra.emptyDir("temp");
    return res.status(409).json({ error: "User already exists." });
  }
  next();
}
