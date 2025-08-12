import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/bluetooth_service.dart';

class ACProvider extends ChangeNotifier {
  bool _isPowerOn = false;
  int _temperature = 24;
  String _mode = 'cool'; // cool, heat, fan, dry
  String _fanSpeed = 'auto'; // auto, low, medium, high
  bool _isConnected = false;
  String _selectedAC = '';
  final ACBluetoothService _bluetoothService = ACBluetoothService();
  List<dynamic> _availableDevices = [];

  // Getters
  bool get isPowerOn => _isPowerOn;
  int get temperature => _temperature;
  String get mode => _mode;
  String get fanSpeed => _fanSpeed;
  bool get isConnected => _isConnected;
  String get selectedAC => _selectedAC;
  List<dynamic> get availableDevices => _availableDevices;

  // AC units list
  final List<String> _acList = [
    'Living Room AC',
    'Bedroom AC',
    'Kitchen AC',
    'Study Room AC',
  ];

  List<String> get acList => _acList;

  ACProvider() {
    _selectedAC = _acList.first; // Set initial value
    _loadSettings();
  }

  // Load settings
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isPowerOn = prefs.getBool('isPowerOn') ?? false;
    _temperature = prefs.getInt('temperature') ?? 24;
    _mode = prefs.getString('mode') ?? 'cool';
    _fanSpeed = prefs.getString('fanSpeed') ?? 'auto';
    
    // Ensure selectedAC is valid
    final savedAC = prefs.getString('selectedAC');
    if (savedAC != null && _acList.contains(savedAC)) {
      _selectedAC = savedAC;
    } else {
      _selectedAC = _acList.first;
    }
    
    notifyListeners();
  }

  // Save settings
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPowerOn', _isPowerOn);
    await prefs.setInt('temperature', _temperature);
    await prefs.setString('mode', _mode);
    await prefs.setString('fanSpeed', _fanSpeed);
    await prefs.setString('selectedAC', _selectedAC);
  }

  // Power on/off
  void togglePower() {
    final newPowerState = !_isPowerOn;
    if (_isConnected) {
      sendCommand({'power': newPowerState});
    } else {
      _isPowerOn = newPowerState;
      _saveSettings();
      notifyListeners();
    }
  }

  // Set temperature
  void setTemperature(int temp) {
    if (temp >= 16 && temp <= 30) {
      if (_isConnected) {
        sendCommand({'temperature': temp});
      } else {
        _temperature = temp;
        _saveSettings();
        notifyListeners();
      }
    }
  }

  // Change mode
  void setMode(String newMode) {
    if (['cool', 'heat', 'fan', 'dry'].contains(newMode)) {
      if (_isConnected) {
        sendCommand({'mode': newMode});
      } else {
        _mode = newMode;
        _saveSettings();
        notifyListeners();
      }
    }
  }

  // Set fan speed
  void setFanSpeed(String speed) {
    if (['auto', 'low', 'medium', 'high'].contains(speed)) {
      if (_isConnected) {
        sendCommand({'fanSpeed': speed});
      } else {
        _fanSpeed = speed;
        _saveSettings();
        notifyListeners();
      }
    }
  }

  // Select AC
  void selectAC(String acName) {
    _selectedAC = acName;
    _saveSettings();
    notifyListeners();
  }

  // Connection status
  void setConnectionStatus(bool status) {
    _isConnected = status;
    notifyListeners();
  }

  // Send IR signal (simulation)
  Future<void> sendIRSignal() async {
    if (!_isPowerOn) return;
    
    // Simulated IR signal transmission
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In real application, IR signal will be sent here
    debugPrint('IR signal sent: $_selectedAC - Temperature: $_temperature, Mode: $_mode, Fan: $_fanSpeed');
  }

  // Bluetooth methods
  Future<void> scanForDevices() async {
    try {
      _availableDevices = await _bluetoothService.scanDevices();
      notifyListeners();
    } catch (e) {
      debugPrint('Error scanning for devices: $e');
    }
  }

  Future<bool> connectToDevice(dynamic device) async {
    try {
      final success = await _bluetoothService.connectToDevice(device);
      if (success) {
        _isConnected = true;
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Error connecting to device: $e');
      return false;
    }
  }

  Future<void> disconnect() async {
    try {
      await _bluetoothService.disconnect();
      _isConnected = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error disconnecting: $e');
    }
  }

  Future<bool> sendCommand(Map<String, dynamic> command) async {
    if (!_isConnected) return false;
    
    try {
      // Convert command to bytes (simplified for now)
      final commandBytes = _encodeCommand(command);
      final success = await _bluetoothService.sendData(commandBytes);
      
      if (success) {
        // Update local state
        if (command.containsKey('power')) {
          _isPowerOn = command['power'] as bool;
        }
        if (command.containsKey('temperature')) {
          _temperature = command['temperature'] as int;
        }
        if (command.containsKey('mode')) {
          _mode = command['mode'] as String;
        }
        if (command.containsKey('fanSpeed')) {
          _fanSpeed = command['fanSpeed'] as String;
        }
        
        _saveSettings();
        notifyListeners();
      }
      
      return success;
    } catch (e) {
      debugPrint('Error sending command: $e');
      return false;
    }
  }

  List<int> _encodeCommand(Map<String, dynamic> command) {
    // Simple command encoding - in real app, this would follow AC protocol
    List<int> bytes = [];
    
    // Start byte
    bytes.add(0xAA);
    
    // Command type
    if (command.containsKey('power')) {
      bytes.add(0x01); // Power command
      bytes.add(command['power'] ? 0x01 : 0x00);
    } else if (command.containsKey('temperature')) {
      bytes.add(0x02); // Temperature command
      bytes.add(command['temperature'] as int);
    } else if (command.containsKey('mode')) {
      bytes.add(0x03); // Mode command
      final modeMap = {'cool': 0x01, 'heat': 0x02, 'fan': 0x03, 'dry': 0x04};
      bytes.add(modeMap[command['mode']] ?? 0x01);
    } else if (command.containsKey('fanSpeed')) {
      bytes.add(0x04); // Fan speed command
      final speedMap = {'auto': 0x00, 'low': 0x01, 'medium': 0x02, 'high': 0x03};
      bytes.add(speedMap[command['fanSpeed']] ?? 0x00);
    }
    
    // End byte
    bytes.add(0xFF);
    
    return bytes;
  }


}
