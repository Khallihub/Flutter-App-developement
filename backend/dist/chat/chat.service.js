"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("mongoose");
const mongoose_2 = require("@nestjs/mongoose");
let ChatService = class ChatService {
    constructor(chatModel) {
        this.chatModel = chatModel;
    }
    async deleteMessage(data) {
        console.log(data);
        const users = [data.user1, data.user2].sort();
        const chat = await this.chatModel.findOne({ usersName: users });
        console.log(chat);
        const unchangedMessages = chat.messages.filter((message) => message[0] !== data.time);
        const updatedChat = await this.chatModel.findOneAndUpdate({ usersName: users }, { messages: unchangedMessages }, { new: true });
    }
    async renameChat(data) {
        const users = [data.user1, data.user2].sort();
        const newUserName = [];
        if (data.sender === users[0]) {
            newUserName.push(data.newName);
            newUserName.push(users[1]);
        }
        else {
            newUserName.push(users[0]);
            newUserName.push(data.newName);
        }
        newUserName.sort();
        const chat = await this.chatModel.findOneAndUpdate({ usersName: users }, { usersName: newUserName }, { new: true });
        return chat;
    }
    async updateMessage(data) {
        const users = [data.user1, data.user2].sort();
        const chat = await this.chatModel.findOne({ usersName: users });
        const messages = chat.messages;
        const unchangedMessages = messages.filter((message) => message[0] !== data.time);
        const oldMessage = messages.filter((message) => message[0] === data.time)[0];
        const newMessage = [oldMessage[0], data.sender, data.message];
        unchangedMessages.push(newMessage);
        const updatedChat = await this.chatModel.findOneAndUpdate({ usersName: users }, { messages: unchangedMessages }, { new: true });
        return updatedChat;
    }
    async Message(data) {
        const users = [data.user1, data.user2].sort();
        const message = [Date.now(), data.sender, data.message];
        const chat = await this.chatModel.findOneAndUpdate({ usersName: users }, { $push: { messages: message } }, { new: true });
        return chat;
    }
    async deleteChat(data) {
        const users = [data.user1, data.user2].sort();
        const chat = await this.chatModel.findOneAndDelete({ usersName: users });
        return chat;
    }
    async getChat(data) {
        const users = [data.user1, data.user2].sort();
        const chat = await this.chatModel.findOne({ usersName: users });
        if (chat) {
            return chat;
        }
    }
    async createChat(data) {
        const users = [data.user1, data.user2].sort();
        const chat = await this.chatModel.findOne({ usersName: users });
        if (chat) {
            return chat;
        }
        const newChat = new this.chatModel({
            usersName: users,
            messages: [],
        });
        const result = await newChat.save();
        return result;
    }
};
ChatService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_2.InjectModel)('chat')),
    __metadata("design:paramtypes", [mongoose_1.Model])
], ChatService);
exports.ChatService = ChatService;
//# sourceMappingURL=chat.service.js.map