import 'dart:async';

import 'package:esense/flameGame.dart';
import 'package:esense_flutter/esense.dart';

class Sensor {
  bool connected = false;
  String _deviceStatus = '';
  bool sampling = false;
  FlameGame game;
  List<double> accl = List(3);
  List<double> gyro = List(3);
// the name of the eSense device to connect to -- change this to your own device.
  String eSenseName = 'eSense-0414';

  Sensor(FlameGame game) {
    this.game = game;
    _connectToESense();
  }


  Future<void> _connectToESense() async {
    ESenseManager.connectionEvents.listen((event) {

      if(event.type == ConnectionType.connected) {
        Timer(Duration(seconds: 2), () async {
          _startListenToSensorEvents();
          connected = true;
        });
      }

      switch (event.type) {
        case ConnectionType.connected:
          _deviceStatus = 'connected';
          break;
        case ConnectionType.unknown:
          _deviceStatus = 'unknown';
          break;
        case ConnectionType.disconnected:
          _deviceStatus = 'disconnected';
          break;
        case ConnectionType.device_found:
          _deviceStatus = 'device_found';
          break;
        case ConnectionType.device_not_found:
          _deviceStatus = 'device_not_found';
          break;
      }
      game.menu.status = _deviceStatus;
    });

    Timer.periodic(Duration(seconds: 4), (timer) async {
      await ESenseManager.connect(eSenseName);

      await new Future.delayed(const Duration(seconds : 3));
      if(_deviceStatus == 'device_found' || _deviceStatus == 'connected') {
        timer.cancel();
      }
    });
  }


  StreamSubscription subscription;
  void _startListenToSensorEvents() async {
    subscription = ESenseManager.sensorEvents.listen((event) {
      //print('SENSOR event: $event');
      extractSensorData(event.toString());
    });
  }

  void extractSensorData(String _event) {

    String _accl = _event.substring(_event.indexOf("accl: ") + 6 , _event.indexOf("gyro:") - 2);
    String _gyro = _event.substring(_event.indexOf("gyro: ") + 6);

    accl[0] = double.parse(_accl.substring(_accl.indexOf("[") + 1, _accl.indexOf(",")))/100;
    accl[1] = double.parse(_accl.substring(_accl.indexOf(",") + 1, _accl.lastIndexOf(",")))/100;
    accl[2] = double.parse(_accl.substring(_accl.lastIndexOf(",") + 1, _accl.lastIndexOf("]")))/100;
    gyro[0] = double.parse(_gyro.substring(_gyro.indexOf("[") + 1, _gyro.indexOf(",")))/100;
    gyro[1] = double.parse(_gyro.substring(_gyro.indexOf(",") + 1, _gyro.lastIndexOf(",")))/100;
    gyro[2] = double.parse(_gyro.substring(_gyro.lastIndexOf(",") + 1, _gyro.lastIndexOf("]")))/100;
  }

}



