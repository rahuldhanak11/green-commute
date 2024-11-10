const express = require('express');
const fetchUser = require('../middlewares/auth');
const { emissionFactors } = require('../utils/carbonEmmision');
const router = express.Router();

router.post('/', async (req, res) => {
  const { distance, mode } = req.body;

  // Validate input
  if ([distance, mode].some((field) => !field)) {
    return res.status(400).json({ error: 'All Fields Required' });
  }
  if (emissionFactors[mode] == null) {
    return res.status(400).json({ error: 'Invalid mode of transport' });
  }

  // Parse distance and validate
  const distanceValue = parseFloat(distance);
  if (isNaN(distanceValue) || distanceValue <= 0) {
    return res.status(400).json({ error: 'Invalid distance format' });
  }

  // Calculate emission factor
  const emissionFactor = emissionFactors[mode] || emissionFactors['default'];
  const carbonFootprint = distanceValue * emissionFactor; // in grams (g)

  // Convert to kilograms (kg) and limit to two decimal places
  let carbonFootprintKg = (carbonFootprint / 1000).toFixed(2);
  carbonFootprintKg = isNaN(carbonFootprintKg) ? '0.00' : carbonFootprintKg; // Ensure response is valid

  return res.status(200).json({ data: carbonFootprintKg });
});

module.exports = router;
