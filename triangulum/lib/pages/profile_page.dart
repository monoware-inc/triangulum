import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sign Out'),
                  content: const Text('Are you sure you want to sign out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<AuthState>().signOut();
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AuthState>(
        builder: (context, authState, _) {
          final user = authState.user;
          if (user == null) return const SizedBox.shrink();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : null,
                  child: user.photoURL == null
                      ? Text(
                          user.email?.substring(0, 1).toUpperCase() ?? '?',
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoCard(
                context,
                title: 'Display Name',
                value: user.displayName ?? 'Not set',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                context,
                title: 'Email',
                value: user.email ?? 'Not set',
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                context,
                title: 'Account Created',
                value: user.metadata.creationTime?.toString() ?? 'Unknown',
                icon: Icons.calendar_today,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
} 