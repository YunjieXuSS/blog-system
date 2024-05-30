import express from "express";
import { authenticateUser } from "../../middleware/auth-middleware.js";
import {
  getArticles,
  getArticleById,
  getArticlesByUserId,
  getArticlesByTitle,
  getArticlesByContent,
  getArticlesByDate,
  getArticlesByUserName,
  deleteArticle,
  createArticle,
  updateArticle,
  likeArticle,
  unlikeArticle,
  getArticlesByKeywords,
  getLikes,
  checkLikeStatus
} from "../../data/article-dao.js";
import { imageUploader } from "../../middleware/image-middleware.js";
import { getComments, createComment, getNumComments } from "../../data/comment-dao.js";
import { getUserIdByCookie } from "../../middleware/cookie-middleware.js";
import fsExtra from "fs-extra";
const router = express.Router();

// Articles' API
router.get("/", getUserIdByCookie, async (req, res) => {
  let userId;
  if(req.user) userId = req.user.userId;
  try {
    const articles = await getArticlesByKeywords(req.query,userId);
    return res.json(articles);
  } catch (err) {
    console.error(err);
    if (err.errors) return res.status(422).json({ error: err.errors });
  }
});

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
    } else if (req.query.updateDate) {
      const articlesOfDate = await getArticlesByDate(req.query.updateDate);
      return res.status(200).json(articlesOfDate);
    } else if (req.query.userName) {
      const articlesOfUser = await getArticlesByUserName(req.query.userName);
      return res.status(200).json(articlesOfUser);
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
    console.error(error);
    return res.status(404).json({ error: "Can't find articles." });
  }
});

// get articles by articleId
router.get("/:articleId", async (req, res) => {
  try {
    const articles = await getArticleById(req.params.articleId);
    // const articles = await getArticleById(req.params.articleId);
    return res.status(200).json(articles);
  } catch (error) {
    return res.status(404).json({ error: "Can't find articles." });
  }
});

//create a new article if the user is logged in
//POST /api/userarticles - Creates a new article.
router.post("/", authenticateUser, imageUploader, async (req, res) => {
  const article = req.body;
  article.userId = req.user.userId;
  if (req.file) {
    article.imgUrl = "/images/" + req.file.filename;
  }
  try {
    const newArticle = await createArticle(article);
    if (req.file) {
      await fsExtra.copy(req.file.path, "public" + newArticle.imgUrl);
    }
    return res.status(201).json(newArticle);
  } catch (err) {
    console.log(err);
    return res.status(422).send(err.errors);
  } finally {
    await fsExtra.emptyDir("temp");
  }
});

//update an existing article
//PATCH /api/:articleId - Updates the article with the given id.
router.patch("/:articleId", authenticateUser, imageUploader, async (req, res) => {
  const articleId = req.params.articleId;
  const articleData = req.body;
  articleData.userId = req.user.userId;
  if (req.file) {
    articleData.imgUrl = "/images/" + req.file.filename;
  }
  try {
    const updatedArticle = await updateArticle(articleId, articleData);
    if (req.file) {
      await fsExtra.copy(req.file.path, "public" + updatedArticle.imgUrl);
    }
    return res.status(200).json({ ...updatedArticle, message: "Article updated successfully" });
  } catch (err) {
    console.log(err);
    if (err.errors) return res.status(422).send(err.errors);
  } finally {
    await fsExtra.emptyDir("temp");
  }
});

/**
 * DELETE /api/articles/:articleId - Deletes the article with the given id, if found. Either way,
 * returns a 204 (No Content) response.
 */
router.delete("/:articleId", async (req, res) => {
  await deleteArticle(req.params.articleId);
  return res.sendStatus(204);
});

// Get articles' comments
router.get("/:articleId/comments", async (req, res) => {
  const article = await getArticleById(req.params.articleId);
  if (article) {
    const article = await getArticleById(req.params.articleId);
    if (article) {
      const comments = await getComments(req.params.articleId);
      return res.status(200).json(comments);
    } else {
      return res.status(404).json({ error: "Article does not exist." });
    }
  }
});

//Create a new comment on an article
router.post("/:articleId/comment", authenticateUser, async (req, res) => {
  const comment = req.body;
  comment.articleId = req.params.articleId;
  comment.userId = req.user.userId;
  try {
    const newComment = await createComment(comment);
    return res.status(201).json(newComment);
  } catch (err) {
    if (err.errors) return res.status(422).json(err.errors);
    return res.status(500).json({ error: err.message });
  }
})
router.post("/:articleId/comment", authenticateUser, async (req, res) => {
  const comment = req.body;
  comment.articleId = req.params.articleId;
  comment.userId = req.user.userId;
  try {
    const newComment = await createComment(comment);
    return res.status(201).json(newComment);
  } catch (err) {
    if (err.errors) return res.status(422).json(err.errors);
    return res.status(500).json({ error: err.message });
  }
});

//GET number of comments by articleId
router.get("/:articleId/comments", async (req, res) => {
  const articleId = req.params.articleId;
  if (articleId) {
    const commentsCount = await getNumComments(articleId);
    return res.status(200).json(commentsCount);
  } else {
    return res.status(404).json({ error: "Article does not exist." });
  }
});

// Like article
router.post("/:articleId/like", authenticateUser, async (req, res) => {
  try {
    await likeArticle(req.user.userId, req.params.articleId);
    return res.sendStatus(200);
  } catch (error) {
    console.log(error);
    return res.status(400).json({ error: "Article does not exist or user has liked it." });
  }
});

// Unlike article
router.post("/:articleId/unlike", authenticateUser, async (req, res) => {
  const result = await unlikeArticle(req.user.userId, req.params.articleId);
  if (!result) return res.status(404).json("Article does not exist");
  return res.sendStatus(200);
});

router.get("/:articleId/likeStatus", authenticateUser, async (req, res) => {
  const articleId = req.params.articleId;
  const userId = req.user.userId;
  try {
    const isLiked = await checkLikeStatus(articleId, userId);
    return res.json({ isLiked: isLiked });
  } catch (error) {
    console.log(error);
    return res.status(400).json(error);
  }
});

//GET numbers of like by articleId
router.get("/:articleId/like", async (req, res) => {
  const articleId = req.params.articleId;
  if (articleId) {
    const likesCount = await getLikes(articleId);
    return res.status(200).json(likesCount);
  } else {
    return res.status(404).json({ error: "Article does not exist." });
  }
});


export default router;
