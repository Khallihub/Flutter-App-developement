import mongoose from 'mongoose';

export class Chat {
  constructor(
    public user1: string,
    public user2: string,
    public lastMessage: string[],
    public usersName: string[],
    public messages: string[][], // [message, sender, date]
  ) {}
}

export const chatSchema = new mongoose.Schema({
  user1: {type: String},
  user2: {type: String},
  lastMessage: {type: [String]},
  usersName: { type: [String] },
  messages: { type: [[String]] },
});
