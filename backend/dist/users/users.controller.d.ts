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
import { UsersService } from './users.service';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    getUser(email: {
        email: string;
    }): Promise<import("./users.model").USER>;
    getUsers(usersNames: {
        users: string[];
    }): Promise<any[]>;
    search(userName: {
        userName: string;
    }): Promise<import("./users.model").USER>;
    finadByName(query: {
        text: string;
    }): Promise<(import("mongoose").Document<unknown, {}, import("./users.model").USER> & Omit<import("./users.model").USER & {
        _id: import("mongoose").Types.ObjectId;
    }, never>)[]>;
    updateProfile(email: string, userName: string, bio: string, password: string, avatarUrl: string): Promise<import("mongoose").Document<unknown, {}, import("./users.model").USER> & Omit<import("./users.model").USER & {
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
}
