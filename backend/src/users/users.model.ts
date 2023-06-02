import * as mongoose from 'mongoose';


export class USER {
  constructor(
    public id: string,
    public Name: string,
    public email: string,
    public userName: string,
    public avatar: string,
    public bio: string,
    public hash: string,
    public hashedRt: { type: string },
    public following: string[],
    public followers: string[],
    public createdAt: Date,
    public role: string,
    ) {}
  }
  
  export const userSchema = new mongoose.Schema({
    Name: { type: String },
    email: { type: String, unique: true },
    userName: {type: String, unique: true },
    avatar: {type: String},
    bio: {type: String},
    hash: { type: String },
    hashedRt: { type: String },
    following: { type: [String] },
    followers: {type: [String]},
    createdAt: {type: Date},//
    role: { type: String },
  });