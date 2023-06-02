"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.chatSchema = exports.Chat = void 0;
const mongoose_1 = require("mongoose");
class Chat {
    constructor(user1, user2, lastMessage, usersName, messages) {
        this.user1 = user1;
        this.user2 = user2;
        this.lastMessage = lastMessage;
        this.usersName = usersName;
        this.messages = messages;
    }
}
exports.Chat = Chat;
exports.chatSchema = new mongoose_1.default.Schema({
    user1: { type: String },
    user2: { type: String },
    lastMessage: { type: [String] },
    usersName: { type: [String] },
    messages: { type: [[String]] },
});
//# sourceMappingURL=chat.model.js.map