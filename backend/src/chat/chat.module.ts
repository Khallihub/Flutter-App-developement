import { Module } from '@nestjs/common';
import { ChatController } from './chat.controller';
import { ChatService } from './chat.service';
import { chatSchema } from './chat.model';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [
    MongooseModule.forFeature([{
      name: 'chat',
      schema: chatSchema
    }]),
  ],
  controllers: [ChatController],
  providers: [ChatService]
})
export class ChatModule {}
