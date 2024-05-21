import express from "express";
//import { ... } from "../../data/user-dao.js"; ----import the functions from the DAO file to process the requests
import { createUserJWT } from "../../utils/jwt-utils.js"
import { authenticateUser, authenticateAdmin } from "../../middleware/auth-middleware.js";

const router = express.Router();

// Register user
router.post("/register", (req, res) => {
  // ...
});

// Login user
router.post("/login", (req, res) => {
  // ...
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
