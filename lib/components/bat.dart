import 'package:esense/components/enemy.dart';
import 'package:esense/flameGame.dart';

class Bat extends Enemy {

  Bat(FlameGame game) : super(game);

  @override
  void setVariables() {
    numberOfImages = 5;
    posX = game.screenSize.width;
    animationSpeed = 10;
    posY = 100;
    width = 100;
    length  = 100;
    speed = 12;
    path = "enemies/bat/tile00";
  }
}