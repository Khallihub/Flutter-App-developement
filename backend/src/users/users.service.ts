import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { userDto } from './userDto/user.dto';
import { USER } from './users.model';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(@InjectModel('user') private user: Model<USER>) {}

  async addUser(dto: userDto) {
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

  async findByUsername(info: { userName: string }): Promise<USER | undefined> {
    return await this.user.findOne({ userName: info.userName.toLowerCase() });
  }

  async findByemail(info: { email: string }): Promise<USER | undefined> {
    return await this.user.findOne({ email: info.email.toLowerCase() });
  }

  async updateProfile(data: {
    email: string;
    userName: string;
    bio: string;
    password: string;
  }) {
    if ((data.password = '')) {
      const updatedProfile = await this.user.findOneAndUpdate(
        { email: data.email },
        {
          userName: data.userName,
          //avatar: dto.avatar,
          bio: data.bio,
        },
        { new: true },
      );
      return updatedProfile;
    }
    const hashed = await this.hashData(data.password);
    data.password = hashed;

    const updatedProfile = await this.user.findOneAndUpdate(
      { email: data.email },
      {
        userName: data.userName,
        //avatar: dto.avatar,
        bio: data.bio,
        hash: data.password,
      },
      { new: true },
    );
    console.log(updatedProfile);
    return updatedProfile;
  }

  async updateFollowers(data: {
    followerUsername: string;
    followedUsername: string;
  }) {
    const follower = await this.findByUsername({
      userName: data.followerUsername,
    });
    const followed = await this.findByUsername({
      userName: data.followedUsername,
    });
    let temp2;
    if (followed.followers.includes(data.followerUsername)) {
      temp2 = followed.followers.filter(
        (item) => item !== data.followerUsername,
      );
    } else {
      followed.followers.push(data.followerUsername);
      temp2 = followed.followers;
    }

    let temp1;
    if (follower.following.includes(data.followedUsername)) {
      temp1 = follower.following.filter(
        (item) => item !== data.followedUsername,
      );
    } else {
      follower.following.push(data.followedUsername);
      temp1 = follower.following;
    }
    const newProfile1 = await this.user.findOneAndUpdate(
      { userName: data.followedUsername },
      { followers: temp2 },
      { new: true },
    );

    const newProfile2 = await this.user.findOneAndUpdate(
      { userName: data.followerUsername },
      { following: temp1 },
      { new: true },
    );
    if (!(newProfile1 && newProfile2)) {
      return 'failed';
    }
  }
  async deleteProfile(data: { userName: string; password: string }) {
    const user = await this.findByUsername({ userName: data.userName });
    const hash = this.hashData(data.password);
    if (hash === user.hash) {
      this.user.deleteOne({ userName: data.userName });
      return 'successful';
    } else {
      return 'incorrect password';
    }
  }

  hashData(data: string) {
    return bcrypt.hash(data, 10);
  }
  async updateUser(userId: string, arg1: { hashedRt: any }) {
    console.log(userId, arg1.hashedRt);
    const doc = await this.user.findByIdAndUpdate(userId, {
      hashedRt: arg1.hashedRt,
    });
    if (!doc) {
      throw new HttpException('A problem has occured', HttpStatus.BAD_REQUEST);
    } else {
      console.log('Updated document: ', doc);
    }
    return true;
  }
}
