import mongoose from 'mongoose';
export declare class Chat {
    user1: string;
    user2: string;
    lastMessage: string[];
    usersName: string[];
    messages: string[][];
    constructor(user1: string, user2: string, lastMessage: string[], usersName: string[], messages: string[][]);
}
export declare const chatSchema: mongoose.Schema<any, mongoose.Model<any, any, any, any, any, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, {
    lastMessage: string[];
    usersName: string[];
    messages: string[][];
    user1?: string;
    user2?: string;
}, mongoose.Document<unknown, {}, mongoose.FlatRecord<{
    lastMessage: string[];
    usersName: string[];
    messages: string[][];
    user1?: string;
    user2?: string;
}>> & Omit<mongoose.FlatRecord<{
    lastMessage: string[];
    usersName: string[];
    messages: string[][];
    user1?: string;
    user2?: string;
}> & {
    _id: mongoose.Types.ObjectId;
}, never>>;
