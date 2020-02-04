import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'flameGame.dart';

class Menu {

  FlameGame game;
  bool starting = true;
  bool restart = false;
  Rect playRect;
  Rect scoreRect;
  Sprite play;
  Sprite restartSprite;
  Sprite highScoreSprite;
  Rect highScoreRect;
  String status;
  TextConfig textConfig;
  String text;
  bool data = false;
  Sprite playGrey;

  Menu(FlameGame game) {
    Color color = Color(0xff00ff00);
    play = Sprite("Menu/b_Play2.png");
    playGrey = Sprite("Menu/b_Play2Grey.png");
    restartSprite= Sprite("Menu/b_Restart.png");
    highScoreSprite = Sprite("Menu/b_Leaderboard.png");
    starting = true;
    this.game = game;
    text = "Hello please connect the eSense-Earable: 4014 \n Otherwise you can't play the game.";
    textConfig = TextConfig(fontSize: 22, fontFamily: 'SigmarOne-Regular',
        textAlign: TextAlign.center).withColor(color);
  }

  void restartGame() {
    restart = true;
  }

  void render(Canvas canvas) {
    if(starting) {
      textConfig.render(canvas, text,
          Position(
              game.screenSize.width / 2 - 300, game.screenSize.height / 2 - 100));
    } else {
      textConfig.render(canvas, "Your Score was: " + game.score.scoreInt.toString() + "\n Come on, try again :)",
          Position(
              game.screenSize.width / 2 - 150, game.screenSize.height / 2 - 100));
    }
    playRect = Rect.fromLTWH(
      game.screenSize.width / 2 - 40,
       game.screenSize.height / 2,
        80,
        80
    );
    if (!data) {
      playGrey.renderRect(canvas, playRect);
    } else if (starting) {
      play.renderRect(canvas, playRect);
    }
    if (restart) {
      restartSprite.renderRect(canvas, playRect);
    }
  }


    void onTap() {
      if (data) {
        game.starting();
      }
    }

    void update() {
      switch (status) {
        case "connected":
          if (data) {
            text =
            "Move your head up to make the duck jump. \n Avoid the dangerous animals in the forest!";
          } else {
            text =
            "The device is connected, it just needs a while \n to get the data.";
          }
          break;
        case "unknown":
          text =
          "Hello please connect the esense-Earable \n Otherwise you can't play the game.";
          break;
        case "disconnected":
          text =
          "The device has been disconnected, please reconnect \n Otherwise you can't play the game.";
          break;
        case "device_found":
          text ="The device is connected, it just needs a while \n to get the data.";
          break;
        case "device_not_found":
          text = "The device hasn't been found! \n please connect the eSense-Earable: 0414";
          break;
      }
    }
  }
