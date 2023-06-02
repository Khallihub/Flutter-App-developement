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
import { postDto } from './postDto/post.dto';
import { Model } from 'mongoose';
import { POST } from './post.model';
import { USER } from 'src/users/users.model';
export declare class PostService {
    private post;
    private user;
    constructor(post: Model<POST>, user: Model<USER>);
    rate(): void;
    getSinglePost(data: {
        id: string;
    }): Promise<import("mongoose").Document<unknown, {}, POST> & Omit<POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    comment(data: {
        id: string;
        userName: string;
        comment: string;
    }): Promise<(import("mongoose").Document<unknown, {}, POST> & Omit<POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>) | "failed">;
    getComments(data: {
        id: string;
    }): Promise<any[][]>;
    getLikes(data: {
        id: string;
    }): Promise<string[]>;
    getDislikes(data: {
        id: string;
    }): Promise<string[]>;
    like_Unlike(data: {
        id: string;
        userName: string;
    }): Promise<false | (import("mongoose").Document<unknown, {}, POST> & Omit<POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)>;
    async: any;
    update_post(data: {
        id: string;
        userName: string;
        title: string;
        description: string;
        categories: string[];
        sourceURL: string;
    }): Promise<boolean>;
    dislike_Undislike(data: {
        id: string;
        userName: string;
    }): Promise<false | (import("mongoose").Document<unknown, {}, POST> & Omit<POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)>;
    getFeed(): Promise<(import("mongoose").Document<unknown, {}, POST> & Omit<POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)[]>;
    createPost(dto: postDto): Promise<import("mongoose").Document<unknown, {}, POST> & Omit<POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    deletePost(data: {
        id: string;
    }): Promise<boolean>;
}
