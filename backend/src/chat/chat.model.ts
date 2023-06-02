import mongoose from 'mongoose';

export class Chat {
  constructor(
    public usersName: string[],
    public messages: string[][], // [message, sender, date]
  ) {}
}

export const chatSchema = new mongoose.Schema({
  usersName: { type: [String] },
  messages: { type: [[String]] },
});
