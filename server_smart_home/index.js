'use strict';
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const config = require('./config');
const firebase = require('./db');
const FCM = require('fcm-node')
var serverKey = require('./privateKey.json')
const PORT = process.env.PORT || 3000;
const app = express();
const mongoose = require('mongoose');



app.use(express.json());
app.use(cors());
app.use(bodyParser.json());
var fcm = new FCM(serverKey);

const MONGODB_URL = 'mongodb+srv://learnnodejs:learnnodejslearnnodejslearnnodejs@cluster0.wdwpr.mongodb.net/test_database?retryWrites=true&w=majority';
mongoose.connect(
    MONGODB_URL,
    { useNewUrlParser: true }
)
    .then((result) => { console.log("Connect successfully!") })
    .catch((error) => { console.log("Error connecting") })
// view engine setup

const Message = require('./api/model/message.model')

var databaseDB = firebase.database();
// databaseDB.ref("notification/status").set("yes");
const sendMessage = (token, title, body, status) => {
    var message = {
        to: token,
        // collapse_key: '...',
        notification: {
            title: title,
            body: body
        },
        data: {  //you can send only notification or only data(or include both)
            my_key: 'my value',
            my_another_key: 'my another value'
        }
    }

    fcm.send(message, function (err, response) {
        if (err) {
            console.log(err)
        } else {
            console.log("Successfully sent with response: ", response)
            createMessage(title, body, status)
        }
    })

}

function createMessage(title, description, status) {
    const message = Message();
    message.title = title;
    message.description = description;
    message.status = status;
    message.save();
}


databaseDB.ref('ESP32_Device/AntiTheft/Status').on('value', function (snapshot) {
    if (snapshot.val() == "yes") {
        databaseDB.ref('fcm-token/token').once('value')
            .then(function (snapshot_in) {
                const token = snapshot_in.val();
                console.log(token);
                sendMessage(token, 'Cảnh Báo', "Phát hiện xâm nhập lạ vào nhà bạn", "1")
                databaseDB.ref("ESP32_Device/AntiTheft/Status").set("no");
            })
            .then(() => {
                databaseDB.ref('ESP32_Device/AntiTheft/Times').once('value')
                    .then(function (snapshot_in) {
                        const times = snapshot_in.val();
                        console.log(times);
                        databaseDB.ref("ESP32_Device/AntiTheft/Times").set(snapshot_in.val() + 1);
                    })
            })

    } else {
        console.log("no")
    }
})


databaseDB.ref('ESP32_Device/AntiFire/Status').on('value', function (snapshot) {
    if (snapshot.val() == "yes") {
        databaseDB.ref('fcm-token/token').once('value')
            .then(function (snapshot_in) {
                const token = snapshot_in.val();
                console.log(token);
                sendMessage(token, 'Báo Cháy', "Phát hiện rò rỉ khí gây cháy", "2");
                databaseDB.ref("ESP32_Device/AntiFire/Status").set("no");
            })
    } else {
        console.log("no")
    }
})

databaseDB.ref('ESP32_Device/AntiFire/PPM').on('value', function (snapshot) {
    if (snapshot.val() >= 100) {
        databaseDB.ref('fcm-token/token').once('value')
            .then(function (snapshot_in) {
                const token = snapshot_in.val();
                console.log(token);
                sendMessage(token, 'Nguy hiểm', "Nồng độ khí CO vượt qua ngưỡng cho phép", "3");
            })
    } else {
        console.log("no")
    }
})

databaseDB.ref('ESP32_Device/RainAlarm/Status').on('value', function (snapshot) {
    if (snapshot.val() == "yes") {
        databaseDB.ref('fcm-token/token').once('value')
            .then(function (snapshot_in) {
                const token = snapshot_in.val();
                console.log(token);
                sendMessage(token, 'Trời Mưa', "Hãy đảm bảo rằng bạn đã đóng cửa sổ", "4");
                databaseDB.ref("ESP32_Device/RainAlarm/Status").set("no");
            })
    } else {
        console.log("no")
    }
})


databaseDB.ref('ESP32_Device/Temperature/Data').on('value', function (snapshot) {
    if (snapshot.val() >= 50.0) {
        databaseDB.ref('fcm-token/token').once('value')
            .then(function (snapshot_in) {
                const token = snapshot_in.val();
                console.log(token);
                sendMessage(token, 'Cảnh Báo Nhiệt!', `Nhiệt độ cao tại: ${snapshot.val()}`, "5");
            })
    } else {
        console.log("no")
    }
})
const messageRoute = require('./api/route/message.route')
app.use('/api/v1/message', messageRoute)

// app.get('/', (req, res) => {
//     databaseDB.ref("ESP32_Device/notification/status").set("yes");
//     res.send("SP")
//     console.log("Yes")
// })


// app.get('/message', async (req, res) => {
//     const message = await Message.find();
//     res.json(message)
// })


app.listen((process.env.PORT || 3000), () => console.log('App is listening on url http://localhost:' + PORT));
