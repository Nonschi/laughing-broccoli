import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';

import '../flameGame.dart';


class Background {
  final FlameGame game;
  Sprite bgSprite;
  Rect bgRect;
  List<Sprite> flyingSprite;
  double flyingSpriteIndex = 0;
  int flyingCounter = 0;
  int backgroundCounter = 0;
  double backgroundSpriteIndex = 0;
  List<Sprite> backgroundSprite;
  List<Sprite> frontSprite;
  Sprite light;
  double frontSpriteIndex = 0;
  int frontCounter = 0;

  Background(this.game) {
    flyingSprite = List<Sprite>();
    backgroundSprite = List<Sprite>();
    frontSprite = List<Sprite>();
    for(int i = 0; i < 16; i++) {
      if(i < 10) {
        flyingSprite.add(Sprite('background/trees/frames/frame_0' + i.toString() + '_delay-0.07s.gif'));
        backgroundSprite.add(Sprite('background/background/frames/frame_0' + i.toString() + '_delay-0.14s.gif'));
        frontSprite.add(Sprite('background/front/frames/frame_0' + i.toString() + '_delay-0.04s.gif'));
      } else {
        flyingSprite.add(Sprite('background/trees/frames/frame_' + i.toString() + '_delay-0.07s.gif'));
        backgroundSprite.add(Sprite('background/background/frames/frame_' + i.toString() + '_delay-0.14s.gif'));
        frontSprite.add(Sprite('background/front/frames/frame_' + i.toString() + '_delay-0.04s.gif'));
      }
    }
    light = new Sprite('background/lights/frame_0_delay-0.01s.gif');
    bgRect = Rect.fromLTWH(0, 0, game.screenSize.height, game.screenSize.width);
  }

  void render(Canvas c) {
    backgroundSprite[backgroundSpriteIndex.toInt()].renderRect(c, bgRect);
    light.renderRect(c, bgRect);
    flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, bgRect);
    frontSprite[frontSpriteIndex.toInt()].renderRect(c, bgRect);
  }

  void update(double t) {

    if(backgroundCounter == 12) {
      backgroundCounter = 0;
      backgroundSpriteIndex++;
      if (backgroundSpriteIndex == 15) {
        backgroundSpriteIndex =  0;
      }
    }
    if(frontCounter == 4) {
      frontCounter = 0;
      frontSpriteIndex++;
      if(frontSpriteIndex == 15) {
        frontSpriteIndex = 0;
      }
    }
    if (flyingCounter == 8){
      flyingCounter = 0;
      flyingSpriteIndex++;
      if(flyingSpriteIndex == 15) {
        flyingSpriteIndex = 0;
      }
    }
    backgroundCounter++;
    flyingCounter++;
    frontCounter++;
  }
}
