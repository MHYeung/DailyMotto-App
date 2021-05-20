import 'dart:math';

import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  final Random random = Random();
  int _count = 0;

  int get count {
    //_count = random.nextInt(282);
    return _count;
  }

  void increment() {
    if (_count == 281) {
      _count = 0;
    } else {
      _count++;
    }
    notifyListeners();
  }

  void ran(){
    _count = random.nextInt(281);
  }

  void decrement() {
    if(_count == 0){
      _count = 281;
    }else{
      _count--;
    }
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}
