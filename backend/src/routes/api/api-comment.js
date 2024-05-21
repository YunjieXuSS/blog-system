import express from "express";
//import { ... } from "../../data/comment-dao.js"; ----import the functions from the DAO file to process the requests

const router = express.Router();

// Comment API

//Delete a comment.
router.delete("/commentId", (req, res) => {
    // ...
  })


export default router;