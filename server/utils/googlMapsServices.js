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

module.exports = { getPlaceSuggestions };
