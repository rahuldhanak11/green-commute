const express = require('express');
// const { body, validationResult } = require('express-validator');
const {Event} = require('../models/event.model');

const router = express.Router();

// Endpoint to create a new event
router.post('/events', async (req, res) => {
  try {
    const { name, description, venue, totalCapacity, timing } = req.body;
    const newEvent = new Event({
      name,
      description,
      venue,
      totalCapacity,
      timing,
    });
    await newEvent.save();
    res.status(201).json(newEvent);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Endpoint to get all events
router.get('/events', async (req, res) => {
  try {
    const events = await Event.find();
    res.status(200).json(events);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
