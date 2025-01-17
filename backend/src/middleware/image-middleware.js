import multer from "multer";
import path from "path";

const storage = multer.diskStorage({
  destination: function (_, __, cb) {
    cb(null, "temp");
  },
  filename: function (_, file, cb) {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, file.fieldname + "-" + uniqueSuffix + path.extname(file.originalname));
  }
});

// const storage = multer.memoryStorage();

const fileFilter = (_, file, cb) => {
  const allowedTypes = /jpeg|jpg|png/;
  const mimeType = allowedTypes.test(file.mimetype);
  const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());

  if (mimeType && extname) {
    return cb(null, true);
  } else {
    cb(new Error("Only .jpeg, .jpg and .png files are allowed!"));
  }
};

const upload1 = multer({
  storage: storage,
  limits: { fileSize: 2 * 1024 * 1024 }, // 2MB
  fileFilter: fileFilter
});

export function avatarUploader(req, res, next) {
  upload1.single("avatar")(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      if (err.code === "LIMIT_FILE_SIZE") {
        return res.status(413).json({ error: "File size is too large. Max limit is 2MB." });
      }
    } else if (err) {
      return res.status(400).json({ error: err.message });
    }
    next();
  });
}
const upload2 = multer({
  storage: storage,
  limits: { fileSize: 8 * 1024 * 1024 }, // 8MB
  fileFilter: fileFilter
});

export function imageUploader(req, res, next) {
  upload2.single("imgUrl")(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      if (err.code === "LIMIT_FILE_SIZE") {
        return res.status(413).json({ error: "File size is too large. Max limit is 8MB." });
      }
    } else if (err) {
      return res.status(400).json({ error: err.message });
    }
    next();
  });
}
