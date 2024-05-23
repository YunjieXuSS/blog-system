import { getUserWithUsername } from "../data/user-dao.js";
export async function verifyUserExists(req, res, next) {
    const userName = req.body.userName;
    if(!userName) return res.status(422).json({ error: "Username is required." });
    const user = await getUserWithUsername(userName);
    if (user) return res.status(409).json({ error: "User already exists." });
    next();
}