import 'package:DartATM/ATM.dart';
import 'package:DartATM/AbstractBanknote.dart';
import 'dart:io';

main(List<String> arguments) {
  ATM atm = new ATM();

  print('Для выхода напишите exit');
  while (true) {
    print('Введите паттерн для банкнот:');
    String pattern = stdin.readLineSync();
    if(pattern == 'exit'){
      break;
    }
    try {
      atm.setBanknotePattern(pattern);
    } catch (e) {
      print('Неверный паттерн');
      continue;
    }
    print('Введите денежную сумму:');
    try {
      String moneyInput = stdin.readLineSync();
      if(moneyInput == 'exit'){
        break;
      }
      int money = int.parse(moneyInput);
      List<AbstractBanknote> banknotes = atm.getMoney(money);
      print('--------------');
      print('length: ' + banknotes.length.toString());
      for (int i = 0; i < banknotes.length; i++) {
        print((i+1).toString() + ':' + banknotes.elementAt(i).toString());
      }
      print('--------------');
    } catch (e) {
      print('Невозможно выдать сумму с указанным паттерном');
      continue;
    }
  }
}
