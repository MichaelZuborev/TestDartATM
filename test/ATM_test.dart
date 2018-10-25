import 'package:test/test.dart';
import 'package:DartATM/ATM.dart';
import 'package:DartATM/Banknote.dart';
import 'package:DartATM/AbstractBanknote.dart';

//Testing bills
void main() {
  ATM atm;

  setUpAll(() {
    atm = new ATM();
  });

  test('hasMoney', () {
    expect(atm.hasMoney(), equals(true));
  });

  test('setProperPattern', () {
    atm.setBanknotePattern('1,2 ,  3');
  });

  test('setWrongPattern', () {
    try {
      atm.setBanknotePattern('1,2,3,fhjyd');
    } on ArgumentError catch (e) {
      return;
    }
    throw TestFailure;
  });

  test('getMoneyWithoutPattern', () {
    expect(atm.getMoney(90), equals(null));
  });

  test('getMoneyWithPattern1', () {
    atm.setBanknotePattern('1,5,10');
    List<AbstractBanknote> expectedBanknotes = new List();
    for (int i = 0; i < 5; i++) {
      expectedBanknotes.add(new Banknote(1));
    }
    expectedBanknotes.add(new Banknote(5));
    expectedBanknotes.add(new Banknote(10));

    List<AbstractBanknote> receivedMoney = atm.getMoney(20);
    for (int i = 0; i < receivedMoney.length; i++) {
      expect(
          receivedMoney.elementAt(i), equals(expectedBanknotes.elementAt(i)));
    }
  });

  test('getMoneyWithPattern2', () {
    atm.setBanknotePattern('2,6,7');
    List<AbstractBanknote> expectedBanknotes = new List();
    expectedBanknotes.add(new Banknote(2));
    expectedBanknotes.add(new Banknote(2));
    expectedBanknotes.add(new Banknote(6));
    expectedBanknotes.add(new Banknote(6));
    expectedBanknotes.add(new Banknote(7));
    expectedBanknotes.add(new Banknote(7));

    List<AbstractBanknote> receivedMoney = atm.getMoney(30);
    for (int i = 0; i < receivedMoney.length; i++) {
      expect(
          receivedMoney.elementAt(i), equals(expectedBanknotes.elementAt(i)));
    }
  });

  test('getMoneyWithPattern3', () {
    atm.setBanknotePattern('2,5,10');
    List<AbstractBanknote> expectedBanknotes = new List();
    for (int i = 0; i < 5; i++) {
      expectedBanknotes.add(new Banknote(2));
    }
    expectedBanknotes.add(new Banknote(5));
    expectedBanknotes.add(new Banknote(5));
    expectedBanknotes.add(new Banknote(10));

    List<AbstractBanknote> receivedMoney = atm.getMoney(30);
    for (int i = 0; i < receivedMoney.length; i++) {
      expect(
          receivedMoney.elementAt(i), equals(expectedBanknotes.elementAt(i)));
    }
  });

  test('getMoneyWithPattern4', () {
    atm.setBanknotePattern('3,9,10');
    List<AbstractBanknote> expectedBanknotes = new List();
    expectedBanknotes.add(new Banknote(10));
    expectedBanknotes.add(new Banknote(10));

    List<AbstractBanknote> receivedMoney = atm.getMoney(20);
    for (int i = 0; i < receivedMoney.length; i++) {
      expect(
          receivedMoney.elementAt(i), equals(expectedBanknotes.elementAt(i)));
    }
  });

  test('getMoneyWithPattern5', () {
    atm.setBanknotePattern('3,9,30');
    List<AbstractBanknote> expectedBanknotes = new List();
    expectedBanknotes.add(new Banknote(3));
    for (int i = 0; i < 3; i++) {
      expectedBanknotes.add(new Banknote(9));
    }

    List<AbstractBanknote> receivedMoney = atm.getMoney(30);
    for (int i = 0; i < receivedMoney.length; i++) {
      expect(
          receivedMoney.elementAt(i), equals(expectedBanknotes.elementAt(i)));
    }
  });

  test('getWrongAmontOfMoneyWithPattern', () {
    atm.setBanknotePattern('2,5,10');
    try {
      atm.getMoney(3);
    } on ArgumentError catch (e) {
      return;
    }
    throw TestFailure;
  });
}
