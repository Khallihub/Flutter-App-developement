import { Injectable, OnModuleInit } from '@nestjs/common';
import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@Injectable()
@WebSocketGateway()
export class GatewayService implements OnModuleInit, OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  connectedUsers: Map<string, Socket> = new Map();

  onModuleInit() {
    console.log('texting from onModuleInit');
  }

  handleConnection(@ConnectedSocket() socket: Socket) {
    console.log('texting from handleConnection');
    socket.on('joined', (users) => {
      console.log(users);
      this.connectedUsers.set(users.sender, socket);
    });

    socket.on('message', (data) => {
      console.log(data);
      console.log("message received");
      let receiver = this.connectedUsers.get(data.receiver);
      for (let [key, value] of this.connectedUsers) {
        console.log(key);
      }
      // console.log(receiver);
      if (receiver) {
        console.log("receiver found");
        const a = receiver.emit('message', data);
        console.log(a);
        console.log("message sent")
      }
    });
  }

  handleDisconnect(@ConnectedSocket() socket: Socket) {
    console.log('texting from handleDisconnect');
    socket.on('disconnect', (data) => {
      console.log('Socket disconnected');
      this.connectedUsers.delete(data);
    });
  }

  @SubscribeMessage('message')
  handleMessage(@MessageBody() payload: any) {
    // Handle incoming message and broadcast it to all connected clients
    // this.server.emit('message', payload);
  }
}
