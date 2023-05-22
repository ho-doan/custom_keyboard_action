# custom_keyboard_action

* [![custom_keyboard_action version](https://img.shields.io/pub/v/custom_keyboard_action?label=custom_keyboard_action)](https://pub.dev/packages/custom_keyboard_action)
[![custom_keyboard_action size](https://img.shields.io/github/repo-size/ho-doan/custom_keyboard_action)](https://github.com/ho-doan/custom_keyboard_action)
[![custom_keyboard_action issues](https://img.shields.io/github/issues/ho-doan/custom_keyboard_action)](https://github.com/ho-doan/custom_keyboard_action)
[![custom_keyboard_action issues](https://img.shields.io/pub/likes/custom_keyboard_action)](https://github.com/ho-doan/custom_keyboard_action)
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
-keep class com.hodoan.custom_keyboard_action.** { *; }
```

### Usage

#### Scan Device

```dart
TextFormFieldCustomKeyboard(
    controller: TextEditingController(),
),
```