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
/// <reference types="mongoose" />
/// <reference types="mongoose/types/inferschematype" />
import { PostService } from './post.service';
import { postDto } from './postDto/post.dto';
export declare class PostController {
    private readonly postService;
    constructor(postService: PostService);
    createPost(dto: postDto): Promise<import("mongoose").Document<unknown, {}, import("./post.model").POST> & Omit<import("./post.model").POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    getFeed(): Promise<(import("mongoose").Document<unknown, {}, import("./post.model").POST> & Omit<import("./post.model").POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)[]>;
    getSinglePost(data: {
        id: string;
    }): Promise<import("mongoose").Document<unknown, {}, import("./post.model").POST> & Omit<import("./post.model").POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    like_Unlike(data: {
        id: string;
        userName: string;
    }): Promise<false | (import("mongoose").Document<unknown, {}, import("./post.model").POST> & Omit<import("./post.model").POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)>;
    dislike_Undislike(data: {
        id: string;
        userName: string;
    }): Promise<false | (import("mongoose").Document<unknown, {}, import("./post.model").POST> & Omit<import("./post.model").POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)>;
    comment(data: {
        id: string;
        userName: string;
        comment: string;
    }): Promise<(import("mongoose").Document<unknown, {}, import("./post.model").POST> & Omit<import("./post.model").POST & {
        _id: import("mongoose").Types.ObjectId;
    }, never>) | "failed">;
    getComment(data: {
        id: string;
    }): Promise<any[][]>;
    getLikes(data: {
        id: string;
    }): Promise<string[]>;
    getDisLikes(data: {
        id: string;
    }): Promise<string[]>;
    deletePost(data: {
        id: string;
    }): Promise<boolean>;
    updatePost(data: {
        id: string;
        userName: string;
        title: string;
        description: string;
        categories: string[];
        sourceURL: string;
    }): Promise<boolean>;
}
