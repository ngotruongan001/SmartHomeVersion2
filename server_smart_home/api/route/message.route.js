var express = require('express');
var router = express.Router();
const MessageController = require('../controller/message.controller')

/* GET NVs. */
router.get('/', MessageController.getMessage);
router.delete('/delete', MessageController.deleteMessage);

module.exports = router;
