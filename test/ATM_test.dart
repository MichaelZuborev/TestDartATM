import 'package:test/test.dart';
import 'package:DartATM/ATM.dart';
import 'package:DartATM/Banknote.dart';

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
    List<Banknote> expectedBanknotes = new List();
    for (int i = 0; i < 5; i++) {
      expectedBanknotes.add(new Banknote(1));
    }
    expectedBanknotes.add(new Banknote(5));
    expectedBanknotes.add(new Banknote(10));

    List<Banknote> receivedMoney = atm.getMoney(20);
    for (int i = 0; i < receivedMoney.length; i++) {
      expect(
          receivedMoney.elementAt(i), equals(expectedBanknotes.elementAt(i)));
    }
  });

  test('getMoneyWithPattern2', () {
    atm.setBanknotePattern('2,6,7');
    List<Banknote> expectedBanknotes = new List();
    expectedBanknotes.add(new Banknote(2));
    expectedBanknotes.add(new Banknote(2));
    expectedBanknotes.add(new Banknote(6));
    expectedBanknotes.add(new Banknote(6));
    expectedBanknotes.add(new Banknote(7));
    expectedBanknotes.add(new Banknote(7));

    List<Banknote> receivedMoney = atm.getMoney(30);
    for (int i = 0; i < receivedMoney.length; i++) {
      expect(
          receivedMoney.elementAt(i), equals(expectedBanknotes.elementAt(i)));
    }
  });

  test('getWrongAmontOfMoneyWithPattern', () {
    atm.setBanknotePattern('2,5,10');
    try {
      atm.getMoney(6);
    } on ArgumentError catch (e) {
      return;
    }
    throw TestFailure;
  });
}
