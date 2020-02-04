import 'dart:async';

import 'package:esense/flameGame.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



FlameGame game;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  game = FlameGame();
  runApp(game.widget);
  // Set landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight
  ]);
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeRight);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}