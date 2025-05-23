/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// functions/index.js
const functions = require("firebase-functions");
 const axios = require("axios");
 const cors = require("cors")({ origin: true });

 exports.weatherProxy = functions.https.onRequest((req, res) => {
   cors(req, res, async () => {
     const city = req.query.q;
     const apiKey = "f939c51106acbb1ed47bec69921ec8f2";
     const url = `https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${apiKey}&units=metric&cnt=40`;

     try {
       const response = await axios.get(url);
       res.status(200).json(response.data);
     } catch (error) {
       res.status(500).send(error.message);
     }
   });
 });
