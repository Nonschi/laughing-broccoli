import 'dart:math';
import 'dart:ui';

import 'package:esense/flameGame.dart';

import 'components/bat.dart';
import 'components/wolf.dart';

class Spawner {
  FlameGame game;
  int counterForSpawn;
  bool doubleWolfBool = false;
  int doubleWolfCounter = 0;
  bool firstOneOut = false;
  bool secondOneOut = false;
  List<Wolf> wolfes;
  List<Bat> bats;

  Spawner(FlameGame game) {
    counterForSpawn = 0;
    this.game = game;
    wolfes = new List<Wolf>();
    bats = new List<Bat>();
  }


  void spawnEnemies() {
    var rng = new Random();
    int number = rng.nextInt(10);
    int number2 = rng.nextInt(10);
    int number3 = rng.nextInt(10);
    if(number3 < 3) {
      doubleWolf();
    } else {
      if (number < 8) {
        addWolf();
      }
      if (number2 < 5) {
        addBat();
      }
    }
  }

  void doubleWolf() {
    doubleWolfBool = true;
  }

  void addWolf() {
    if (this.game.score.scoreInt % 150 == 0) {
        Wolf wolf = new Wolf(game);
        wolf.increaseSpeed();
        this.wolfes.add(wolf);
    }
    this.wolfes.add(new Wolf(game));
  }

  void addBat() {
    if (this.game.score.scoreInt % 150 == 0) {
      Bat bat = new Bat(game);
      bat.increaseSpeed();
      this.bats.add(bat);
    }
    this.bats.add(new Bat(game));
  }


  render(Canvas canvas) {
    if (this.wolfes.isNotEmpty) {
      for (Wolf wolf in wolfes) {
          wolf.render(canvas);
      }
    }
    if (this.bats.isNotEmpty) {
      for (Bat bat in bats) {
        bat.render(canvas);
      }
    }
  }

  update(double t) {
    if(doubleWolfBool) {
      if (!firstOneOut) {
        addWolf();
        firstOneOut = true;
      } else {
        doubleWolfCounter++;
        if(doubleWolfCounter == 110) {
          doubleWolfCounter = 0;
          firstOneOut = false;
          doubleWolfBool = false;
          addWolf();
        }
      }
    }
    counterForSpawn++;
    if (wolfes.length < 2 && counterForSpawn == 300) {
      counterForSpawn = 0;
      spawnEnemies();
    } else if (counterForSpawn == 400) {
      counterForSpawn = 0;
      spawnEnemies();
    }
    if (this.wolfes.isNotEmpty) {
      for (Wolf wolf in wolfes) {
        wolf.update(t);
      }
    }
    if (this.bats.isNotEmpty) {
      for (Bat bat in bats) {
        bat.update(t);
      }
    }
  }
}
