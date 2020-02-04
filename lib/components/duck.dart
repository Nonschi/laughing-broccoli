

import 'dart:ui';

import 'package:flame/sprite.dart';

import '../flameGame.dart';

class Duck {
  FlameGame game;
  Sprite bgSprite;
  Rect duckRect;
  Offset offset;
  bool isTapped = false;
  bool movingUp = false;
  bool movingDown = false;
  List<Sprite> flyingSprite;
  double flyingSpriteIndex = 0;
  bool jumping = false;
  Rect jumpRect;
  double jumpingSpriteIndex = 0;
  List<Sprite> jumpingSprite;
  bool done = false;
  int standStillCounter;

  Duck(this.game) {
    flyingSprite = List<Sprite>();
    jumpingSprite = List<Sprite>();
    for (int i = 0; i < 7; i++) {
      flyingSprite.add(Sprite(
          'duck/frames/frames/frame_' + i.toString() + '_delay-0.15s.gif'));
      jumpingSprite.add(Sprite(
          'duck/frames/frames/jump/frame_' + i.toString() + '_delay-0.1s.gif'));
    }
    jumpingSprite.add(Sprite("duck/frames/frames/jump/frame_7_delay-0.1s.gif"));
    duckRect = Rect.fromLTWH(70, 250, 70, 70);
    jumpRect = Rect.fromLTWH(duckRect.top, duckRect.left, 30, 30);
    done = true;
    standStillCounter = 0;
  }

  void render(Canvas c) {
    flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, duckRect);
    if (jumping && !movingDown) {
      jumpingSprite[jumpingSpriteIndex.toInt()].renderRect(c, jumpRect);
    }
  }

  void onTap() {
    if (!jumping) {
      isTapped = true;
      movingUp = true;
    }
  }

  update(double t) {
    //increasing index for sprites
    flyingSpriteIndex++;
    if (flyingSpriteIndex == 6) {
      flyingSpriteIndex = 0;
    }

    if (isTapped) {
      //moving up
      jumping = true;
      if (movingUp) {
        duckRect = duckRect.translate(0, -4);
        jumpRect = Rect.fromLTWH(duckRect.left + 15, duckRect.top + 60, 30, 30);
        if (flyingSpriteIndex % 4 == 0) {
          jumpingSpriteIndex++;
          if (jumpingSpriteIndex == 7) {
            jumpingSpriteIndex = 0;
          }
        }
        if (duckRect.top < 100) {
          movingUp = false;
        }
      }
      if (jumping && !movingUp) {
        standStillCounter++;
        if (flyingSpriteIndex % 4 == 0) {
          jumpingSpriteIndex++;
          if (jumpingSpriteIndex == 7) {
            jumpingSpriteIndex = 0;
          }
        }
        if (standStillCounter == 30) {
          standStillCounter = 0;
          movingDown = true;
        }
      }
        //moving down
        if (movingDown) {
          duckRect = duckRect.translate(0, 4);
          if (duckRect.top >= 250) {
            movingDown = false;
            isTapped = false;
            jumping = false;
          }
        }
      }
    }

    void walkIn() {

    }
  }

