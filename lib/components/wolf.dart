import '../flameGame.dart';
import 'enemy.dart';

class Wolf extends Enemy {

  Wolf(FlameGame game) : super(game);

  @override
  void setVariables() {
    numberOfImages = 5;
    posX = game.screenSize.width;
    animationSpeed = 5;
    posY = 200;
    width = 140;
    length  = 120;
    speed = 20;
    path = "enemies/wolf/tile00";
  }


}