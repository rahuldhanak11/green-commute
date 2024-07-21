const express = require("express");
const { body, validationResult } = require("express-validator");
const fetchUser = require("../middlewares/auth");
const {
  getPlaceSuggestions,
  getDistanceMatrix,
  getDirections,
  getGeoCode,
  getReverseGeoCode,
} = require("../utils/googlMapsServices");

const router = express.Router();

router.post("/distance-matrix", async (req, res) => {
  try {
    const response = await getDistanceMatrix(req.body);
    res.json(response.data);
  } catch (error) {
    res
      .status(500)
      .send(error.response ? error.response.data.error_message : error.message);
  }
});

router.post("/directions", async (req, res) => {
  try {
    const response = await getDirections(req.body);
    res.json(response.data);
  } catch (error) {
    res
      .status(500)
      .send(error.response ? error.response.data.error_message : error.message);
  }
});

router.post("/place-autocomplete", async (req, res) => {
  try {
    const response = await getPlaceSuggestions(req.body.input);
    res.json(response.data);
  } catch (error) {
    res
      .status(500)
      .send(error.response ? error.response.data.error_message : error.message);
  }
});

router.post("/place-details", async (req, res) => {
  try {
    const response = await getPlaceDetails(req.body.place_id);
    res.json(response.data);
  } catch (error) {
    res
      .status(500)
      .send(error.response ? error.response.data.error_message : error.message);
  }
});

router.post("/geocode", async (req, res) => {
  try {
    const response = await getGeoCode(req.body.address);
    res.json(response.data);
  } catch (error) {
    res
      .status(500)
      .send(error.response ? error.response.data.error_message : error.message);
  }
});

router.post("/reverse-geocode", async (req, res) => {
  try {
    const response = await getReverseGeoCode(req.body.latlng);
    res.json(response.data.results[0]["formatted_address"]);
  } catch (error) {
    res
      .status(500)
      .send(error.response ? error.response.data.error_message : error.message);
  }
});

module.exports = router;
