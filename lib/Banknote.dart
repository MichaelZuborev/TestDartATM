import 'package:DartATM/AbstractBanknote.dart';

//Кдасс представляет купюру
class Banknote extends AbstractBanknote {
  //Номинал купюры
  int denomination;

  Banknote(int value) {
    if (!verifyValue(value)) {
      denomination = 1;
    } else {
      denomination = value;
    }
  }

  //Купюра не может быть номиналом меньше 1
  bool verifyValue(int value) {
    return value >= 1;
  }

  @override
  int get() {
    return denomination;
  }

  bool equals(Banknote that) {
    return this.get() == that.get();
  }
}
