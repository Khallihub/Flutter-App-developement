import { ValidationPipe } from '@nestjs/common';
import { NestFactory, Reflector } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {cors: true});
  app.useGlobalPipes(new ValidationPipe());
  // this is to protect all routes globally
  // const reflector = new Reflector()
  // app.useGlobalGuards(new JwtAuthGuard(reflector))
  await app.listen(3000);
}
bootstrap();
// OHFZPexLEIU2DaYp this is password for the db
