import 'package:flutter/material.dart';

class FanSpeedControl extends StatelessWidget {
  final String currentSpeed;
  final Function(String) onSpeedChanged;
  final bool isPowerOn;

  const FanSpeedControl({
    super.key,
    required this.currentSpeed,
    required this.onSpeedChanged,
    required this.isPowerOn,
  });

  @override
  Widget build(BuildContext context) {
         final speeds = [
       {'id': 'auto', 'name': 'Auto', 'icon': Icons.auto_mode},
       {'id': 'low', 'name': 'Low', 'icon': Icons.speed},
       {'id': 'medium', 'name': 'Medium', 'icon': Icons.speed},
       {'id': 'high', 'name': 'High', 'icon': Icons.speed},
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
                Icons.air,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
                             Text(
                 'Fan Speed',
                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
                   fontWeight: FontWeight.bold,
                 ),
               ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: speeds.map((speed) {
              final isSelected = currentSpeed == speed['id'];
              final isEnabled = isPowerOn;

              return GestureDetector(
                onTap: isEnabled ? () => onSpeedChanged(speed['id'] as String) : null,
                child: Container(
                  width: 70,
                  height: 70,
                                     decoration: BoxDecoration(
                     color: isSelected 
                         ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                         : const Color(0xFF2A2A2A),
                     borderRadius: BorderRadius.circular(16),
                     border: Border.all(
                       color: isSelected 
                           ? Theme.of(context).colorScheme.primary
                           : Colors.grey.shade600,
                       width: isSelected ? 2 : 1,
                     ),
                   ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        speed['icon'] as IconData,
                        color: isSelected 
                            ? Theme.of(context).colorScheme.primary
                            : (isEnabled ? Colors.grey.shade600 : Colors.grey.shade400),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        speed['name'] as String,
                        style: TextStyle(
                          color: isSelected 
                              ? Theme.of(context).colorScheme.primary
                              : (isEnabled ? Colors.grey.shade700 : Colors.grey.shade500),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
