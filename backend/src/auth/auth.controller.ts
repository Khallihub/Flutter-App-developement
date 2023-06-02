import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { userDto } from 'src/users/userDto/user.dto';
import { AuthService } from './auth.service';
import { Public } from './decorators/isPublic.decorator';
import { loginDto } from './loginDto/login.dto';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  // @Post('validate')
  // validateUser(@Body() info: { username: string; pass: string }) {
  //   console.log(info);
  //   return this.authService.validateUser(info);
  // }

  @Public()
  @Post('signup/user')
  async signupUser(@Body() dto: userDto) {
    return this.authService.signupUser(dto);
  }

  @Public()
  @Post('login')
  async login(@Body() dto: loginDto) {
    return this.authService.loginUser(dto);
  }

  @Post('logout')
  async logout(@Body() email: {email : string}) {
    return this.authService.logoutUser(email);
  }

  @Post('refresh')
  async refreshTokens(@Body() ref: { email: string; rt: string }) {
    console.log(ref, 'fd');
    return this.authService.refreshTokens(ref);
  }
}
