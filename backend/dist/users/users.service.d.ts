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
import { userDto } from './userDto/user.dto';
import { USER } from './users.model';
export declare class UsersService {
    private user;
    constructor(user: Model<USER>);
    findByName(query: {
        text: string;
    }): Promise<(import("mongoose").Document<unknown, {}, USER> & Omit<USER & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)[]>;
    addUser(dto: userDto): Promise<import("mongoose").Document<unknown, {}, USER> & Omit<USER & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    findByUsername(info: {
        userName: string;
    }): Promise<USER | undefined>;
    findByUsernames(userNames: string[]): Promise<any[]>;
    findByemail(info: {
        email: string;
    }): Promise<USER | undefined>;
    updateProfile(email: string, userName: string, bio: string, password: string, avatarUrl: string): Promise<import("mongoose").Document<unknown, {}, USER> & Omit<USER & {
        _id: import("mongoose").Types.ObjectId;
    }, never>>;
    updateFollowers(data: {
        followerUsername: string;
        followedUsername: string;
    }): Promise<string>;
    deleteProfile(data: {
        userName: string;
        password: string;
    }): Promise<"successful" | "incorrect password">;
    hashData(data: string): any;
    updateUser(userId: string, arg1: {
        hashedRt: any;
    }): Promise<boolean>;
}
