import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../settings_controller.dart';

class HomeScreen extends StatelessWidget {
  final SettingsController settings;
  const HomeScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          IconButton(
            icon: Icon(settings.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: settings.toggleTheme,
            tooltip: 'Переключить тему',
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.icon(
                onPressed: () => context.go('/calculator'),
                icon: const Icon(Icons.calculate),
                label: const Text('Калькулятор'),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.go('/converter'),
                icon: const Icon(Icons.currency_exchange),
                label: const Text('Конвертер валют'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}