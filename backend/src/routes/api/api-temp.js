/**
 * This file contains API routes for the temp data. You should
 * create your own API routes files for your project, and get rid of this one.
 */

import express from "express";
import { getMessages } from "../../data/temp-dao.js";

const router = express.Router();

router.get("/", async (req, res) => {
  const messages = await getMessages();
  return res.json(messages);
});

export default router;
