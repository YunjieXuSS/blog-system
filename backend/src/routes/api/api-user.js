import express from "express";
import { createUser, updateUser } from "../../data/user-dao.js";
import { createUserJWT } from "../../utils/jwt-utils.js";
import { authenticateUser, authenticateAdmin } from "../../middleware/auth-middleware.js";
import {
  getUserWithCredentials,
  getUserWithUserName,
  getUserById,
  getUsers,
  deleteUser
} from "../../data/user-dao.js";
const router = express.Router();
import { avatarUploader } from "../../middleware/image-middleware.js";
import fsExtra from "fs-extra";

// Register user
router.post("/register", avatarUploader, async (req, res) => {
  const user = req.body;
  if (req.file) {
    user.avatar = "/images/" + req.file.filename;
  }
  try {
    const newUser = await createUser(user);
    delete newUser.password;
    if (req.file) {
      await fsExtra.copy(req.file.path, "public" + newUser.avatar);
    }
    return res.status(201).json(newUser);
  } catch (err) {
    console.log(err);
    if (err.errors) return res.status(422).json({ error: err.errors });
    return res.status(409).json({ error: "User already exists." });
  } finally {
    await fsExtra.emptyDir("temp");
  }
});

// Login user
router.post("/login", async (req, res) => {
  const userName = req.body.userName;
  const password = req.body.password;
  if (!userName || !password)
    return res.status(422).json({ error: "Username and password are required." });
  const user = await getUserWithCredentials(userName, password);
  if (!user) return res.status(401).json({ error: "Invalid username or password." });
  delete user.password;
  return res
    .cookie("authToken", createUserJWT(userName), {
      expires: new Date(Date.now() + 24 * 60 * 60 * 1000),
      httpOnly: true
    })
    .json({ user });
});

// User logout
router.post("/logout", (_, res) => {
  return res.clearCookie("authToken").sendStatus(204);
});

// Get user by username ---- Not used
/* router.get("/:userName", async (req, res) => {
  const userName = req.params.userName;
  const user = await getUserWithUserName(userName);
  if (user) {
    delete user.password;
    return res.status(200).json(user);
  } else {
    return res.status(404).json({ error: "User not found." });
  }
}); */

// Get user Info
router.get("/", authenticateUser, (req, res) => {
  const userId = req.user.userId;
  const user = getUserById(userId);
  if (user) {
    delete user.password;
    return res.status(200).json(user);
  } else {
    return res.status(404).json({ error: "User not found." });
  }
});

// Verify user exists
router.get("/:userName", async (req, res) => {
  const userName = req.params.userName;
  const user = await getUserWithUserName(userName);
  if (user) {
    return res.status(200).json({ message: "User exists." });
  } else {
    return res.status(404).json({ error: "User not found." });
  }
});

// Update user
router.patch("/", authenticateUser, avatarUploader, async (req, res) => {
  try {
    const userId = req.user.userId;
    if (req.file) {
      req.body.avatar = "/images/" + req.file.filename;
    }
    const newUser = await updateUser(userId, req.body);
    if (!newUser) return res.status(404).json({ error: "User not found." });
    delete newUser.password;
    if (req.file) {
      await fsExtra.copy(req.file.path, "public" + newUser.avatar);
    }
    res.status(200).json(newUser);
  } catch (err) {
    console.log(err);
    if (err.errors) return res.status(422).json(err.erros);
    return res.status(409).json({ error: "User already exists." });
  } finally {
    await fsExtra.emptyDir("temp");
  }
});

// Get users
router.get("/all", authenticateAdmin, async (req, res) => {
  const users = await getUsers();
  if (!users) return res.status(404).json({ error: "No users found." });
  users.forEach((user) => {
    delete user.password;
  });
  return res.status(200).json(users);
});

// Delete user
router.delete("/", authenticateUser, async (req, res) => {
  try {
    const result = await deleteUser(req.user.userId);
    if (result) return res.sendStatus(204);
    return res.status(404).json({ error: "User not found." });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

// Admin delete user
router.delete("/:userId", authenticateAdmin, async (req, res) => {
  try {
    const result = await deleteUser(req.params.userId);
    if (result) return res.sendStatus(204);
    return res.status(404).json({ error: "User not found." });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

export default router;
