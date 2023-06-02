import mongoose from 'mongoose';
export declare class Chat {
    usersName: string[];
    messages: string[][];
    constructor(usersName: string[], messages: string[][]);
}
export declare const chatSchema: mongoose.Schema<any, mongoose.Model<any, any, any, any, any, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, {
    usersName: string[];
    messages: string[][];
}, mongoose.Document<unknown, {}, mongoose.FlatRecord<{
    usersName: string[];
    messages: string[][];
}>> & Omit<mongoose.FlatRecord<{
    usersName: string[];
    messages: string[][];
}> & {
    _id: mongoose.Types.ObjectId;
}, never>>;
