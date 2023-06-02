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
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const common_1 = require("@nestjs/common");
const users_service_1 = require("../users/users.service");
const jwt_1 = require("@nestjs/jwt");
const config_1 = require("@nestjs/config");
const bcrypt = require("bcrypt");
let AuthService = class AuthService {
    constructor(usersService, jwtService, config) {
        this.usersService = usersService;
        this.jwtService = jwtService;
        this.config = config;
    }
    async signupUser(dto) {
        const hashed = await this.hashData(dto.password);
        dto.password = hashed;
        const user = await this.usersService.addUser(dto);
        const tokens = await this.getTokens(user.email, user.role);
        await this.updateRtHash(user.id, tokens.refresh_token);
        const toFront = Object.assign(Object.assign({}, user), { password: undefined, hash: undefined, hashedRt: undefined });
        return Object.assign(Object.assign({}, tokens), { role: user.role, user: toFront });
    }
    async loginUser(dto) {
        const query = { email: dto.email };
        const user = await this.usersService.findByemail(query);
        if (!user) {
            throw new common_1.HttpException('User not found!', common_1.HttpStatus.FORBIDDEN);
        }
        else {
            const passwordMatches = await bcrypt.compare(dto.password, user.hash);
            if (!passwordMatches)
                throw new common_1.HttpException('Password is not correct', common_1.HttpStatus.FORBIDDEN);
            const tokens = await this.getTokens(user.email, user.role);
            await this.updateRtHash(user.id, tokens.refresh_token);
            const toFront = Object.assign(Object.assign({}, user), { password: undefined, hash: undefined, hashedRt: undefined });
            console.log(`user: ${user}`);
            return Object.assign(Object.assign({}, tokens), { role: user.role, user: toFront });
        }
    }
    async logoutUser(email) {
        const user = await this.usersService.findByemail(email);
        await this.updateRtHash(user.id, null);
    }
    async getTokens(email, role) {
        const [at, rt] = await Promise.all([
            this.jwtService.signAsync({
                sub: email,
                role,
            }, {
                secret: this.config.get('AT_SECRET'),
                expiresIn: 60 * 15,
            }),
            this.jwtService.signAsync({
                sub: email,
                email,
                role,
            }, {
                secret: this.config.get('RT_SECRET'),
                expiresIn: 60 * 60 * 24 * 7,
            }),
        ]);
        return {
            access_token: at,
            refresh_token: rt,
        };
    }
    async updateRtHash(userId, rt) {
        let hash;
        if (rt) {
            hash = await this.hashData(rt);
        }
        else {
            hash = null;
        }
        const doc = await this.usersService.updateUser(userId, {
            hashedRt: hash,
        });
        return true;
    }
    async refreshTokens(ref) {
        const query = { email: ref.email };
        const user = await this.usersService.findByemail(query);
        if (!user) {
            throw new common_1.HttpException('A problem has occured', common_1.HttpStatus.BAD_REQUEST);
        }
        else {
            if (!user || !user.hashedRt)
                throw new common_1.HttpException('Access Denied!', common_1.HttpStatus.FORBIDDEN);
            const rtMatches = await bcrypt.compare(ref.rt, user.hashedRt);
            console.log(rtMatches, ' ');
            if (!rtMatches) {
                throw new common_1.HttpException('Access Denied!', common_1.HttpStatus.FORBIDDEN);
            }
            else {
                const tokens = await this.getTokens(user.email, user.role);
                await this.updateRtHash(user.id, tokens.refresh_token);
                return Object.assign(Object.assign({}, tokens), { role: user.role });
            }
        }
    }
    hashData(data) {
        return bcrypt.hash(data, 10);
    }
};
AuthService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        jwt_1.JwtService,
        config_1.ConfigService])
], AuthService);
exports.AuthService = AuthService;
//# sourceMappingURL=auth.service.js.map