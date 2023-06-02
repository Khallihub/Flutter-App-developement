"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userSchema = exports.USER = void 0;
const mongoose = require("mongoose");
class USER {
    constructor(id, Name, email, userName, avatar, bio, hash, hashedRt, following, followers, createdAt, role) {
        this.id = id;
        this.Name = Name;
        this.email = email;
        this.userName = userName;
        this.avatar = avatar;
        this.bio = bio;
        this.hash = hash;
        this.hashedRt = hashedRt;
        this.following = following;
        this.followers = followers;
        this.createdAt = createdAt;
        this.role = role;
    }
}
exports.USER = USER;
exports.userSchema = new mongoose.Schema({
    Name: { type: String },
    email: { type: String, unique: true },
    userName: { type: String, unique: true },
    avatar: { type: String },
    bio: { type: String },
    hash: { type: String },
    hashedRt: { type: String },
    following: { type: [String] },
    followers: { type: [String] },
    createdAt: { type: Date },
    role: { type: String },
});
//# sourceMappingURL=users.model.js.map