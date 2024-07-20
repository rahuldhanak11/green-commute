const express = require("express");
const { Community } = require("../models/community.model");
const fetchUser = require("../middlewares/auth");
const { upload } = require("../utils/imageUpload");
const { uploadOnCloudinary } = require("../utils/cloudinary");
const router = express.Router();

router.post(
  "/",
  fetchUser,
  upload.single("communityImage"),
  async (req, res) => {
    const { name, description } = req.body;
    const id = req.user._id;
    const imagePath = req.file.path;
    const coverImage = await uploadOnCloudinary(imagePath);
    if ([name, description].some((field) => !field)) {
      return res.status(400).json({ error: "Fields Required" });
    }

    const newCommunity = new Community({
      name,
      description,
      createdBy: id,
      profileImage: coverImage.url,
    });

    await newCommunity.save();
    return res.status(200).json({ message: "Community Created SuccessFully" });
  }
);

router.post(
  "/:id/post",
  fetchUser,
  upload.single("postImage"),
  async (req, res) => {
    const { title, description, venue, totalCapacity, timing } = req.body;
    const id = req.params.id;
    const imagePath = req.file.path;
    const coverImage = await uploadOnCloudinary(imagePath);
    const community = await Community.findById(id);
    if (!community) {
      return res.status(400).json({ error: "Community not exists" });
    }
    community.posts.push({
      title,
      description,
      venue,
      totalCapacity,
      timing,
      image: coverImage.url,
    });
    await community.save();
    return res.status(200).json({ message: "Post Created Successfully" });
  }
);

router.get("/", async (req, res) => {
  const allCommunities = await Community.find({});
  return res.status(200).json({ data: allCommunities });
});

module.exports = router;
