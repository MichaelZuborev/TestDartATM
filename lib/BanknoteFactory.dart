import 'package:DartATM/AbstractBanknote.dart';
import 'package:DartATM/AbstractBanknoteFactory.dart';

class BanknoteFactory extends AbstractBanknoteFactory {
  @override
   List<AbstractBanknote> getBanknotes(String patter) {}

  @override
   List<int> parsePatternToList(String pattern) {}
}
