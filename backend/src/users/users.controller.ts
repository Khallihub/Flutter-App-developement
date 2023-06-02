import { Body, Controller, Delete, Post } from '@nestjs/common';
import { UsersService } from './users.service';
import { userDto } from './userDto/user.dto';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post('getUser')
  async getUser(@Body() email: {email: string}){
    return this.usersService.findByemail(email)
  }

  @Post('search')
  async search(@Body() userName: {userName: string}){
    return this.usersService.findByUsername(userName)
  }

  @Post('updateProfile')
  async updateProfile(@Body() data: {email: string, userName: string,bio: string, password: string }){
    return this.usersService.updateProfile(data)
  }

  @Post('updateFollowers')
  async updateFollowers(@Body() data : {followerUsername: string, followedUsername: string}){
    console.log(data)
    return this.usersService.updateFollowers(data)
  }

  @Delete('deleteProfile')
  async deleteProfile(data: {userName: string, password: string}) {
    return this.usersService.deleteProfile(data)
  }
}
