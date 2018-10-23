import 'package:test/test.dart';
import 'package:DartATM/BanknoteFactory.dart';
import 'package:DartATM/Banknote.dart';

/*
* Во многих случаях фабрика возвращает null, однако, как альтернативный вариант,
* можно было бы кидать исключение.
* */
void main() {
  BanknoteFactory factory;

  setUpAll(() {
    factory = new BanknoteFactory();
  });

  test('getOneBankonte', () {
    List<Banknote> banknotes = new List();
    banknotes.add(new Banknote(5));
    expect(factory.getBanknotes('5'), equals(banknotes));
  });

  test('getThreeBankontes', () {
    List<Banknote> banknotes = new List();
    banknotes.add(new Banknote(5));
    banknotes.add(new Banknote(4));
    banknotes.add(new Banknote(3));
    expect(factory.getBanknotes('5,4,3'), equals(banknotes));
  });

  test('getThreeBankontesWithSpaces', () {
    List<Banknote> banknotes = new List();
    banknotes.add(new Banknote(5));
    banknotes.add(new Banknote(4));
    banknotes.add(new Banknote(3));
    expect(factory.getBanknotes(' 5 , 4 , 3 '), equals(banknotes));
  });

  test('getThreeBankontesWithTypos', () {
    List<Banknote> banknotes = new List();
    banknotes.add(new Banknote(5));
    banknotes.add(new Banknote(4));
    banknotes.add(new Banknote(3));
    try {
      expect(factory.getBanknotes('rft+yfd.f5@-*/#d%f^vbn,4df]gdfh, 3dfgh,5'),
          equals(banknotes));
    } on TestFailure catch (e) {
      return;
    }
    throw new ArgumentError();
  });

  test('getThreeBankontesWithTooBigValue', () {
    if (factory.getBanknotes('100000000,6,8') != null) {
      throw new ArgumentError();
    }
  });

  test('getThreeBankontesWithZero', () {
    if (factory.getBanknotes('0,6,8') != null) {
      throw new ArgumentError();
    }
  });

  test('getThreeBankontesWithNegativeValue', () {
    if (factory.getBanknotes('-1,6,8') != null) {
      throw new ArgumentError();
    }
  });

  test('getNoneBankontes', () {
    if (factory.getBanknotes('') != null) {
      throw new ArgumentError();
    }
  });

  test('getNoneBankontesWithComma', () {
    if (factory.getBanknotes(' , ') != null) {
      throw new ArgumentError();
    }
  });
}
