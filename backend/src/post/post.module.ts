import { Module } from '@nestjs/common';
import { PostController } from './post.controller';
import { PostService } from './post.service';
import { MongooseModule } from '@nestjs/mongoose';
import { postSchema } from './post.model';
import { userSchema } from 'src/users/users.model';

@Module({
  imports: [
    MongooseModule.forFeature([
      {
        name: 'post',
        schema: postSchema,
      },
    ]),
    MongooseModule.forFeature([
      {
        name: 'user',
        schema: userSchema,
      },
    ]),
  ],
  controllers: [PostController],
  providers: [PostService],
})
export class PostModule {}
