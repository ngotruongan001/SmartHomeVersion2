'use strict';
const dotenv = require('dotenv');
const assert = require('assert');

dotenv.config();
const {
    HOST,
    HOST_URL,
} = process.env;
const PORT = process.env || 3000
assert(PORT, 'PORT is required');
assert(HOST, 'HOST is required');

// API_KEY="AIzaSyCFkvTx55DvTZP01VjmlbkhQPUEb86XJTA"
// AUTH_DOMAIN= "realtime-flutter-1b867.firebaseapp.com"
// DATABASE_URL= "https://realtime-flutter-1b867-default-rtdb.firebaseio.com"
// PROJECT_ID= "realtime-flutter-1b867"
// STORAGE_BUCKET=  "realtime-flutter-1b867.appspot.com"
// MESSAGING_SENDER_ID= "794380958759"
// APP_ID= "1:794380958759:web:1111de432305e1ae9ae202"
module.exports = {
    port: PORT,
    host: "localhost",
    url: "http://localhost:8080",
    firebaseConfig: {
        apiKey: "AIzaSyAttaTR1BOsEee_UuXHipCtpAI0FwU7TM0",
        authDomain: "smart-home-2022-2a3c4.firebaseapp.com",
        databaseURL: "https://smart-home-2022-2a3c4-default-rtdb.firebaseio.com",
        projectId: "smart-home-2022-2a3c4",
        storageBucket: "smart-home-2022-2a3c4.appspot.com",
        messagingSenderId: "1033715427049",
        appId: "1:1033715427049:web:3e4b33462f53221ac1f278",
        measurementId: "G-NH63M49S0Q"
    }
}