import * as mongoose from 'mongoose';
export declare class USER {
    id: string;
    Name: string;
    email: string;
    userName: string;
    avatar: string;
    bio: string;
    hash: string;
    hashedRt: {
        type: string;
    };
    following: string[];
    followers: string[];
    createdAt: Date;
    role: string;
    constructor(id: string, Name: string, email: string, userName: string, avatar: string, bio: string, hash: string, hashedRt: {
        type: string;
    }, following: string[], followers: string[], createdAt: Date, role: string);
}
export declare const userSchema: mongoose.Schema<any, mongoose.Model<any, any, any, any, any, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, {
    following: string[];
    followers: string[];
    Name?: string;
    email?: string;
    userName?: string;
    avatar?: string;
    bio?: string;
    role?: string;
    hash?: string;
    hashedRt?: string;
    createdAt?: Date;
}, mongoose.Document<unknown, {}, mongoose.FlatRecord<{
    following: string[];
    followers: string[];
    Name?: string;
    email?: string;
    userName?: string;
    avatar?: string;
    bio?: string;
    role?: string;
    hash?: string;
    hashedRt?: string;
    createdAt?: Date;
}>> & Omit<mongoose.FlatRecord<{
    following: string[];
    followers: string[];
    Name?: string;
    email?: string;
    userName?: string;
    avatar?: string;
    bio?: string;
    role?: string;
    hash?: string;
    hashedRt?: string;
    createdAt?: Date;
}> & {
    _id: mongoose.Types.ObjectId;
}, never>>;
