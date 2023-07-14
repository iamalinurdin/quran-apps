import 'package:flutter/material.dart';

class AudioProvider with ChangeNotifier {
  bool _isPlay = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  bool get isPlay => _isPlay;
  Duration get duration => _duration;
  Duration get position => _position;

  set isPlay(bool value) {
    _isPlay = value;
    notifyListeners();
  }
  
  set duration(Duration value) {
    _duration = value;
    notifyListeners();
  }

  set position(Duration value) {
    _position = value;
    notifyListeners();
  }
}