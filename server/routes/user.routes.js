const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { body, validationResult } = require("express-validator");
const { User } = require("../models/user.model");
const { generateSecureOTP } = require("../utils/generateOtp");
const { sendEmailForVerification } = require("../utils/sendMail");
require("dotenv").config();

const router = express.Router();

// Register User
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
      const { fullName, email, password } = req.body;

      let user = await User.findOne({ email });
      if (user) {
        return res.status(400).json({ error: "Client already exists" });
      }

      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);
      const otp = generateSecureOTP();

      user = new User({
        fullName,
        email,
        password: hashedPassword,
        otp,
      });

      await user.save();

      await sendEmailForVerification(fullName, email, otp)
        .then(() => {
          res.status(200).json({
            message: "User Registered & Email Sent successfully",
            data: {
              id: user._id,
              name: user.fullName,
              email: user.email,
              role: user.role,
              verificationStatus: user.verificationStatus,
            },
          });
        })
        .catch((error) => console.error(`Failed to send mail ERROR: ${error}`));
    } catch (error) {
      console.error(error.message);
      res.status(500).send("Server Error");
    }
  }
);

// Login User
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

      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ error: "Invalid credentials" });
      }

      if (user.verificationStatus === "PENDING") {
        return res.status(400).json({ error: "OTP Verification Pending" });
      }

      const payload = { _id: user._id, name: user.fullName, role: user.role };
      const authToken = jwt.sign(payload, process.env.JWT_SECRET, {
        expiresIn: "1d",
      });

      res.json({ authToken });
    } catch (error) {
      console.error(error.message);
      res.status(500).send("Server Error");
    }
  }
);

router.post(
  "/verify-otp/:id",
  [
    body("otp")
      .exists()
      .withMessage("OTP is required")
      .isInt({ min: 1000, max: 9999 })
      .withMessage("OTP must be a 4-digit integer")
      .isLength({ min: 4, max: 4 })
      .withMessage("OTP must be exactly 4 characters long"),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const { otp } = req.body;
    const { id } = req.params;

    const user = await User.findById({ _id: id });
    if (!user) {
      return res.status(400).json({ error: "User not registered" });
    }

    if (user.otp !== otp) {
      return res.status(400).json({ error: "Invalid OTP" });
    }

    user.verificationStatus = "VERIFIED";
    user.otp = "";

    await user.save();

    return res.status(200).json({
      message: "Account has been Verified",
      data: {
        id: user._id,
        name: user.fullName,
        email: user.email,
        role: user.role,
        verificationStatus: user.verificationStatus,
      },
    });
  }
);

module.exports = router;
