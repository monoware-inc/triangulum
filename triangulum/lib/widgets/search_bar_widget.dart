import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet = constraints.maxWidth > 600;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 24 : 16,
            vertical: isDesktop ? 16 : 12,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: isDesktop ? 28 : (isTablet ? 24 : 20),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: isDesktop ? 16 : 12),
              Expanded(
                child: TextField(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search games...',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 