import 'package:DartATM/AbstractATM.dart';
import 'package:DartATM/AbstractBanknote.dart';
import 'package:DartATM/Banknote.dart';
import 'package:DartATM/AbstractBanknoteFactory.dart';
import 'package:DartATM/BanknoteFactory.dart';

//Класс представляет банкомат
class ATM extends AbstractATM {
  List<AbstractBanknote> banknoteTypes;
  AbstractBanknoteFactory banknoteFactory;

  ATM() {
    banknoteFactory = new BanknoteFactory();
  }

  @override
  void setBanknotePattern(String pattern) {
    banknoteTypes = banknoteFactory.getBanknotes(pattern);
    if (banknoteTypes == null) {
      throw ArgumentError(['Wrong pattern for banknotes']);
    }
    banknoteTypes.sort();
  }

  //По условию в банкомате бесконечные деньги
  @override
  bool hasMoney() {
    return true;
  }

  @override
  List<AbstractBanknote> getMoney(int money) {
    if (banknoteTypes == null) {
      return null;
    } else {
      BanknoteProcessor banknoteProcessor =
          new BanknoteProcessor(banknoteTypes, banknoteFactory);
      return banknoteProcessor.getBanknotes(money);
    }
  }
}

class BanknoteProcessor {
  List<AbstractBanknote> banknoteTypes;
  List<AbstractBanknote> cashUsedBanknotes;
  List<AbstractBanknote> usedBanknotes;
  AbstractBanknoteFactory banknoteFactory;
  int banknoteCounter;
  int minAmountOfBanknotes = -1;
  int banknoteTypeBarrier;

  BanknoteProcessor(List<AbstractBanknote> banknoteTypes,
      AbstractBanknoteFactory banknoteFactory) {
    this.banknoteTypes = banknoteTypes;
    this.banknoteFactory = banknoteFactory;
    banknoteTypeBarrier = banknoteTypes.length - 1;
  }

  /*Возвращает лист банкнот по алгоритму
  *мин. купюр, макс. разнообразие номиналов
  *Идет перебор по принцыпу вычитания из кол-ва денег номинала банкноты
  * необходимое количество раз (и необходимые номиналы банкнот)
  */
  List<AbstractBanknote> getBanknotes(int money) {
    for (int rightBarrier = 0;
        rightBarrier < banknoteTypes.length;
        rightBarrier++) {
      usedBanknotes = new List();
      int currentMoney = money;

      if (rightBarrier != banknoteTypes.length - 1) {
        for (int i = 0; i < banknoteTypes.length - rightBarrier; i++) {
          currentMoney -= banknoteTypes.elementAt(i).getValue();
          usedBanknotes.add(banknoteTypes.elementAt(i));
        }

        if (currentMoney < 0) {
          continue;
        } else if (currentMoney == 0) {
          break;
        }

        for (int i = banknoteTypes.length - 1; i >= 0; i--) {
          banknoteCounter = 0;
          processBanknotes(
              banknoteTypes.elementAt(i), currentMoney, new List());
        }
        if (minAmountOfBanknotes == -1) {
          continue;
        } else {
          usedBanknotes.addAll(cashUsedBanknotes);
          break;
        }
      } else {
        for (int i = banknoteTypes.length - 1; i >= 0; i--) {
          if (currentMoney % banknoteTypes.elementAt(i).getValue() == 0 &&
              (minAmountOfBanknotes >
                      currentMoney ~/ banknoteTypes.elementAt(i).getValue() ||
                  minAmountOfBanknotes == -1)) {
            usedBanknotes = new List();
            for (int j = currentMoney ~/ banknoteTypes.elementAt(i).getValue();
                j > 0;
                j--) {
              usedBanknotes.add(banknoteTypes.elementAt(i));
            }
            minAmountOfBanknotes =
                currentMoney ~/ banknoteTypes.elementAt(i).getValue();
          }
        }
      }
    }

    if (minAmountOfBanknotes == -1) {
      throw new ArgumentError(
          'Can\'t give this amount of money with such pattern of banknotes ');
    }
    usedBanknotes.sort();
    return usedBanknotes;
  }

  void processBanknotes(AbstractBanknote banknote, int money,
      List<AbstractBanknote> cashBanknotes) {
    if (banknote.getValue() <= money) {
      List<AbstractBanknote> privateCashBanknotes = new List();
      privateCashBanknotes.addAll(cashBanknotes);
      privateCashBanknotes.add(banknote);
      if (money - banknote.getValue() > 0) {
        int index = banknoteTypes.indexOf(banknote);
        for (int i = index; i >= 0; i--) {
          processBanknotes(banknoteTypes.elementAt(i),
              money - banknote.getValue(), privateCashBanknotes);
        }
      } else {
        if (privateCashBanknotes.length + usedBanknotes.length <
                minAmountOfBanknotes ||
            minAmountOfBanknotes == -1) {
          cashUsedBanknotes = new List();
          cashUsedBanknotes.addAll(privateCashBanknotes);
          minAmountOfBanknotes =
              cashUsedBanknotes.length + usedBanknotes.length;
        } else {
          return;
        }
      }
    } else {
      return;
    }
  }
}
