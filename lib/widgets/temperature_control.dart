import 'package:flutter/material.dart';

class TemperatureControl extends StatelessWidget {
  final int temperature;
  final Function(int) onTemperatureChanged;
  final bool isPowerOn;

  const TemperatureControl({
    super.key,
    required this.temperature,
    required this.onTemperatureChanged,
    required this.isPowerOn,
  });

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.thermostat,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 8),
                             Text(
                 'Temperature',
                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
                   fontWeight: FontWeight.bold,
                 ),
               ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: isPowerOn ? () => onTemperatureChanged(temperature - 1) : null,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isPowerOn ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    color: isPowerOn ? Colors.white : Colors.grey.shade600,
                    size: 24,
                  ),
                ),
              ),
              Container(
                width: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  '$temperature°C',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPowerOn ? Theme.of(context).colorScheme.primary : Colors.grey.shade600,
                  ),
                ),
              ),
              IconButton(
                onPressed: isPowerOn ? () => onTemperatureChanged(temperature + 1) : null,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isPowerOn ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: isPowerOn ? Colors.white : Colors.grey.shade600,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: temperature.toDouble(),
            min: 16,
            max: 30,
            divisions: 14,
            activeColor: isPowerOn ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
            inactiveColor: Colors.grey.shade300,
            onChanged: isPowerOn ? (value) => onTemperatureChanged(value.round()) : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '16°C',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              Text(
                '30°C',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
