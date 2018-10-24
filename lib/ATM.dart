import 'package:DartATM/AbstractATM.dart';
import 'package:DartATM/AbstractBanknote.dart';

//Класс представляет банкомат
class ATM extends AbstractATM{

  @override
  void setBanknotePattern(String pattern) {

  }

  //По условию в банкомате бесконечные деньги
  @override
  bool hasMoney() {
    return true;
  }

  @override
  List<AbstractBanknote> getMoney(int money) {

  }

}