import express from "express";
const router = express.Router();
import { authenticateAdmin } from "../../middleware/auth-middleware.js";
import { getUsers } from "../../data/user-dao.js";

// Get users
router.get("/", authenticateAdmin, async (req, res) => {
    const users = await getUsers();
    if (!users) return res.status(404).json({ error: "No users found." });
    users.forEach((user) => {
      delete user.password;
    });
    return res.status(200).json(users);
  });

export default router;