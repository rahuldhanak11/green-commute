const { Schema, model } = require("mongoose");
const mongoose = require("mongoose");

const tripSchema = new Schema(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
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
      enum: ["Driving", "Bicycle", "Walking", "Transit"],
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

const Trip = mongoose.model("Trip", tripSchema);

module.exports = Trip;
