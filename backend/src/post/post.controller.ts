import { Body, Controller, Get, Post, Put } from '@nestjs/common';
import { PostService } from './post.service';
import { postDto } from './postDto/post.dto';

@Controller('post')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @Post('createPost')
  async createPost(@Body() dto: postDto) {
    return this.postService.createPost(dto);
  }

  @Get('getFeed')
  async getFeed() {
    return this.postService.getFeed();
  }
  
  
  @Post('getSinglePost')
  async getSinglePost(@Body() data: { id: string}) {
    return this.postService.getSinglePost(data);
  }

  @Post('like')
  async like_Unlike(@Body() data: { id: string; userName: string }) {
    return this.postService.like_Unlike(data);
  }

  @Post('dislike')
  async dislike_Undislike(@Body() data: { id: string; userName: string }) {
    return this.postService.dislike_Undislike(data);
  }

  @Post('comment')
  async comment(@Body() data: { id: string; userName: string; comment: string }) {
    return this.postService.comment(data);
  }
  
  @Post('getComments')
  async getComment(@Body() data: { id: string}) {
    return this.postService.getComments(data);
  }
  @Post('getLikes')
  async getLikes(@Body() data: { id: string}) {
    return this.postService.getLikes(data);
  }
  @Post('getDisLikes')
  async getDisLikes(@Body() data: { id: string}) {
    return this.postService.getDislikes(data);
  }

  @Post('deletePost')
  async deletePost(@Body() data: { id: string }) {
    return this.postService.deletePost(data);
  }

  @Put('updatePost')
  async updatePost(
    @Body()
    data: {
      id: string;
      userName: string;
      title: string;
      description: string;
      categories: string[];
      sourceURL: string;
    },
  ) {
    return this.postService.update_post(data);
  }
}
