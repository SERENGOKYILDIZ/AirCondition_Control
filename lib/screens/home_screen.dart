import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ac_provider.dart';
import '../widgets/ac_selector.dart';
import '../widgets/temperature_control.dart';
import '../widgets/mode_selector.dart';
import '../widgets/fan_speed_control.dart';
import '../widgets/power_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                 title: const Text('AC Control'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<ACProvider>(
            builder: (context, acProvider, child) {
              return IconButton(
                icon: Icon(
                  acProvider.isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
                  color: acProvider.isConnected ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  // Bluetooth bağlantı durumu
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                                             content: Text(
                         acProvider.isConnected 
                           ? 'Bluetooth Connected' 
                           : 'Bluetooth Disconnected'
                       ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<ACProvider>(
        builder: (context, acProvider, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  const Color(0xFF121212),
                ],
              ),
            ),
                         child: SafeArea(
               child: SingleChildScrollView(
                 padding: const EdgeInsets.all(16.0),
                 child: Column(
                   children: [
                     // Klima seçici
                     ACSelector(
                       selectedAC: acProvider.selectedAC,
                       acList: acProvider.acList,
                       onACSelected: acProvider.selectAC,
                     ),
                     
                     const SizedBox(height: 24),
                     
                     // Güç butonu
                     PowerButton(
                       isPowerOn: acProvider.isPowerOn,
                       onPowerToggle: acProvider.togglePower,
                     ),
                     
                     const SizedBox(height: 32),
                     
                     // Sıcaklık kontrolü
                     TemperatureControl(
                       temperature: acProvider.temperature,
                       onTemperatureChanged: acProvider.setTemperature,
                       isPowerOn: acProvider.isPowerOn,
                     ),
                     
                     const SizedBox(height: 24),
                     
                     // Mod seçici
                     ModeSelector(
                       currentMode: acProvider.mode,
                       onModeChanged: acProvider.setMode,
                       isPowerOn: acProvider.isPowerOn,
                     ),
                     
                     const SizedBox(height: 24),
                     
                     // Fan hızı kontrolü
                     FanSpeedControl(
                       currentSpeed: acProvider.fanSpeed,
                       onSpeedChanged: acProvider.setFanSpeed,
                       isPowerOn: acProvider.isPowerOn,
                     ),
                     
                     const SizedBox(height: 32),
                     
                     // Durum bilgisi
                     Container(
                       padding: const EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         color: const Color(0xFF2A2A2A),
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: Colors.grey.shade700),
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             'Status:',
                             style: Theme.of(context).textTheme.titleMedium,
                           ),
                           Text(
                             acProvider.isPowerOn ? 'On' : 'Off',
                             style: Theme.of(context).textTheme.titleMedium?.copyWith(
                               color: acProvider.isPowerOn ? Colors.green : Colors.red,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ],
                       ),
                     ),
                     
                     const SizedBox(height: 32),
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
