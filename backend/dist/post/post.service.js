"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PostService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
let PostService = class PostService {
    constructor(post, user) {
        this.post = post;
        this.user = user;
    }
    rate() {
        throw new Error('Method not implemented.');
    }
    async getSinglePost(data) {
        const post = await this.post.findById(data.id);
        return post;
    }
    async comment(data) {
        const post = await this.post.findById(data.id);
        let user_data = await this.user.find({ userName: data.userName });
        let temp = post.comments;
        temp.push([user_data, data.comment]);
        const updatePost = await this.post.findByIdAndUpdate({ _id: data.id }, { comments: temp }, { new: true });
        if (updatePost) {
            return updatePost;
        }
        else {
            return 'failed';
        }
    }
    async getComments(data) {
        const feed = await this.post.findById(data.id);
        const comments = feed.comments;
        return comments;
    }
    async getLikes(data) {
        const feed = await this.post.findById(data.id);
        const likes = feed.likes;
        return likes;
    }
    async getDislikes(data) {
        const feed = await this.post.findById(data.id);
        const dislikes = feed.dislikes;
        return dislikes;
    }
    async like_Unlike(data) {
        const post = await this.post.findById(data.id);
        let temp1 = post.likes;
        let temp2 = post.dislikes;
        let bool1 = post.likes.includes(data.userName);
        let bool2 = post.dislikes.includes(data.userName);
        if (!(bool1 || bool2)) {
            post.likes.push(data.userName);
            temp1 = post.likes;
        }
        else if (bool1 && !bool2) {
            temp1 = post.likes.filter((item) => item !== data.userName);
        }
        else if (!bool1 && bool2) {
            temp2 = post.dislikes.filter((item) => item !== data.userName);
            post.likes.push(data.userName);
            temp1 = post.likes;
        }
        else {
            temp1 = post.likes;
        }
        const updatedPost = await this.post.findByIdAndUpdate({ _id: data.id }, { likes: temp1, dislikes: temp2 }, { new: true });
        if (updatedPost) {
            return updatedPost;
        }
        else {
            return false;
        }
    }
    async update_post(data) {
        const updatedPost = await this.post.findByIdAndUpdate({ _id: data.id }, {
            title: data.title,
            description: data.description,
            categories: data.categories,
            sourceURL: data.sourceURL,
        }, { new: true });
        if (updatedPost) {
            return true;
        }
        else {
            return false;
        }
    }
    async dislike_Undislike(data) {
        const post = await this.post.findById(data.id);
        let temp1 = post.dislikes;
        let temp2 = post.likes;
        let bool1 = post.likes.includes(data.userName);
        let bool2 = post.dislikes.includes(data.userName);
        if (!(bool1 || bool2)) {
            post.dislikes.push(data.userName);
            temp1 = post.dislikes;
        }
        else if (!bool1 && bool2) {
            temp1 = post.dislikes.filter((item) => item !== data.userName);
        }
        else if (bool1 && !bool2) {
            temp2 = post.likes.filter((item) => item !== data.userName);
            post.dislikes.push(data.userName);
            temp1 = post.likes;
        }
        else {
            temp1 = post.dislikes;
        }
        const updatedPost = await this.post.findByIdAndUpdate({ _id: data.id }, { dislikes: temp1, likes: temp2 }, { new: true });
        if (updatedPost) {
            return updatedPost;
        }
        else {
            return false;
        }
    }
    async getFeed() {
        const feed = await this.post.find();
        return feed;
    }
    async createPost(dto) {
        const post = new this.post({
            title: dto.title,
            description: dto.description,
            author: dto.author,
            createdAt: Date.now(),
            categories: dto.categories,
            sourceURL: dto.sourceURL,
            authorName: dto.authorName,
            authorAvatar: dto.authorAvatar,
        });
        const result = await post.save();
        console.log(`post: ${result}`);
        return result;
    }
    async deletePost(data) {
        const result = await this.post.findByIdAndDelete(data.id);
        if (result) {
            return true;
        }
        else {
            return false;
        }
    }
};
PostService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)('post')),
    __param(1, (0, mongoose_1.InjectModel)('user')),
    __metadata("design:paramtypes", [mongoose_2.Model,
        mongoose_2.Model])
], PostService);
exports.PostService = PostService;
//# sourceMappingURL=post.service.js.map