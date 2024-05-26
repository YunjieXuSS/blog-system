import express from "express";

const router = express.Router();

// import child routes
import userRoutes from "./api-user.js";
router.use("/users", userRoutes);

import articleRoutes from "./api-article.js";
router.use("/articles", articleRoutes);

import commentRoutes from "./api-comment.js";
router.use("/comments", commentRoutes);

// // Upload image
// router.post("/upload", (req, res) => {
//   // ...
// });

// import child routes
import routes from "./api-upload.js";
router.use("/uploads", routes);

export default router;
