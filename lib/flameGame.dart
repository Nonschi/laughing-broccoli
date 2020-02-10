
import 'dart:math';
import 'dart:ui';
import 'package:esense/Menu.dart';
import 'package:esense/score.dart';
import 'package:esense/sensor.dart';
import 'package:esense/spawner.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'components/background.dart';
import 'components/duck.dart';
import 'components/errorScreen.dart';
import 'package:flutter/material.dart';

class FlameGame extends Game {
  Size screenSize;
  double tileSize;
  Random rnd;
  Background background;
  Duck duck;
  bool done = false;

  ErrorScreen errorScreen;
  bool sampling = false;
  Sensor sensor;
  Spawner spawner;
  bool gameOver = true;
  Score score;
  bool startingGame = false;

  Menu menu;

  FlameGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    duck = Duck(this);
    spawner = Spawner(this);
    sensor = Sensor(this);
    menu = Menu(this);
    score = Score(this);
    done = true;
  }

  void render(Canvas canvas) {
    if (done) {
      if(gameOver) {
        background.render(canvas);
        menu.render(canvas);
      } else if(this.startingGame) {
        background.render(canvas);
        duck.render(canvas);
        spawner.render(canvas);
        score.render(canvas);
      }
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  @override
  void update(double t) {
    if (sensor.accl[0] != null) {
      menu.data = true;
      print(menu.data.toString());
    }
    menu.update();
    if(this.startingGame) {
      if (!gameOver) {
        if (sensor.accl[0] != null) {
          if (sensor.gyro[1] < -10) {
            duck.onTap();
          }
        }
        score.update();
        spawner.update(t);
        background.update(t);
        menu.update();
        if (done) {
          duck.update(t);
        }
        //print(sensor.gyro[1].toString());
      }
    }
  }

  void starting() {
    // let duck walk in
    //everything from menu disappears
    gameOver = false;
    startingGame = true;
    duck = Duck(this);
    spawner = Spawner(this);
    menu = Menu(this);
    score = Score(this);
    //duck.walkIn();
  }


  void onTapDown(TapDownDetails d) {
    if(this.gameOver) {
      if(menu.data) {
        if(menu.playRect.contains(d.globalPosition)) {
          starting();
        }
      }
    }
  }

  void gameIsOver() {
    menu.restart = true;
    menu.starting = false;
    gameOver = true;
  }

  void disconnected() {
    //do Stuff when disconnected
  }
}
