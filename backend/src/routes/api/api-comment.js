import express from "express";
import { deleteComment } from "../../data/comment-dao.js";
//import { ... } from "../../data/comment-dao.js"; ----import the functions from the DAO file to process the requests

const router = express.Router();

// Comment API

//Delete a comment.
router.delete("/commentId", async (req, res) => {
  await deleteComment(req.params.commentId);
  return res.sendStatus(204);
})


export default router;