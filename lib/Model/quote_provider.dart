import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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

  void ran() {
    _count = random.nextInt(281);
  }

  void decrement() {
    if (_count == 0) {
      _count = 281;
    } else {
      _count--;
    }
    notifyListeners();
  }

  String _quote = '';

  String get quote {
    return _quote;
  }

  void setQuote(String txt) async {
    _quote = txt;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class Quotes {
  const Quotes(this._value);

  final String _value;

  String get quote => _value;
}
