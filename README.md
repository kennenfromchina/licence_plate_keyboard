# licence_plate_keyboard

A Chinese licence plate keyboard with cool_ui, support iOS, Android and Web, if you have any question with this plugin, please report issues in this repository

## Getting Started

Change your pubspec.yaml below

Flutter >= 2.5

``` yaml
dependencies:
  licence_plate_keyboard: ^0.1.0
```

Flutter >= 2.0

``` yaml
dependencies:
  licence_plate_keyboard: ^0.0.11
```

If your flutter version >= 2.5, please change your main.dart

``` dart
void main() {
  // runApp(MyApp()); // old
  runMockApp(KeyboardRootWidget(child: MyApp())); // new
}
```

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

