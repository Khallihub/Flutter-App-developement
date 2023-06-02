import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import { Chat } from './chat.model';
import { InjectModel } from '@nestjs/mongoose';

@Injectable()
export class ChatService {
  constructor(@InjectModel('chat') private chatModel: Model<Chat>) {}

  async deleteMessage(data: { user1: string; user2: string; time: string }) {
    console.log(data);
    const users = [data.user1, data.user2].sort();
    const chat = await this.chatModel.findOne({ usersName: users });
    const unchangedMessages = chat.messages.filter(
      (message) => message[0] !== data.time,
    );
    const updatedChat = await this.chatModel.findOneAndUpdate(
      { usersName: users },
      { messages: unchangedMessages },
      { new: true },
    );
    return updatedChat
  }

  async renameChat(data: {
    user1: string;
    user2: string;
    sender: string;
    newName: string;
  }) {
    const users = [data.user1, data.user2].sort();
    const newUserName = [];
    if (data.sender === users[0]) {
      newUserName.push(data.newName);
      newUserName.push(users[1]);
    } else {
      newUserName.push(users[0]);
      newUserName.push(data.newName);
    }
    newUserName.sort();

    const chat = await this.chatModel.findOneAndUpdate(
      { usersName: users },
      { usersName: newUserName },
      { new: true },
    );
    return chat;
  }

  async updateMessage(data: {
    user1: string;
    user2: string;
    sender: string;
    time: string;
    message: string;
  }) {
    const users = [data.user1, data.user2].sort();
    const chat = await this.chatModel.findOne({ usersName: users });
    const messages = chat.messages;
    const unchangedMessages = messages.filter(
      (message) => message[0] !== data.time,
    );
    const oldMessage = messages.filter(
      (message) => message[0] === data.time,
    )[0];
    const newMessage = [oldMessage[0], data.sender, data.message];
    unchangedMessages.push(newMessage);
    const updatedChat = await this.chatModel.findOneAndUpdate(
      { usersName: users },
      { messages: unchangedMessages },
      { new: true },
    );
    return updatedChat;
  }

  async Message(data: {
    user1: string;
    user2: string;
    sender: string;
    message: string;
  }) {
    const users = [data.user1, data.user2].sort();
    const message = [Date.now(), data.sender, data.message];
    const chat = await this.chatModel.findOneAndUpdate(
      { usersName: users },
      { $push: { messages: message }, lastMessage: message },
      { new: true },
    );
    return chat;
  }

  async deleteChat(data: { user1: string; user2: string }) {
    const users = [data.user1, data.user2].sort();
    const chat = await this.chatModel.findOneAndDelete({ usersName: users });
    return chat;
  }

  async getChat(data: { user1: string; user2: string }) {
    const users = [data.user1, data.user2].sort();
    const chat = await this.chatModel.findOne({ usersName: users });
    if (chat) {
      return chat;
    }
  }
  async getChats(data: { user: string }) {
    const chats1 = await this.chatModel.find({ user1: data.user });
    const chats2 = await this.chatModel.find({ user2: data.user });
    const chats = [...chats1, ...chats2];
    return chats;
  }

  async createChat(data: { user1: string; user2: string }) {
    const users = [data.user1, data.user2].sort();
    const chat = await this.chatModel.findOne({ usersName: users });
    if (chat) {
      return chat;
    }
    const newChat = new this.chatModel({
      user1: users[0],
      user2: users[1],
      lastMessage: [Date.now(), '', '', ],
      usersName: users,
      messages: [],
    });
    const result = await newChat.save();
    return result;
  }
}
