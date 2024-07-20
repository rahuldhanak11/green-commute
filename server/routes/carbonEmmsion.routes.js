const express = require('express');
const fetchUser = require('../middlewares/auth');
const { emissionFactors } = require('../utils/carbonEmmision');
const router = express.Router();

router.post('/', fetchUser, async (req, res) => {
  const { distance, mode } = req.body;

  if ([distance, mode].some((field) => !field)) {
    return res.status(400).json({ error: 'All Fields Required' });
  }

  if (!emissionFactors[mode]) {
    return res.status(400).json({ error: 'Invalid mode of transport' });
  }

  let emissionFactor;
  if (mode === 'car_gasoline') {
    emissionFactor = emissionFactors['car_gasoline'];
  } else {
    emissionFactor = emissionFactors[mode];
  }
  const carbonFootprint = distance * emissionFactor; // in g
  return res.status(200).json({ data: carbonFootprint / 1000 }); // in kg
});

module.exports = router;
