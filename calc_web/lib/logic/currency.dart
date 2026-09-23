sealed class ConvResult {
  const ConvResult();
}

class ConvSuccess extends ConvResult {
  final double value;
  const ConvSuccess(this.value);
  String get formattedValue => value.toStringAsFixed(2);
}

class ConvFailure extends ConvResult {
  final String message;
  const ConvFailure(this.message);
}

const Map<String, double> currencyRates = {
  'RUB': 1.0,
  'USD': 84.80,
  'EUR': 96.58,
  'CNY': 12.65,
  'KZT': 0.20,
};

ConvResult convert(String? rawAmount, String? from, String? to) {
  if (rawAmount == null || from == null || to == null) {
    return const ConvFailure('Пропущены обязательные параметры');
  }

  final amount = double.tryParse(rawAmount.replaceAll(',', '.'));
  if (amount == null || amount < 0) {
    return const ConvFailure('Введена некорректная сумма');
  }

  final rateFrom = currencyRates[from];
  final rateTo = currencyRates[to];

  if (rateFrom == null || rateTo == null) {
    return const ConvFailure('Неизвестная валюта');
  }

  final result = (amount * rateFrom) / rateTo;
  return ConvSuccess(result);
}