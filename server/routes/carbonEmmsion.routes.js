const express = require("express");
const fetchUser = require("../middlewares/auth");
const { emissionFactors } = require("../utils/carbonEmmision");
const router = express.Router();

router.post("/", fetchUser, async (req, res) => {
  const { distance, mode } = req.body;
  if ([distance, mode].some((field) => !field)) {
    return res.status(400).json({ error: "All Fields Required" });
  }
  if (emissionFactors[mode] == null) {
    return res.status(400).json({ error: "Invalid mode of transport" });
  }

  // Extract numerical value from the distance string
  const distanceValue = parseFloat(distance);
  if (isNaN(distanceValue)) {
    return res.status(400).json({ error: "Invalid distance format" });
  }

  let emissionFactor;
  if (mode === "car_gasoline") {
    emissionFactor = emissionFactors["car_gasoline"];
  } else {
    emissionFactor = emissionFactors[mode];
  }
  const carbonFootprint = distanceValue * emissionFactor; // in g
  console.log(carbonFootprint);
  return res.status(200).json({ data: carbonFootprint }); // in kg
});

module.exports = router;
