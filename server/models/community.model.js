const { Schema, model } = require('mongoose');

const communitySchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,
    },
    description: {
      type: String,
      required: true,
    },
    profileImage: {
      type: String,
      required: true,
    },
    noOfUsers: {
      type: Number,
      default: 0,
    },
    userJoined: [
      {
        type: Schema.Types.ObjectId,
        ref: 'User',
      },
    ],
    createdBy: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
    messages: [
      {
        sendBy: {
          type: Schema.Types.ObjectId,
          ref: 'User',
        },
        text: {
          type: String,
        },
      },
    ],
  },
  { timestamps: true }
);

const Community = model('Communtiy', communitySchema);

module.exports = { Community };
