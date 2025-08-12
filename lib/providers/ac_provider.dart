import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ACProvider extends ChangeNotifier {
  bool _isPowerOn = false;
  int _temperature = 24;
  String _mode = 'cool'; // cool, heat, fan, dry
  String _fanSpeed = 'auto'; // auto, low, medium, high
  bool _isConnected = false;
  String _selectedAC = '';

  // Getters
  bool get isPowerOn => _isPowerOn;
  int get temperature => _temperature;
  String get mode => _mode;
  String get fanSpeed => _fanSpeed;
  bool get isConnected => _isConnected;
  String get selectedAC => _selectedAC;

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
    _isPowerOn = !_isPowerOn;
    _saveSettings();
    notifyListeners();
  }

  // Set temperature
  void setTemperature(int temp) {
    if (temp >= 16 && temp <= 30) {
      _temperature = temp;
      _saveSettings();
      notifyListeners();
    }
  }

  // Change mode
  void setMode(String newMode) {
    if (['cool', 'heat', 'fan', 'dry'].contains(newMode)) {
      _mode = newMode;
      _saveSettings();
      notifyListeners();
    }
  }

  // Set fan speed
  void setFanSpeed(String speed) {
    if (['auto', 'low', 'medium', 'high'].contains(speed)) {
      _fanSpeed = speed;
      _saveSettings();
      notifyListeners();
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
}
