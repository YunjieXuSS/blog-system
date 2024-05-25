import express from "express";
import { createUser } from "../../data/user-dao.js";
import { createUserJWT } from "../../utils/jwt-utils.js";
import { authenticateUser, authenticateAdmin } from "../../middleware/auth-middleware.js";
import { getUserWithCredentials, getUserWithUsername } from "../../data/user-dao.js";
const router = express.Router();
import { avatarUploader } from "../../middleware/image-middleware.js";
import { verifyUserExists } from "../../middleware/verifyExists-middleware.js";
import fsExtra from 'fs-extra';

// Register user
router.post("/register", avatarUploader, verifyUserExists, async (req, res) => {
  const user = req.body;
  console.log("register.body",req.body);
  console.log("register.body",req.file);
  console.log("register.body",typeof req.body.avatar);
  if(req.file) {
    user.avatar = "/images/" + req.file.filename;
  }
  try {
    const newUser = await createUser(user);
    delete newUser.password;
    if(req.file) {
      await fsExtra.copy(req.file.path, "public"+ newUser.avatar);
    }
    return res.status(201).json(newUser);
  } catch (err) {
    console.log(err);
    return res.status(422).send(err.errors);
  } finally{
    await fsExtra.emptyDir('temp');
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
router.post("/logout", (req, res) => {
  return res.clearCookie("authToken").json({ message: "Logged out." });
});

// Get user by username
router.get("/username/:username", (req, res) => {
  // ...
});

// Get user by id
router.get("/:userId", authenticateUser, (req, res) => {
  // ...
});

// Update user
router.patch("/:userId", authenticateUser, (req, res) => {
  // ...
});

// Get users
router.get("/", authenticateAdmin, (req, res) => {
  // ...
});

// Delete user
router.delete("/:userId", authenticateUser, (req, res) => {
  // ...
});

export default router;
