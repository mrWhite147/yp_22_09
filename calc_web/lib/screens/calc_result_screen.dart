import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../logic/calculator.dart';

class CalcResultScreen extends StatelessWidget {
  final String? rawA;
  final String? rawOp;
  final String? rawB;

  const CalcResultScreen({
    super.key,
    this.rawA,
    this.rawOp,
    this.rawB,
  });

  @override
  Widget build(BuildContext context) {
    final result = calculate(rawA, rawOp, rawB);

    return Scaffold(
      appBar: AppBar(title: const Text('Результат вычисления')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Если вычисление прошло успешно
            if (result is CalcSuccess) ...[
              Text(
                '$rawA $rawOp $rawB =',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                result.formattedValue,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.green),
              ),
            ] 
            // Если произошла ошибка (деление на ноль или ввели не числа)
            else if (result is CalcFailure) ...[
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                result.message,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
              ),
            ],
            
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => context.go('/calculator'),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Вернуться к калькулятору'),
            ),
          ],
        ),
      ),
    );
  }
}