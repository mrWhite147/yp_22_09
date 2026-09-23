import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../logic/currency.dart';
import '../settings_controller.dart';

class ConverterScreen extends StatefulWidget {
  final SettingsController settings;
  const ConverterScreen({super.key, required this.settings});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  late String _fromCurrency;
  late String _toCurrency;

  @override
  void initState() {
    super.initState();
    _fromCurrency = widget.settings.lastFromCurrency;
    _toCurrency = widget.settings.lastToCurrency;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.settings.saveCurrencyPair(_fromCurrency, _toCurrency);
    final amount = _amountController.text.replaceAll(',', '.');
    context.go('/converter/result?amount=$amount&from=$_fromCurrency&to=$_toCurrency');
  }

  @override
  Widget build(BuildContext context) {
    final currencies = currencyRates.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Конвертер валют'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: 'Сумма', border: OutlineInputBorder()),
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Введите сумму';
                      final parsed = double.tryParse(val.replaceAll(',', '.'));
                      if (parsed == null || parsed < 0) return 'Некорректная сумма';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _fromCurrency,
                    decoration: const InputDecoration(labelText: 'Из валюты', border: OutlineInputBorder()),
                    items: currencies.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (val) => setState(() => _fromCurrency = val!),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _toCurrency,
                    decoration: const InputDecoration(labelText: 'В валюты', border: OutlineInputBorder()),
                    items: currencies.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (val) => setState(() => _toCurrency = val!),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: _submit, child: const Text('Перевести')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}