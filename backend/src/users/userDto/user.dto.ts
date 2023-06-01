import { IsAlphanumeric, IsArray, IsEmail, IsNotEmpty, IsString } from "class-validator";

export class userDto {
    @IsNotEmpty()
    @IsString()
    Name: string;

    @IsEmail()
    @IsNotEmpty()
    email: string;

    @IsAlphanumeric()
    @IsNotEmpty()
    userName: string

    @IsString()
    avatar: string

    @IsString()
    bio: string

    @IsString()
    @IsNotEmpty()
    password: string;

    @IsArray()
    following: string[]

    @IsArray()
    followers: string[]

    @IsString()
    @IsNotEmpty()
    role: string;
}