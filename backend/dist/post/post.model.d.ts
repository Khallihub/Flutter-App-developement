import * as mongoose from 'mongoose';
import { USER } from 'src/users/users.model';
export declare class POST {
    id: string;
    title: string;
    description: string;
    author: USER;
    authorName: string;
    authorAvatar: string;
    createdAt: Date;
    likes: string[];
    dislikes: string[];
    rate: number;
    comments: any[][];
    categories: string[];
    shareCount: number;
    sourceURL: string;
    constructor(id: string, title: string, description: string, author: USER, authorName: string, authorAvatar: string, createdAt: Date, likes: string[], dislikes: string[], rate: number, comments: any[][], categories: string[], shareCount: number, sourceURL: string);
}
export declare const postSchema: mongoose.Schema<any, mongoose.Model<any, any, any, any, any, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, {
    categories: string[];
    likes: string[];
    dislikes: string[];
    comments: (mongoose.Types.DocumentArray<any> | any[] | {
        [x: string]: any;
    }[] | any[])[];
    createdAt?: string;
    title?: string;
    description?: string;
    author?: string;
    authorName?: string;
    authorAvatar?: string;
    sourceURL?: string;
    rate?: number;
    shareCount?: number;
}, mongoose.Document<unknown, {}, mongoose.FlatRecord<{
    categories: string[];
    likes: string[];
    dislikes: string[];
    comments: (mongoose.Types.DocumentArray<any> | any[] | {
        [x: string]: any;
    }[] | any[])[];
    createdAt?: string;
    title?: string;
    description?: string;
    author?: string;
    authorName?: string;
    authorAvatar?: string;
    sourceURL?: string;
    rate?: number;
    shareCount?: number;
}>> & Omit<mongoose.FlatRecord<{
    categories: string[];
    likes: string[];
    dislikes: string[];
    comments: (mongoose.Types.DocumentArray<any> | any[] | {
        [x: string]: any;
    }[] | any[])[];
    createdAt?: string;
    title?: string;
    description?: string;
    author?: string;
    authorName?: string;
    authorAvatar?: string;
    sourceURL?: string;
    rate?: number;
    shareCount?: number;
}> & {
    _id: mongoose.Types.ObjectId;
}, never>>;
