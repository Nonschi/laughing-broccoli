
import 'dart:ui';

import 'package:flame/sprite.dart';

import '../flameGame.dart';

abstract class Enemy {

  //variables to set
  double posX;
  double posY;
  double width;
  double length;
  double speed;
  String path;
  double animationSpeed;
  double numberOfImages;

  //vars already set
  List<Sprite> sprites;
  double spriteIndex;
  Rect rectangle;
  bool onScreen = true;
  FlameGame game;
  double stepCounter;
  void setVariables();
  int animationCounter;
  int counterInFrame;

  Enemy(FlameGame game) {
    counterInFrame = 0;
    this.game = game;
    setVariables();
    initialize();
  }

  void initialize() {
    spriteIndex = 0;
    onScreen = true;
    stepCounter = 0;
    sprites = List<Sprite>();
    animationCounter = 0;
    for (int i = 0; i < numberOfImages; i++) {
      sprites.add(Sprite(path + i.toString() + ".png"));
    }
    rectangle = Rect.fromLTWH(posX, posY, width, length);
  }

  void update(double t) {
    animationCounter++;
    if(animationCounter == animationSpeed) {
      animationCounter = 0;
      spriteIndex++;
      if(spriteIndex == numberOfImages) {
        spriteIndex = 0;
      }
    }
    stepCounter++;
    if(stepCounter == 5) {
      stepCounter = 0;
      rectangle = rectangle.translate(-1 * speed, 0);
    }
  }

  void render(Canvas canvas) {
    if(onScreen) {
      sprites[spriteIndex.toInt()].renderRect(canvas, rectangle);
      hitDuck();
    }
  }

  void hitDuck() {
    if (game.duck.duckRect.overlaps(this.rectangle)) {
      counterInFrame++;
      if(counterInFrame == 17) {
       this.game.gameIsOver();
      }
    } else {
      counterInFrame = 0;
    }
  }

  void increaseSpeed() {
    this.speed = this.speed + 3;
  }

}