const connectToMongo = require('./db/connection');
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

connectToMongo();

const app = express();
const port = 5000 || process.env.PORT;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use('/api/auth', require('./routes/user.routes'));
app.use('/api/trip', require('./routes/trip.routes'));
app.use('/api/map', require('./routes/map.routes'));
app.use('/api/community', require('./routes/community.routes'));
app.use('/api/carbon-emission', require('./routes/carbonEmmsion.routes'));
// app.use('/api/products', require('./routes/products'))

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
