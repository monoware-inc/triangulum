import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Library Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
} 