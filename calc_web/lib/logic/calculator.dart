sealed class CalcResult {
  const CalcResult();
}

class CalcSuccess extends CalcResult {
  final double value;
  const CalcSuccess(this.value);
  String get formattedValue {
    String formatted = value.toStringAsFixed(4);
    return formatted.replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}

class CalcFailure extends CalcResult {
  final String message;
  const CalcFailure(this.message);
}

CalcResult calculate(String? rawA, String? rawOp, String? rawB) {
  if (rawA == null || rawB == null || rawOp == null) {
    return const CalcFailure('Пропущены обязательные параметры');
  }

  final a = double.tryParse(rawA.replaceAll(',', '.'));
  final b = double.tryParse(rawB.replaceAll(',', '.'));

  if (a == null || b == null) {
    return const CalcFailure('Переданы не числа');
  }

  return switch (rawOp) {
    '+' => CalcSuccess(a + b),
    '-' => CalcSuccess(a - b),
    '*' => CalcSuccess(a * b),
    '/' => b == 0 ? const CalcFailure('Деление на ноль невозможно') : CalcSuccess(a / b),
    _ => const CalcFailure('Неизвестная операция'),
  };
}