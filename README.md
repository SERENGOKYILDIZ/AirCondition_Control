# Air Conditioner Control App

A Flutter application for controlling air conditioners from an Android phone. This app functions as a remote control with a modern, dark-themed interface.

## Features

- **Power Control**: Turn AC units on/off with a beautiful circular power button
- **Temperature Control**: Adjust temperature from 16°C to 30°C with intuitive controls
- **Mode Selection**: Choose between Cool, Heat, Fan, and Dry modes
- **Fan Speed Control**: Select from Auto, Low, Medium, and High fan speeds
- **Multiple AC Units**: Control different AC units in your home
- **Bluetooth Connectivity**: Connect to AC units via Bluetooth
- **Modern Dark UI**: Beautiful Material Design 3 interface with dark theme
- **Responsive Design**: Works on all screen sizes
- **Settings Persistence**: Saves your preferences automatically

## Screenshots

*Screenshots will be added here*

## Setup

### Prerequisites

- Flutter SDK (version >=3.0.0 <4.0.0)
- Android Studio / VS Code
- Android device or emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/aircondition_control_app.git
cd aircondition_control_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Requirements

### Android Permissions

The following permissions are required for the app to function properly:

- `BLUETOOTH` - Basic Bluetooth functionality
- `BLUETOOTH_ADMIN` - Bluetooth administration
- `BLUETOOTH_CONNECT` - Connect to Bluetooth devices
- `BLUETOOTH_SCAN` - Scan for Bluetooth devices
- `ACCESS_FINE_LOCATION` - Required for Bluetooth scanning
- `ACCESS_COARSE_LOCATION` - Alternative location permission
- `CAMERA` - For IR signal transmission (if applicable)

### Hardware Requirements

- Android device with Bluetooth capability
- AC units with Bluetooth or IR receiver compatibility

## Usage

### Basic Operation

1. **Select AC Unit**: Choose the AC unit you want to control from the dropdown
2. **Power On/Off**: Use the large circular power button to turn the AC on or off
3. **Temperature Control**: Adjust temperature using the +/- buttons or slider
4. **Mode Selection**: Choose the operating mode (Cool, Heat, Fan, Dry)
5. **Fan Speed**: Set the desired fan speed

### Bluetooth Connection

1. Tap the Bluetooth icon in the app bar
2. Grant necessary permissions when prompted
3. The app will automatically scan for available devices
4. Select your AC unit from the list
5. The connection status will be displayed in the app bar

## Technical Details

### Architecture

- **State Management**: Provider pattern for state management
- **Data Persistence**: SharedPreferences for saving user settings
- **Bluetooth Communication**: Flutter Blue Plus for Bluetooth operations
- **UI Framework**: Material Design 3 with custom dark theme

### Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  provider: ^6.0.5
  shared_preferences: ^2.2.0
  flutter_blue_plus: ^1.31.15
  permission_handler: ^11.3.1
```

### Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/
│   └── ac_provider.dart     # State management
├── screens/
│   └── home_screen.dart     # Main UI screen
├── widgets/
│   ├── ac_selector.dart     # AC unit selector
│   ├── power_button.dart    # Power on/off button
│   ├── temperature_control.dart # Temperature controls
│   ├── mode_selector.dart   # Mode selection
│   └── fan_speed_control.dart # Fan speed controls
└── services/
    └── bluetooth_service.dart # Bluetooth operations
```

## Development

### Building for Release

```bash
flutter build apk --release
```

### Testing

```bash
flutter test
```

## Troubleshooting

### Common Issues

1. **Bluetooth not working**: Ensure Bluetooth is enabled and permissions are granted
2. **App crashes on startup**: Check if all dependencies are properly installed
3. **Cannot connect to AC**: Verify AC unit supports Bluetooth and is in pairing mode

### Debug Mode

Run the app in debug mode for detailed logging:
```bash
flutter run --debug
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Contact

- **Developer**: Your Name
- **Email**: your.email@example.com
- **GitHub**: [@yourusername](https://github.com/yourusername)

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- Flutter Blue Plus contributors for Bluetooth functionality

---

**Note**: This app currently operates in simulation mode. Real IR signal transmission requires additional hardware integration. The Bluetooth service is ready and can be integrated with real devices.
