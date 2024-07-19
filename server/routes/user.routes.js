const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { body, validationResult } = require("express-validator");
const User = require("../models/user.model");
const fetchUser = require("../middleware/auth");
require("dotenv").config();

const router = express.Router();

// Register Client
router.post(
  "/register/user",
  [
    body("fullName").isLength({ min: 3 }),
    body("email").isEmail(),
    body("password").isLength({ min: 5 }),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    try {
      const {
        fullName,
        email,
        password,
        age,
        gender,
        address,
        city,
        state,
        pincode,
        phoneNo,
      } = req.body;

      let user = await User.findOne({ email });
      if (user) {
        return res.status(400).json({ error: "Client already exists" });
      }

      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);

      user = new User({
        fullName,
        email,
        password: hashedPassword,
        age,
        gender,
        address,
        city,
        state,
        pincode,
        phoneNo,
      });

      await user.save();

      const payload = { user: { id: user.id } };
      const authToken = jwt.sign(payload, process.env.JWT_SECRET, {
        expiresIn: "1h",
      });

      res.json({ authToken });
    } catch (error) {
      console.error(error.message);
      res.status(500).send("Server Error");
    }
  }
);

// Login Client
router.post(
  "/login/user",
  [body("email").isEmail(), body("password").exists()],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { email, password } = req.body;

    try {
      let user = await User.findOne({ email });
      if (!user) {
        return res.status(400).json({ error: "Invalid credentials" });
      }

      const isMatch = await bcrypt.compare(password, client.password);
      if (!isMatch) {
        return res.status(400).json({ error: "Invalid credentials" });
      }

      const payload = { user: { id: user.id } };
      const authToken = jwt.sign(payload, process.env.JWT_SECRET, {
        expiresIn: "1h",
      });

      res.json({ authToken });
    } catch (error) {
      console.error(error.message);
      res.status(500).send("Server Error");
    }
  }
);

module.exports = router;
