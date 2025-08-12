import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class ACBluetoothService {
  static final ACBluetoothService _instance = ACBluetoothService._internal();
  factory ACBluetoothService() => _instance;
  ACBluetoothService._internal();

  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _writeCharacteristic;
  bool _isConnected = false;
  List<BluetoothDevice> _devices = [];

  bool get isConnected => _isConnected;
  List<BluetoothDevice> get devices => _devices;

  // Check Bluetooth permissions
  Future<bool> checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ].request();

    bool allGranted = true;
    statuses.forEach((permission, status) {
      if (!status.isGranted) {
        allGranted = false;
      }
    });

    return allGranted;
  }

  // Enable Bluetooth
  Future<bool> enableBluetooth() async {
    try {
      if (await FlutterBluePlus.isSupported == false) {
        debugPrint('Bluetooth not supported');
        return false;
      }

      if (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on) {
        return true;
      }

      await FlutterBluePlus.turnOn();
      return true;
    } catch (e) {
      debugPrint('Failed to enable Bluetooth: $e');
      return false;
    }
  }

  // Scan for devices
  Future<List<BluetoothDevice>> scanDevices() async {
    try {
      if (!await checkPermissions()) {
        throw Exception('Required permissions not granted');
      }

      if (!await enableBluetooth()) {
        throw Exception('Failed to enable Bluetooth');
      }

      _devices.clear();
      
      // Scan for Bluetooth devices
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
      
      // Collect scan results
      List<ScanResult> results = [];
      await for (List<ScanResult> scanResults in FlutterBluePlus.scanResults) {
        results.addAll(scanResults);
      }
      
      // Add only named devices
      for (ScanResult result in results) {
        if (result.device.platformName.isNotEmpty) {
          _devices.add(result.device);
        }
      }

      return _devices;
    } catch (e) {
      debugPrint('Device scanning error: $e');
      return [];
    }
  }

  // Connect to device
  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      if (_connectedDevice != null) {
        await _connectedDevice!.disconnect();
      }

      await device.connect();
      _connectedDevice = device;
      _isConnected = true;
      
      // Discover services
      List<BluetoothService> services = await device.discoverServices();
      
      // Find write characteristic
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.properties.write || characteristic.properties.writeWithoutResponse) {
            _writeCharacteristic = characteristic;
            break;
          }
        }
        if (_writeCharacteristic != null) break;
      }
      
      debugPrint('Connected to ${device.platformName.isNotEmpty ? device.platformName : 'Unknown'} device');
      return true;
    } catch (e) {
      debugPrint('Connection error: $e');
      _isConnected = false;
      return false;
    }
  }

  // Disconnect
  Future<void> disconnect() async {
    try {
      if (_connectedDevice != null) {
        await _connectedDevice!.disconnect();
        _connectedDevice = null;
      }
      _writeCharacteristic = null;
      _isConnected = false;
      debugPrint('Disconnected');
    } catch (e) {
      debugPrint('Disconnection error: $e');
    }
  }

  // Send data
  Future<bool> sendData(List<int> data) async {
    try {
      if (_writeCharacteristic != null && _isConnected) {
        await _writeCharacteristic!.write(Uint8List.fromList(data));
        debugPrint('Data sent: $data');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Data sending error: $e');
      return false;
    }
  }

  // Send IR signal (simulation)
  Future<bool> sendIRSignal(Map<String, dynamic> command) async {
    try {
      // In real application, IR signal will be sent here
      // For now, we're simulating it
      await Future.delayed(const Duration(milliseconds: 500));
      
      debugPrint('IR signal sent: $command');
      return true;
    } catch (e) {
      debugPrint('IR signal sending error: $e');
      return false;
    }
  }

  // Listen to connection status
  Stream<bool> get connectionStream async* {
    if (_connectedDevice != null) {
      yield* _connectedDevice!.connectionState.map((state) => state == BluetoothConnectionState.connected);
    } else {
      yield false;
    }
  }

  // Dispose
  void dispose() {
    disconnect();
  }
}
