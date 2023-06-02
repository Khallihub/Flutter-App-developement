"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.chatSchema = exports.Chat = void 0;
const mongoose_1 = require("mongoose");
class Chat {
    constructor(usersName, messages) {
        this.usersName = usersName;
        this.messages = messages;
    }
}
exports.Chat = Chat;
exports.chatSchema = new mongoose_1.default.Schema({
    usersName: { type: [String] },
    messages: { type: [[String]] },
});
//# sourceMappingURL=chat.model.js.map