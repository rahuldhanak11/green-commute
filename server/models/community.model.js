const { Schema, model } = require('mongoose');

const postSchema = new Schema(
  {
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    image: {
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
    noOfLikes: {
      type: Number,
      default: 0,
    },
    likedBy: [
      {
        type: Schema.Types.ObjectId,
        ref: 'User',
      },
    ],
    noOfComments: {
      type: Number,
      default: 0,
    },
    commentedBy: [
      {
        type: Schema.Types.ObjectId,
        ref: 'User',
      },
    ],
  },
  { timestamps: true }
);

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
    usersJoined: [
      {
        type: Schema.Types.ObjectId,
        ref: 'User',
      },
    ],
    createdBy: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    posts: [postSchema],
  },
  { timestamps: true }
);

const Community = model('Community', communitySchema);

module.exports = { Community };
