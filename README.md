# keyboard_action

* [![keyboard_action version](https://img.shields.io/pub/v/keyboard_action?label=keyboard_action)](https://pub.dev/packages/keyboard_action)
[![keyboard_action size](https://img.shields.io/github/repo-size/ho-doan/keyboard_action)](https://github.com/ho-doan/keyboard_action)
[![keyboard_action issues](https://img.shields.io/github/issues/ho-doan/keyboard_action)](https://github.com/ho-doan/keyboard_action)
[![keyboard_action issues](https://img.shields.io/pub/likes/keyboard_action)](https://github.com/ho-doan/keyboard_action)
* Bluetooth Low Energy (BLE) plugin that can communicate with single device

# Demo

<img src="./assets/keyboard_ios.png" height=400 alt="Keyboard ios">
<img src="./assets/keyboard_android.png" height=400 alt="Keyboard android">

## Futures

- Add sub view keyboard

## Getting Started

### android

#### Android ProGuard rules

```txt
-keep class com.hodoan.keyboard_action.** { *; }
```

### Usage

#### Scan Device

```dart
TextFormFieldCustomKeyboard(
    controller: TextEditingController(),
),
```