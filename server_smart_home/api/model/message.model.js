var mongoose = require('mongoose')

var messageSchema = mongoose.Schema(
    {
        title: {
            type: String,
        },
        description: {
            type: String,
        },
        status: {
            type: String,
        }
    },
    { timestamps: true }
)

const Message = mongoose.model('Message', messageSchema);

module.exports = Message;
