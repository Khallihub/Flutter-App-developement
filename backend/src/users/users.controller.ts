import { Body, Controller, Delete, Post } from '@nestjs/common';
import { UsersService } from './users.service';
import { userDto } from './userDto/user.dto';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post('getUser')
  async getUser(@Body() email: { email: string }) {
    return this.usersService.findByemail({ email: email.email });
  }

  @Post('getUsers')
  async getUsers(@Body() usersNames: { users: string[] }) {
    const users = usersNames['users'];
    return this.usersService.findByUsernames(users);
  }

  @Post('search')
  async search(@Body() userName: { userName: string }) {
    return this.usersService.findByUsername(userName);
  }
  @Post('searchUsers')
  async finadByName(@Body() query: { text: string }) {
    return this.usersService.findByName(query);
  }

  @Post('updateProfile')
  async updateProfile(
    @Body('email') email: string,
    @Body('userName') userName: string,
    @Body('bio') bio: string,
    @Body('password') password: string,
    @Body('avatarUrl') avatarUrl: string,
  ) {
    return this.usersService.updateProfile(
      email,
      userName,
      bio,
      password,
      avatarUrl,
    );
  }

  @Post('updateFollowers')
  async updateFollowers(
    @Body() data: { followerUsername: string; followedUsername: string },
  ) {
    return this.usersService.updateFollowers(data);
  }

  @Delete('deleteProfile')
  async deleteProfile(data: { userName: string; password: string }) {
    return this.usersService.deleteProfile(data);
  }
}
