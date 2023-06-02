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
exports.UsersService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
const bcrypt = require("bcrypt");
let UsersService = class UsersService {
    constructor(user) {
        this.user = user;
    }
    async addUser(dto) {
        const user = new this.user({
            Name: dto.Name,
            email: dto.email.toLowerCase(),
            userName: dto.userName.toLowerCase(),
            avatar: dto.avatar,
            bio: dto.bio,
            following: dto.following,
            followers: dto.followers,
            createdAt: Date.now(),
            hash: dto.password,
            role: dto.role,
        });
        const result = await user.save();
        return result;
    }
    async findByUsername(info) {
        return await this.user.findOne({ userName: info.userName.toLowerCase() });
    }
    async findByemail(info) {
        return await this.user.findOne({ email: info.email.toLowerCase() });
    }
    async updateProfile(data) {
        if ((data.password = '')) {
            const updatedProfile = await this.user.findOneAndUpdate({ email: data.email }, {
                userName: data.userName,
                bio: data.bio,
            }, { new: true });
            return updatedProfile;
        }
        const hashed = await this.hashData(data.password);
        data.password = hashed;
        const updatedProfile = await this.user.findOneAndUpdate({ email: data.email }, {
            userName: data.userName,
            bio: data.bio,
            hash: data.password,
        }, { new: true });
        console.log(updatedProfile);
        return updatedProfile;
    }
    async updateFollowers(data) {
        const follower = await this.findByUsername({
            userName: data.followerUsername,
        });
        const followed = await this.findByUsername({
            userName: data.followedUsername,
        });
        let temp2;
        if (followed.followers.includes(data.followerUsername)) {
            temp2 = followed.followers.filter((item) => item !== data.followerUsername);
        }
        else {
            followed.followers.push(data.followerUsername);
            temp2 = followed.followers;
        }
        let temp1;
        if (follower.following.includes(data.followedUsername)) {
            temp1 = follower.following.filter((item) => item !== data.followedUsername);
        }
        else {
            follower.following.push(data.followedUsername);
            temp1 = follower.following;
        }
        const newProfile1 = await this.user.findOneAndUpdate({ userName: data.followedUsername }, { followers: temp2 }, { new: true });
        const newProfile2 = await this.user.findOneAndUpdate({ userName: data.followerUsername }, { following: temp1 }, { new: true });
        if (!(newProfile1 && newProfile2)) {
            return 'failed';
        }
    }
    async deleteProfile(data) {
        const user = await this.findByUsername({ userName: data.userName });
        const hash = this.hashData(data.password);
        if (hash === user.hash) {
            this.user.deleteOne({ userName: data.userName });
            return 'successful';
        }
        else {
            return 'incorrect password';
        }
    }
    hashData(data) {
        return bcrypt.hash(data, 10);
    }
    async updateUser(userId, arg1) {
        console.log(userId, arg1.hashedRt);
        const doc = await this.user.findByIdAndUpdate(userId, {
            hashedRt: arg1.hashedRt,
        });
        if (!doc) {
            throw new common_1.HttpException('A problem has occured', common_1.HttpStatus.BAD_REQUEST);
        }
        else {
            console.log('Updated document: ', doc);
        }
        return true;
    }
};
UsersService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)('user')),
    __metadata("design:paramtypes", [mongoose_2.Model])
], UsersService);
exports.UsersService = UsersService;
//# sourceMappingURL=users.service.js.map