import 'package:DartATM/Banknote.dart';
import 'package:DartATM/AbstractBanknote.dart';
import 'package:DartATM/AbstractBanknoteFactory.dart';

/*
* Паттерн должен быть написан только с использованием цифр, запятых и пробелов,
* в случае несоблюдения условия фабрика вернет null
* */
class BanknoteFactory extends AbstractBanknoteFactory {
  @override
  List<AbstractBanknote> getBanknotes(String pattern) {
    List<int> banknoteValues = parsePatternToList(pattern);
    if (banknoteValues == null) {
      return null;
    }
    List<Banknote> banknotes = new List();
    banknoteValues.forEach((element) => banknotes.add(new Banknote(element)));
    return banknotes;
  }

  @override
  List<int> parsePatternToList(String pattern) {
    pattern.replaceAll(' ', '');
    if (pattern.contains('-')) {
      return null;
    }
    List<String> splittedValues = pattern.split(',');
    List<int> result = new List();
    splittedValues.forEach((element) => result.add(int.tryParse(element)));
    if (result.contains(null) || result.contains(0)) {
      return null;
    } else {
      return result;
    }
  }
}
