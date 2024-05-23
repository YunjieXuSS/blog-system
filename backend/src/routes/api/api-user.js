import express from "express";
//import { ... } from "../../data/user-dao.js"; ----import the functions from the DAO file to process the requests
import { createUserJWT } from "../../utils/jwt-utils.js";
import { authenticateUser, authenticateAdmin } from "../../middleware/auth-middleware.js";
import { getUserWithCredentials, getUserWithUsername } from "../../data/user-dao.js";
import { createPasswordHashSalt } from "../../middleware/auth-middleware.js";

const router = express.Router();

// Register user
router.post("/register", createPasswordHashSalt, (req, res) => {
  
});

// Login user
router.post("/login", async(req, res) => {
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
  // ...
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
