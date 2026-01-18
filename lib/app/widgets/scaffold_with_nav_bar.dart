import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';

/// Persistent Bottom Navigation using StatefulShellRoute pattern
class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    
    final items = [
      {'iconFilled': Icons.home_rounded, 'iconOutline': Icons.home_outlined, 'label': 'Home'},
      {'iconFilled': Icons.access_time_filled, 'iconOutline': Icons.access_time_outlined, 'label': 'Prayer'},
      {'label': 'Quran', 'isSvg': true, 'svgFilled': 'assets/icons/quran_filled.svg', 'svgOutline': 'assets/icons/quran_outline.svg'},
      {'iconFilled': Icons.auto_awesome, 'iconOutline': Icons.auto_awesome_outlined, 'label': 'Dua'},
      {'iconFilled': Icons.grid_view_rounded, 'iconOutline': Icons.grid_view_outlined, 'label': 'More'},
    ];
    
    final itemWidth = (screenWidth - 48) / items.length;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 8,
          bottom: MediaQuery.of(context).padding.bottom + 8,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: _withAlpha(Colors.black, 0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Animated pill indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              left: navigationShell.currentIndex * itemWidth,
              top: 0,
              child: Container(
                width: itemWidth,
                height: 56,
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: _withAlpha(AppColors.primaryTeal, 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            // Nav items
            Row(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isActive = index == navigationShell.currentIndex;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      navigationShell.goBranch(
                        index,
                        initialLocation: index == navigationShell.currentIndex,
                      );
                    },
                    child: SizedBox(
                      height: 56,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: item['isSvg'] == true
                                ? SvgPicture.asset(
                                    isActive
                                        ? item['svgFilled'] as String
                                        : item['svgOutline'] as String,
                                    key: ValueKey(isActive),
                                    width: 24,
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                      isActive
                                          ? AppColors.primaryTeal
                                          : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.45),
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : Icon(
                                    isActive
                                        ? item['iconFilled'] as IconData
                                        : item['iconOutline'] as IconData,
                                    key: ValueKey(isActive),
                                    color: isActive
                                        ? AppColors.primaryTeal
                                        : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.45),
                                    size: 24,
                                  ),
                          ),
                          const SizedBox(height: 4),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                              color: isActive
                                  ? AppColors.primaryTeal
                                  : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.45),
                            ),
                            child: Text(item['label'] as String),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
