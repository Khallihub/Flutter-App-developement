"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.postSchema = exports.POST = void 0;
const mongoose = require("mongoose");
class POST {
    constructor(id, title, description, author, authorName, authorAvatar, createdAt, likes, dislikes, rate, comments, categories, shareCount, sourceURL) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.author = author;
        this.authorName = authorName;
        this.authorAvatar = authorAvatar;
        this.createdAt = createdAt;
        this.likes = likes;
        this.dislikes = dislikes;
        this.rate = rate;
        this.comments = comments;
        this.categories = categories;
        this.shareCount = shareCount;
        this.sourceURL = sourceURL;
    }
}
exports.POST = POST;
exports.postSchema = new mongoose.Schema({
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
//# sourceMappingURL=post.model.js.map