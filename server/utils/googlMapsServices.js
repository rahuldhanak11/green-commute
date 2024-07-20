const { Client } = require('@googlemaps/google-maps-services-js');
const client = new Client({});

const apiKey = process.env.GOOGLE_MAPS_API_KEY;

function getPlaceSuggestions(input) {
  return client.placeAutocomplete({
    params: {
      input,
      key: apiKey,
    },
  });
}

function getDirections(userSelectionObject) {
  return client.directions({
    params: {
      origin: userSelectionObject.src,
      destination: userSelectionObject.destn,
      mode: userSelectionObject.mode,
      avoid: userSelectionObject.avoid ? '' : userSelectionObject.avoid,
      alternatives: true,
      units: 'metric',
      // arrival_time: Date,
      traffic_model: 'best_guess',
      key: apiKey,
    },
  });
}

function getDistanceMatrix(userSelectionObject) {
  return client.distancematrix({
    params: {
      origins: userSelectionObject.src,
      destinations: userSelectionObject.destn,
      mode: userSelectionObject.mode,
      avoid: userSelectionObject.avoid ? '' : userSelectionObject.avoid,
      alternatives: true,
      units: 'metric',
      traffic_model: 'best_guess',
      key: apiKey,
    },
  });
}

function getGeoCode(locationInput) {
  return client.geocode({
    params: {
      address: locationInput,
      key: apiKey,
    },
  });
}

module.exports = {
  getPlaceSuggestions,
  getDirections,
  getDistanceMatrix,
  getGeoCode,
};
