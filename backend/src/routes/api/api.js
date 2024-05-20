import express from "express";

const router = express.Router();

// import child routes
import routes from "./api-user.js";
router.use("/users", routes);

import routes from "./api-article.js";
router.use("/articles", routes);

import routes from "./api-comment.js";
router.use("/comments", routes);

// Upload image
router.post("/upload", (req, res) => {
  // ...
});
export default router;
