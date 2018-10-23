import 'package:DartATM/AbstractBanknote.dart';

abstract class AbstractBanknoteFactory {
   List<AbstractBanknote> getBanknotes(String pattern) {}
   List<int> parsePatternToList(String pattern){}
}
