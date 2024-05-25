import express from "express";
import { deleteComment } from "../../data/comment-dao.js";
import { authenticateUser } from "../../middleware/auth-middleware.js";
//import { ... } from "../../data/comment-dao.js"; ----import the functions from the DAO file to process the requests

const router = express.Router();

// Comment APIs

//Delete a comment.
router.delete("/:commentId", authenticateUser, async (req, res) => {
  if (!req.params.commentId) return res.status(422).send("Comment ID is required");
  if (Number.isInteger(req.params.commentId) === false)
    return res.status(422).send("Comment ID must be an integer");
  try {
    const result = await deleteComment(req.params.commentId, req.user.userId);
    if (result) return res.sendStatus(204);
    return res.status(404).send("Comment not found");
  } catch (error) {
    return res.status(403).send(error);
  }
});

export default router;
