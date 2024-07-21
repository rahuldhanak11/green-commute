const { Client } = require("@googlemaps/google-maps-services-js");
const client = new Client({});

const apiKey = process.env.GOOGLE_MAPS_API_KEY;

function getPlaceSuggestions(input) {
  return client
    .placeAutocomplete({
      params: {
        input,
        key: apiKey,
      },
    })
    .then((response) => {
      console.log(response);
      return response;
    })
    .catch((error) =>
      console.error(`Failed to get Place Suggestions ERROR: ${error}`)
    );
}

function getDirections(userSelectionObject) {
  return client
    .directions({
      params: {
        origin: userSelectionObject.src,
        destination: userSelectionObject.destn,
        mode: userSelectionObject.mode,
        avoid: userSelectionObject.avoid,
        alternatives: true,
        departure_time: "now",
        units: "metric",
        // arrival_time: Date,
        traffic_model: "best_guess",
        key: apiKey,
      },
    })
    .then((response) => {
      console.log(response);
      return response;
    })
    .catch((error) =>
      console.error(`Failed to get Directions ERROR: ${error}`)
    );
}

function getDistanceMatrix(userSelectionObject) {
  return client
    .distancematrix({
      params: {
        origins: userSelectionObject.src,
        destinations: userSelectionObject.destn,
        mode: userSelectionObject.mode,
        avoid: userSelectionObject.avoid,
        alternatives: true,
        departure_time: "now",
        units: "metric",
        traffic_model: "best_guess",
        key: apiKey,
      },
    })
    .then((response) => {
      return response;
    })
    .catch((error) => console.error(`Failed to get Distance ERROR: ${error}`));
}

function getGeoCode(locationInput) {
  return client
    .geocode({
      params: {
        address: locationInput,
        key: apiKey,
      },
    })
    .then((response) => {
      console.log(response);
      return response;
    })
    .catch((error) => console.error(`Failed to get Geocode ERROR: ${error}`));
}

function getReverseGeoCode(latlng) {
  return client
    .reverseGeocode({
      params: {
        latlng: latlng,
        key: apiKey,
      },
    })
    .then((response) => {
      return response;
    })
    .catch((error) =>
      console.error("Failed to get Reverse Geocode ERROR: ${error}")
    );
}

module.exports = {
  getPlaceSuggestions,
  getDirections,
  getDistanceMatrix,
  getGeoCode,
  getReverseGeoCode,
};
