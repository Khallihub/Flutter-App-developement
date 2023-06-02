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
import { userDto } from 'src/users/userDto/user.dto';
import { AuthService } from './auth.service';
import { loginDto } from './loginDto/login.dto';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    signupUser(dto: userDto): Promise<{
        role: string;
        user: {
            password: any;
            hash: any;
            hashedRt: any;
            _id: import("mongoose").Types.ObjectId;
            __v?: any;
            $locals: Record<string, unknown>;
            $op: "save" | "validate" | "remove";
            $where: Record<string, unknown>;
            baseModelName?: string;
            collection: import("mongoose").Collection<import("bson").Document>;
            db: import("mongoose").Connection;
            errors?: import("mongoose").Error.ValidationError;
            id: any;
            isNew: boolean;
            schema: import("mongoose").Schema<any, import("mongoose").Model<any, any, any, any, any, any>, {}, {}, {}, {}, import("mongoose").DefaultSchemaOptions, {
                [x: string]: any;
            }, import("mongoose").Document<unknown, {}, import("mongoose").FlatRecord<{
                [x: string]: any;
            }>> & Omit<import("mongoose").FlatRecord<{
                [x: string]: any;
            }> & Required<{
                _id: unknown;
            }>, never>>;
            Name: string;
            email: string;
            userName: string;
            avatar: string;
            bio: string;
            following: string[];
            followers: string[];
            role: string;
            createdAt: Date;
        };
        access_token: string;
        refresh_token: string;
    }>;
    login(dto: loginDto): Promise<any>;
    logout(email: {
        email: string;
    }): Promise<void>;
    refreshTokens(ref: {
        email: string;
        rt: string;
    }): Promise<{
        role: string;
        access_token: string;
        refresh_token: string;
    }>;
}
