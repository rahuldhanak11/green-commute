const { Schema, model } = require('mongoose');

const userSchema = new Schema(
  {
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
    },
    password: {
      type: String,
      required: true,
    },
    fullName: {
      type: String,
      required: true,
    },
    otp: {
      type: String,
    },
    verificationStatus: {
      type: String,
      enum: ['PENDING', 'VERIFIED'],
      default: 'PENDING',
    },
    role: {
      type: String,
      enum: ['USER', 'ADMIN'],
      default: 'USER',
    },
    totalCarbonFootPrintSaved: {
      type: String,
    },
    badgesEarned: [
      {
        type: String,
      },
    ],
    totalRewardPoints: {
      type: Number,
      default: 0,
    },
    tripsCompleted: [
      {
        type: Schema.Types.ObjectId,
        ref: 'Trips',
      },
    ],
  },
  { timestamps: true }
);

export const User = model('User', userSchema);
