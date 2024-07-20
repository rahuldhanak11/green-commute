const express = require("express");
const { body, validationResult } = require("express-validator");
const fetchUser = require("../middlewares/auth");
const Trip = require("../models/trip.model");

const router = express.Router();

// Create a Trip
router.post(
  "/create/trip",
  fetchUser,
  [
    body("source").isArray(),
    body("source.*.lat").isString(),
    body("source.*.lng").isString(),
    body("destination").isArray(),
    body("destination.*.lat").isString(),
    body("destination.*.lng").isString(),
    body("travelledBy").isIn(["Driving", "Bicycle", "Walking", "Transit"]),
    body("carbonFootPrintSaved").isString(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    try {
      const {
        source,
        destination,
        totalDistance,
        travelledBy,
        totalTime,
        carbonFootPrintSaved,
        rewardPointEarned,
      } = req.body;
      const userId = req.user.id;

      const trip = new Trip({
        userId,
        source,
        destination,
        totalDistance,
        travelledBy,
        totalTime,
        carbonFootPrintSaved,
        rewardPointEarned,
      });

      await trip.save();
      res.json(trip);
    } catch (error) {
      console.error(error.message);
      res.status(500).send("Server Error");
    }
  }
);

// Get Trips
router.get("/get/trips", fetchUser, async (req, res) => {
  try {
    const trips = await Trip.find({ userId: req.user.id });
    res.json(trips);
  } catch (error) {
    console.error(error.message);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
