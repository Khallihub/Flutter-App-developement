import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { tokens } from './types/types';
import { ConfigService } from '@nestjs/config';
import * as bcrypt from 'bcrypt';
import { userDto } from 'src/users/userDto/user.dto';
import { loginDto } from './loginDto/login.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
    private config: ConfigService,
  ) {}

  async signupUser(dto: userDto) {
    const hashed = await this.hashData(dto.password);
    dto.password = hashed;
    const user = await this.usersService.addUser(dto);
    const tokens = await this.getTokens(user.email, user.role);
    await this.updateRtHash(user.id, tokens.refresh_token);
    const toFront = {
      ...user,
      password: undefined,
      hash: undefined,
      hashedRt: undefined,
    };
    return { ...tokens, role: user.role, user: toFront };
  }

  async loginUser(dto: loginDto): Promise<any> {
    const query = { email: dto.email };
    const user = await this.usersService.findByemail(query);
    if (!user) {
      throw new HttpException('User not found!', HttpStatus.FORBIDDEN);
    } else {
      const passwordMatches = await bcrypt.compare(dto.password, user.hash);
      if (!passwordMatches)
        throw new HttpException(
          'Password is not correct',
          HttpStatus.FORBIDDEN,
        );
      const tokens = await this.getTokens(user.email, user.role);
      await this.updateRtHash(user.id, tokens.refresh_token);
      const toFront = {
        ...user,
        password: undefined,
        hash: undefined,
        hashedRt: undefined,
      };
      console.log(`user: ${user}`);
      return { ...tokens, role: user.role, user: toFront };
    }
  }

  async logoutUser(email: { email: string }) {
    const user = await this.usersService.findByemail(email);
    await this.updateRtHash(user.id, null);
  }
  async getTokens(email: string, role: string): Promise<tokens> {
    const [at, rt] = await Promise.all([
      this.jwtService.signAsync(
        {
          sub: email,
          role,
        },
        {
          secret: this.config.get<string>('AT_SECRET'),
          expiresIn: 60 * 15,
        },
      ),
      this.jwtService.signAsync(
        {
          sub: email,
          email,
          role,
        },
        {
          secret: this.config.get<string>('RT_SECRET'),
          expiresIn: 60 * 60 * 24 * 7,
        },
      ),
    ]);
    return {
      access_token: at,
      refresh_token: rt,
    };
  }

  async updateRtHash(userId: string, rt: string) {
    let hash;
    if (rt) {
      hash = await this.hashData(rt);
    } else {
      hash = null;
    }
    const doc = await this.usersService.updateUser(userId, {
      hashedRt: hash,
    });
    // if (!doc) {
    //   throw new HttpException('A problem has occured', HttpStatus.BAD_REQUEST);
    // } else {
    //   console.log('Updated document: ', doc);
    // }
    return true;
  }

  async refreshTokens(ref: { email: string; rt: string }) {
    const query = { email: ref.email };
    const user = await this.usersService.findByemail(query);
    // console.log(user)
    // console.log(user.toJSON());
    if (!user) {
      throw new HttpException('A problem has occured', HttpStatus.BAD_REQUEST);
      //console.error(err);
    } else {
      //console.log(user);
      if (!user || !user.hashedRt)
        throw new HttpException('Access Denied!', HttpStatus.FORBIDDEN);
      const rtMatches = await bcrypt.compare(ref.rt, user.hashedRt);
      console.log(rtMatches, ' ');
      if (!rtMatches) {
        throw new HttpException('Access Denied!', HttpStatus.FORBIDDEN);
      } else {
        const tokens = await this.getTokens(user.email, user.role);
        await this.updateRtHash(user.id, tokens.refresh_token);
        return { ...tokens, role: user.role };
      }
    }
  }

  // async validateUser(info: { username: string; pass: string }): Promise<any> {
  //   const user = await this.usersService.findUser(info);
  //   // check if you are comparing hash
  //   if (user && user.hash === info.pass) {
  //     const { hash, ...result } = user;
  //     return result;
  //   }
  //   return null;
  // }

  hashData(data: string) {
    return bcrypt.hash(data, 10);
  }

  // async login(user: any) {
  //   const payload = { username: user.username, sub: user.userId };
  //   return {
  //     access_token: this.jwtService.sign(payload),
  //   };
  // }
}
