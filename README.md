# one_admax_flutter

![GitHub Release](https://img.shields.io/github/v/release/ONE-AdMax/ONEAdMax-Flutter)
![Pub Version](https://img.shields.io/pub/v/one_admax_flutter)
![Pub Points](https://img.shields.io/pub/points/one_admax_flutter)

A Flutter plugin for **ONE store AdMax Ads**.

For more information, refer to the [**ONE AdMax Developer Guides**](https://one-admax-organization.gitbook.io/one-admax-sdk).

## Getting Started

### Pre-Preparations for ONE ADMAX

Before you start using the ONE AdMax SDK, make sure to follow these steps:

- [How to obtain a Media Key in ONE AdMax](https://one-admax-organization.gitbook.io/one-admax-sdk/01.)
- [How to obtain a Placement Key in ONE AdMax](https://one-admax-organization.gitbook.io/one-admax-sdk/02.)

### Installation

#### 1. Add the Package

Run the following command to add the package to your project:

```bash
flutter pub add one_admax_flutter
```

Alternatively, you can manually add the dependency to your pubspec.yaml:

```yaml
dependencies:
  one_admax_flutter: ^1.0.5

```

After updating your pubspec.yaml, run flutter pub get to install the package.

#### 2. Modify build.gradle
In your project-level build.gradle, add the following Maven repository:

```groovy
allprojects {
  repositories {
    maven { url 'https://repo.onestore.net/repository/onestore-sdk-public' }
  }
}

```

#### 3. Modify AndroidManifest.xml
If your app's Target SDK version is 30 (OS 11) or higher, you must add the following <queries> block in the AndroidManifest.xml:
```xml
<manifest>
  ...
  <queries>
    <intent>
      <action android:name="com.onestore.iaa.intent.action.REWARD" />
    </intent>
  </queries>
  ...
  <application>
    ...
  </application>
</manifest>
```

## Usage
Import the plugin in your Dart code:
```dart
import 'package:one_admax_flutter/one_admax_flutter.dart';
```
- [Flutter-Plugin Guide](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide)
- [보상형 비디오 광고 for Flutter](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-1.-for-flutter)
- [전면 광고 for Flutter](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/interstitial)
- [배너 광고 구현하기](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-3.)
- [전면 비디오 광고 for Flutter (비보상형)](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-4.-for-flutter)

## Android Proguard Rules

The plugin is already obfuscated and packaged as an AAR. However, you need to add the following Proguard rules to ensure proper obfuscation:

```text
-keep packagenames com.oneadmax.**
-keep class com.oneadmax.global.** { public *; }
-keep enum com.oneadmax.internal.* { *; }

```

## Note

This plugin uses [json_serializable](https://pub.dev/packages/json_serializable) for the many data structs passed between the underlying platform layers and Dart.
After editing any of the serialized data structs, rebuild the serializers by running
`flutter packages pub run build_runner build --delete-conflicting-outputs`.
`flutter packages pub run build_runner watch --delete-conflicting-outputs` will watch the file system for changes.
