 import 'dart:ui';

import 'package:esense/flameGame.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';

class Score {

   FlameGame game;
   TextConfig textConfig;

   int scoreInt;
   int counter;
   Score(FlameGame game) {
    scoreInt = 0;
    counter = 0;
     this.game = game;
     Color color = Color(0xffffffff);
     textConfig = TextConfig(fontSize: 20, fontFamily: 'SigmarOne-Regular',
         textAlign: TextAlign.left).withColor(color);

   }

   void checkForNewHighScore() {

   }

   void render(Canvas canvas) {

    textConfig.render(canvas, scoreInt.toString(),
    Position(0, 0));
   }

   void update() {
     counter++;
     if (counter == 10) {
       counter = 0;
       scoreInt++;
     }
   }
 }