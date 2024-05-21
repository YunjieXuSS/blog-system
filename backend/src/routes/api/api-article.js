import express from "express";
//import { ... } from "../../data/article-dao.js"; ----import the functions from the DAO file to process the requests
import {authenticateUser} from "../../middleware/auth-middleware";

const router = express.Router();

// Articles' API


// Get articles' comments
router.get("/:articleId/comments", (req, res) => {
  // ...
});

//Create a new comment on an article
router.post("/:articleId/comments", (req, res) => {
  // ...
});

// Like article
router.post("/:articleId/like", authenticateUser,(req, res) => {
  // ...
});

// Unlike article
router.post("/:articleId/unlike", authenticateUser,(req, res) => {
  // ...
});

export default router;