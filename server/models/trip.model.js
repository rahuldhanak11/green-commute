const { Schema, model } = require('mongoose');

const tripSchema = new Schema(
  {
    source: [
      {
        lat: {
          type: String,
          required: true,
        },
        lng: {
          type: String,
          required: true,
        },
      },
    ],
    destination: [
      {
        lat: {
          type: String,
          required: true,
        },
        lng: {
          type: String,
          required: true,
        },
      },
    ],
    totalDistance: {
      type: String,
    },
    travelledBy: {
      type: String,
      enum: ['Driving', 'Bicycle', 'Walking', 'Transit'],
      required: true,
    },
    totalTime: {
      type: String,
    },
    carbonFootPrintSaved: {
      type: String,
      required: true,
    },
    rewardPointEarned: {
      type: Number,
      default: 0,
    },
  },
  { timestamps: true }
);

export const Trip = model('Trip', tripSchema);
