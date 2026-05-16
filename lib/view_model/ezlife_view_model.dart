import 'package:flutter/foundation.dart';

class EzlifeViewModel extends ChangeNotifier {
  bool isClicked1Trait = false;
  bool isClicked2Trait = false;
  bool isClicked3Trait = false;
  bool isClicked4Trait = false;
  bool isClicked5Trait = false;

  void toggleTrait1() {
    isClicked1Trait = !isClicked1Trait;
    notifyListeners();
  }

  void toggleTrait2() {
    isClicked2Trait = !isClicked2Trait;
    notifyListeners();
  }

  void toggleTrait3() {
    isClicked3Trait = !isClicked3Trait;
    notifyListeners();
  }

  void toggleTrait4() {
    isClicked4Trait = !isClicked4Trait;
    notifyListeners();
  }

  void toggleTrait5() {
    isClicked5Trait = !isClicked5Trait;
    notifyListeners();
  }
}
