import 'package:flutter/material.dart';
import '../widgets/welcome_header_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/trending_games_widget.dart';
import '../widgets/coming_soon_widget.dart';
import '../widgets/new_releases_widget.dart';
import '../widgets/popular_games_widget.dart';
import '../pages/profile_page.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _MainContent(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 3,
        shadowColor: Theme.of(context).colorScheme.shadow,
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          final isTablet = constraints.maxWidth > 600;
          
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 1200 : double.infinity,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 48 : (isTablet ? 24 : 16),
                  vertical: isDesktop ? 32 : 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WelcomeHeader(),
                    SizedBox(height: isDesktop ? 32 : 24),
                    const SearchBarWidget(),
                    SizedBox(height: isDesktop ? 40 : 32),
                    const PopularGamesWidget(),
                    SizedBox(height: isDesktop ? 40 : 32),
                    const TrendingGamesWidget(),
                    SizedBox(height: isDesktop ? 40 : 32),
                    const NewReleasesWidget(),
                    SizedBox(height: isDesktop ? 40 : 32),
                    const ComingSoonWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 