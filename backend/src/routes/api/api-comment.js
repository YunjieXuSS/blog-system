import express from "express";
import { deleteComment } from "../../data/comment-dao.js";
import { authenticateUser } from "../../middleware/auth-middleware.js";
//import { ... } from "../../data/comment-dao.js"; ----import the functions from the DAO file to process the requests

const router = express.Router();

// Comment APIs

//Delete a comment.
router.delete("/:commentId", authenticateUser, async (req, res) => {
  if (!req.params.commentId) return res.status(422).json({ error: "Comment ID is required" });
  let commentId;
  try {
    commentId = parseInt(req.params.commentId);
  } catch (error) {
    return res.status(422).json({ error: "Comment ID must be an integer" });
  }
  try {
    const result = await deleteComment(commentId, req.user.userId);
    if (result) return res.sendStatus(204);
    return res.status(404).json({ error: "Comment not found" });
  } catch (error) {
    return res.status(403).json({ error: error });
  }
});

export default router;
