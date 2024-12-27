import 'package:flutter/material.dart';

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Main App Page',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
} 