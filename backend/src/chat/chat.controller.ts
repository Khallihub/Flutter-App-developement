import { Body, Controller, Delete, Post, Put } from '@nestjs/common';
import { ChatService } from './chat.service';

@Controller('chat')
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Post('createChat')
  async createChat(@Body() data: { user1: string; user2: string }) {
    return await this.chatService.createChat(data);
  }

  @Post('getChat')
  async getChat(@Body() data: { user1: string; user2: string }) {
    return await this.chatService.getChat(data);
  }

  @Put('renameChat')
  async renameChat(
    @Body()
    data: {
      user1: string;
      user2: string;
      sender: string;
      newName: string;
    },
  ) {
    return await this.chatService.renameChat(data);
  }

  @Put('updatemessage')
  async updateMessage(
    @Body()
    data: {
      user1: string;
      user2: string;
      sender: string;
      time: string;
      message: string;
    },
  ) {
    return await this.chatService.updateMessage(data);
  }
  @Put('sendMessage')
  async Message(
    @Body()
    data: {
      user1: string;
      user2: string;
      sender: string;
      message: string;
    },
  ) {
    return await this.chatService.Message(data);
  }

  @Put('deleteMessage')
  async deleteMessage(
    @Body() data: { user1: string; user2: string; time: string },
  ) {
    return await this.chatService.deleteMessage(data);
  }

  @Delete('deleteChat')
  async deleteChat(@Body() data: { user1: string; user2: string }) {
    return await this.chatService.deleteChat(data);
  }
}
