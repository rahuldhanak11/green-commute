const { Schema, model } = require('mongoose');

const notificationSchema = new Schema(
  {
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    notifiedTo: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },
  },
  { timestamps: true }
);

const Notification = model('Notification', notificationSchema);

module.exports = { Notification };
