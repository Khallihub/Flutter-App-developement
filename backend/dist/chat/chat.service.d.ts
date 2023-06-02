/// <reference types="mongoose/types/aggregate" />
/// <reference types="mongoose/types/callback" />
/// <reference types="mongoose/types/collection" />
/// <reference types="mongoose/types/connection" />
/// <reference types="mongoose/types/cursor" />
/// <reference types="mongoose/types/document" />
/// <reference types="mongoose/types/error" />
/// <reference types="mongoose/types/expressions" />
/// <reference types="mongoose/types/helpers" />
/// <reference types="mongoose/types/middlewares" />
/// <reference types="mongoose/types/indexes" />
/// <reference types="mongoose/types/models" />
/// <reference types="mongoose/types/mongooseoptions" />
/// <reference types="mongoose/types/pipelinestage" />
/// <reference types="mongoose/types/populate" />
/// <reference types="mongoose/types/query" />
/// <reference types="mongoose/types/schemaoptions" />
/// <reference types="mongoose/types/schematypes" />
/// <reference types="mongoose/types/session" />
/// <reference types="mongoose/types/types" />
/// <reference types="mongoose/types/utility" />
/// <reference types="mongoose/types/validation" />
/// <reference types="mongoose/types/virtuals" />
/// <reference types="mongoose/types/inferschematype" />
import { Model } from 'mongoose';
import { Chat } from './chat.model';
export declare class ChatService {
    private chatModel;
    constructor(chatModel: Model<Chat>);
    deleteMessage(data: {
        user1: string;
        user2: string;
        time: string;
    }): Promise<void>;
    renameChat(data: {
        user1: string;
        user2: string;
        sender: string;
        newName: string;
    }): Promise<import("mongoose").Document<unknown, {}, Chat> & Omit<Chat & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    updateMessage(data: {
        user1: string;
        user2: string;
        sender: string;
        time: string;
        message: string;
    }): Promise<import("mongoose").Document<unknown, {}, Chat> & Omit<Chat & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    Message(data: {
        user1: string;
        user2: string;
        sender: string;
        message: string;
    }): Promise<import("mongoose").Document<unknown, {}, Chat> & Omit<Chat & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    deleteChat(data: {
        user1: string;
        user2: string;
    }): Promise<import("mongoose").Document<unknown, {}, Chat> & Omit<Chat & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    getChat(data: {
        user1: string;
        user2: string;
    }): Promise<import("mongoose").Document<unknown, {}, Chat> & Omit<Chat & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    createChat(data: {
        user1: string;
        user2: string;
    }): Promise<import("mongoose").Document<unknown, {}, Chat> & Omit<Chat & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
}
