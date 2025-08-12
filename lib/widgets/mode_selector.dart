import 'package:flutter/material.dart';

class ModeSelector extends StatelessWidget {
  final String currentMode;
  final Function(String) onModeChanged;
  final bool isPowerOn;

  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
    required this.isPowerOn,
  });

  @override
  Widget build(BuildContext context) {
         final modes = [
       {'id': 'cool', 'name': 'Cool', 'icon': Icons.ac_unit, 'color': Colors.blue},
       {'id': 'heat', 'name': 'Heat', 'icon': Icons.whatshot, 'color': Colors.orange},
       {'id': 'fan', 'name': 'Fan', 'icon': Icons.air, 'color': Colors.green},
       {'id': 'dry', 'name': 'Dry', 'icon': Icons.opacity, 'color': Colors.purple},
     ];

    return Container(
      padding: const EdgeInsets.all(20),
             decoration: BoxDecoration(
         color: const Color(0xFF1E1E1E),
         borderRadius: BorderRadius.circular(20),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.3),
             spreadRadius: 1,
             blurRadius: 15,
             offset: const Offset(0, 4),
           ),
         ],
       ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
                             Text(
                 'Operating Mode',
                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
                   fontWeight: FontWeight.bold,
                 ),
               ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: modes.length,
            itemBuilder: (context, index) {
              final mode = modes[index];
              final isSelected = currentMode == mode['id'];
              final isEnabled = isPowerOn;

              return GestureDetector(
                onTap: isEnabled ? () => onModeChanged(mode['id'] as String) : null,
                child: Container(
                                     decoration: BoxDecoration(
                     color: isSelected 
                         ? (mode['color'] as Color).withOpacity(0.3)
                         : const Color(0xFF2A2A2A),
                     borderRadius: BorderRadius.circular(16),
                     border: Border.all(
                       color: isSelected 
                           ? (mode['color'] as Color)
                           : Colors.grey.shade600,
                       width: isSelected ? 2 : 1,
                     ),
                   ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        mode['icon'] as IconData,
                        color: isSelected 
                            ? (mode['color'] as Color)
                            : (isEnabled ? Colors.grey.shade600 : Colors.grey.shade400),
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mode['name'] as String,
                        style: TextStyle(
                          color: isSelected 
                              ? (mode['color'] as Color)
                              : (isEnabled ? Colors.grey.shade700 : Colors.grey.shade500),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
