import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../logic/currency.dart';

class ConvResultScreen extends StatelessWidget {
  final String? rawAmount;
  final String? rawFrom;
  final String? rawTo;

  const ConvResultScreen({super.key, this.rawAmount, this.rawFrom, this.rawTo});

  @override
  Widget build(BuildContext context) {
    final result = convert(rawAmount, rawFrom, rawTo);

    return Scaffold(
      appBar: AppBar(title: const Text('Результат конвертации')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (result is ConvSuccess) ...[
              Text('$rawAmount $rawFrom =', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('${result.formattedValue} $rawTo', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.green)),
            ] else if (result is ConvFailure) ...[
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(result.message, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red)),
            ],
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => context.go('/converter'),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Вернуться к конвертеру'),
            ),
          ],
        ),
      ),
    );
  }
}