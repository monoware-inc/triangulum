import 'package:flutter/material.dart';
import '../widgets/welcome_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/trending_games_widget.dart';

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeHeader(),
              SizedBox(height: 24),
              SearchBarWidget(),
              SizedBox(height: 32),
              TrendingGamesWidget(),
            ],
          ),
        ),
      ),
    );
  }
} 