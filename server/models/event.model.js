const { Schema, model } = require('mongoose');

const eventSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    venue: {
      type: String,
      required: true,
    },
    totalCapacity: {
      type: Number,
      required: true,
    },
    timing: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

const Event = model('Event', eventSchema);

module.exports = { Event };
