import * as mongoose from 'mongoose';
import { USER } from 'src/users/users.model';

export class POST {
  constructor(
    public id: string,
    public title: string,
    public description: string,
    public author: USER,
    public authorName: string,
    public authorAvatar: string,
    public createdAt: Date,
    public likes: string[],
    public dislikes: string[],
    public rate: number,
    public comments: any[][],
    public categories: string[],
    public shareCount: number,
    public sourceURL: string,
  ) {}
}

export const postSchema = new mongoose.Schema({
  title: { type: String },
  description: { type: String },
  author: { type: String },
  authorName: { type: String },
  authorAvatar: { type: String },
  createdAt: { type: String },
  likes: { type: [String] },
  dislikes: { type: [String] },
  rate: { type: Number },
  comments: { type: [[]] },
  categories: { type: [String] },
  shareCount: { type: Number },
  sourceURL: { type: String },
});
