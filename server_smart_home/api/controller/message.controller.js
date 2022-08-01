const Message = require('../model/message.model');

const MessageController = {
    getMessage: async (req, res) => {
        const message = await Message.find();
        res.json(message)
    },
    deleteMessage: async (req, res, next) => {
        // const auths = await Auth.find();
        const deleteAuths = await Message.remove();
        res.json(deleteAuths)
    },
}

module.exports = MessageController;