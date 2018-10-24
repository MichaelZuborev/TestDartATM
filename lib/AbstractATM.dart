import 'package:DartATM/AbstractBanknote.dart';

abstract class AbstractATM{

  void setBanknotePattern(String pattern){}

  List<AbstractBanknote> getMoney(int money){}

  bool hasMoney(){}
}