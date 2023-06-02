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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.GatewayService = void 0;
const common_1 = require("@nestjs/common");
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
let GatewayService = class GatewayService {
    constructor() {
        this.connectedUsers = new Map();
    }
    onModuleInit() {
        console.log('texting from onModuleInit');
    }
    handleConnection(socket) {
        socket.on('joined', (users) => {
            this.connectedUsers.set(users.sender, socket);
        });
        socket.on('message', (data) => {
            console.log("message received");
            let receiver = this.connectedUsers.get(data.receiver);
            if (receiver) {
                console.log("receiver found");
                const a = receiver.emit('message', data);
                console.log(a);
                console.log("message sent");
            }
        });
    }
    handleDisconnect(socket) {
        console.log('texting from handleDisconnect');
        socket.on('disconnect', (data) => {
            console.log('Socket disconnected');
            this.connectedUsers.delete(data);
        });
    }
    handleMessage(payload) {
    }
};
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], GatewayService.prototype, "server", void 0);
__decorate([
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket]),
    __metadata("design:returntype", void 0)
], GatewayService.prototype, "handleConnection", null);
__decorate([
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket]),
    __metadata("design:returntype", void 0)
], GatewayService.prototype, "handleDisconnect", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('message'),
    __param(0, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], GatewayService.prototype, "handleMessage", null);
GatewayService = __decorate([
    (0, common_1.Injectable)(),
    (0, websockets_1.WebSocketGateway)()
], GatewayService);
exports.GatewayService = GatewayService;
//# sourceMappingURL=gateway.service.js.map