import express from "express";
import { authenticateUser } from "../../middleware/auth-middleware.js";
import {
  getArticles,
  getArticleById,
  getArticlesByUserId,
  getArticlesByTitle,
  getArticlesByContent,
  getArticlesByDate,
  deleteArticle
} from "../../data/article-dao.js";
const router = express.Router();

// Articles' API

router.get("/search", async (req, res) => {
  try {
    if (req.query.userId) {
      const articlesOfUser = await getArticlesByUserId(req.query.userId);
      return res.status(200).json(articlesOfUser);
    } else if (req.query.title) {
      const articlesOfTitle = await getArticlesByTitle(req.query.title);
      return res.status(200).json(articlesOfTitle);
    } else if (req.query.content) {
      const articlesOfContent = await getArticlesByContent(req.query.content);
      return res.status(200).json(articlesOfContent);
    } else if (req.query.createDate) {
      const articlesOfDate = await getArticlesByDate(req.query.createDate);
      return res.status(200).json(articlesOfDate);
    }
  } catch (error) {
    return res.status(404).json({ error: "Can't find articles." });
  }
});


//get all articles
router.get("/", async (req, res) => {
  try {
    const articles = await getArticles();
    return res.status(200).json(articles);
  } catch (error) {
    return res.status(404).json({ error: "Can't find articles." });
  }
});

/**
 * DELETE /api/articles/:articleId - Deletes the article with the given id, if found. Either way,
 * returns a 204 (No Content) response.
 */
router.delete("/:articleId", async(req, res) =>{
  await deleteArticle(req.params.articleId);
  return res.sendStatus(204);
})

// Get articles' comments
router.get("/:articleId/comments", (req, res) => {
  // ...
});

//Create a new comment on an article
router.post("/:articleId/comments", (req, res) => {
  // ...
});

// Like article
router.post("/:articleId/like", authenticateUser, (req, res) => {
  // ...
});

// Unlike article
router.post("/:articleId/unlike", authenticateUser, (req, res) => {
  // ...
});

export default router;
