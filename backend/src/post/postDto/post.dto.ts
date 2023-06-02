import { IsArray, IsNotEmpty, IsString } from "class-validator";

export class postDto {
    // @IsNotEmpty()
    @IsString()
    title: string;

    @IsString()
    description: string;

    @IsString()
    @IsNotEmpty()
    author: string;

    @IsString()
    @IsNotEmpty()
    authorName: string;

    @IsString()
    authorAvatar: string;

    @IsArray()
    @IsNotEmpty()
    categories: string[]
    
    @IsNotEmpty()
    @IsString()
    sourceURL: string
}