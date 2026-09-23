import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/logic/calculator.dart';
import 'package:calc_web/logic/currency.dart';

void main() {
  group('Тестирование калькулятора', () {
    test('Успешное сложение', () {
      final res = calculate('5', '+', '7');
      expect(res is CalcSuccess, true);
      expect((res as CalcSuccess).value, 12.0);
    });

    test('Успешное деление', () {
      final res = calculate('10', '/', '2');
      expect(res is CalcSuccess, true);
      expect((res as CalcSuccess).value, 5.0);
    });

    test('Ошибка: деление на ноль', () {
      final res = calculate('10', '/', '0');
      expect(res is CalcFailure, true);
      expect((res as CalcFailure).message, 'Деление на ноль невозможно');
    });

    test('Ошибка: нечисловой ввод', () {
      final res = calculate('abc', '+', '5');
      expect(res is CalcFailure, true);
      expect((res as CalcFailure).message, 'В адресе переданы не числа');
    });

    test('Ошибка: неизвестная операция', () {
      final res = calculate('5', '^', '5');
      expect(res is CalcFailure, true);
      expect((res as CalcFailure).message, 'Неизвестная операция');
    });
    
    test('Округление и форматирование результата', () {
      final res = calculate('10', '/', '3');
      expect((res as CalcSuccess).formattedValue, '3.3333');
    });
  });

  group('Тестирование конвертера', () {
    test('Успешная конвертация', () {
      final res = convert('100', 'USD', 'RUB');
      expect(res is ConvSuccess, true);
      // 100 * 92.5 / 1.0 = 9250.0
      expect((res as ConvSuccess).value, 9250.0);
    });

    test('Ошибка: пропущенные параметры', () {
      final res = convert(null, 'USD', 'RUB');
      expect(res is ConvFailure, true);
    });
  });
}