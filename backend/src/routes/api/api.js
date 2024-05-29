import express from "express";

const router = express.Router();

// import child routes
import userRoutes from "./api-user.js";
router.use("/user", userRoutes);

import adminRoutes from "./api-users.js";
router.use("/users", adminRoutes);

import articleRoutes from "./api-articles.js";
router.use("/articles", articleRoutes);

import commentRoutes from "./api-comments.js";
router.use("/comments", commentRoutes);

// // Upload image
// router.post("/upload", (req, res) => {
//   // ...
// });

// import child routes
import routes from "./api-upload.js";
router.use("/uploads", routes);

export default router;
