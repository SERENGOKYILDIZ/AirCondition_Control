import 'package:flutter/material.dart';

class PowerButton extends StatelessWidget {
  final bool isPowerOn;
  final VoidCallback onPowerToggle;

  const PowerButton({
    super.key,
    required this.isPowerOn,
    required this.onPowerToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPowerToggle,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isPowerOn
                  ? [
                      Colors.green.shade400,
                      Colors.green.shade600,
                    ]
                  : [
                      Colors.red.shade400,
                      Colors.red.shade600,
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: (isPowerOn ? Colors.green : Colors.red).withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            isPowerOn ? Icons.power_settings_new : Icons.power_off,
            size: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
