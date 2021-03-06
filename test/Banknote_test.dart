import 'package:test/test.dart';
import 'package:DartATM/Banknote.dart';

//Testing bills
void main() {
  test('createPositiveSmall', () {
    Banknote banknote = new Banknote(1);
    expect(banknote.getValue(), equals(1));
    try {
      expect(banknote.getValue(), equals(100));
    } on TestFailure catch (e) {return;}
    throw new ArgumentError();
  });

  test('createPositiveBig', () {
    Banknote banknote = new Banknote(100000);
    expect(banknote.getValue(), equals(100000));
    try {
      expect(banknote.getValue(), equals(10));
    } on TestFailure catch (e) {return;}
    throw new ArgumentError();  });

  test('createNegative', () {
    Banknote banknote = new Banknote(-1);
    expect(banknote.getValue(), equals(1));
    try {
      expect(banknote.getValue(), equals(-1));
    } on TestFailure catch (e) {return;}
    throw new ArgumentError();  });

  test('createZero', () {
    Banknote banknote = new Banknote(0);
    expect(banknote.getValue(), equals(1));
    try {
      expect(banknote.getValue(), equals(0));
    } on TestFailure catch (e) {return;}
    throw new ArgumentError();
  });
}
