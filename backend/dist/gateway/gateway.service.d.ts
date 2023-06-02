import { OnModuleInit } from '@nestjs/common';
import { OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
export declare class GatewayService implements OnModuleInit, OnGatewayConnection, OnGatewayDisconnect {
    server: Server;
    connectedUsers: Map<string, Socket>;
    onModuleInit(): void;
    handleConnection(socket: Socket): void;
    handleDisconnect(socket: Socket): void;
    handleMessage(payload: any): void;
}
