# one_admax_flutter

[![GitHub CI](https://github.com/ONE-store/flutter_plugins/actions/workflows/flutter.yml/badge.svg)](https://github.com/ONE-store/flutter_plugins/actions)
[![GitHub release (with filter)](https://img.shields.io/github/v/release/ONE-store/flutter_plugins)](https://github.com/ONE-store/flutter_plugins/releases/tag/flutter_onestore_inapp-v0.3.0)
[![Pub Version (including pre-releases)](https://img.shields.io/pub/v/flutter_onestore_inapp)](https://pub.dev/packages/flutter_onestore_inapp/versions/0.3.0)
[![Pub Points](https://img.shields.io/pub/points/flutter_onestore_inapp)](https://pub.dev/packages/flutter_onestore_inapp/score)


A flutter plugin for ONE store AdMax Ads.

> For more information, see the [**ONE AdMax Developer Guides**](https://one-admax-organization.gitbook.io/one-admax-sdk).

## Getting started

### Pre-Preparations for ONE ADMAX

> - [How to obtain a Media Key in ONE AdMax](https://one-admax-organization.gitbook.io/one-admax-sdk/appkey)
> - [How To obtain a Placement Key in ONE AdMax](https://one-admax-organization.gitbook.io/one-admax-sdk/placementid)


### Installation

> - Add package
    >   - Run this command with flutter:
          >
          >       ```
>         $ flutter pub add one_admax_flutter
>       ```
>
>   - Add dependency to **pubspec.yaml**
      >
      >       ```dart
>         dependencies:
>           one_admax_flutter: ^1.0.0
>       ```
>
>   - Click 'pub get' to download the package or run 'flutter pub get' from the command line.
>
> - Add dependencies to **build.gradle**
    >
    >   - Add the maven address to the **project's** build.gradle
          >
          >       ```groovy
>         allprojects {
>           repositories {
>             maven { url 'https://repo.onestore.net/repository/onestore-sdk-public' }
>           }
>         }
>       ```
>
> - Add **<queries>** to **AndroidManifest.xml**
    >   - [If the Target SDK version is 30 (OS 11) or higher](https://dev.onestore.co.kr/devpoc/support/news/noticeView.omp?pageNo=4&noticeId=32968&viewPageNo=&searchValue=), the **\<queries\>** below must be added for the in-app library to operate properly.
          >
          >       ```xml
>         <manifest>
>             ...
>             <queries>
>                 <intent>
>                     <action android:name="com.onestore.iaa.intent.action.REWARD" />
>                 </intent>
>             </queries>
>             ...
>             <application>
>                 ...
>             </application>
>         </manifest>
>       ```


## Usage

> Import it and use in Dart code.
>
>   ```dart
>     import 'package:one_admax_flutter/one_admax_flutter.dart';
>   ```

- [Flutter-Plugin Guide](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide)
- [보상형 비디오 광고 for Flutter](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-1.-for-flutter)
- [전면 광고 for Flutter](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/interstitial)
- [전면 비디오 광고 구현하기](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-3.)
- [전면 비디오 광고 for Flutter (비보상형)](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-4.-for-flutter)


## Android Proguard Rules
**It's already obfuscated and in aar, so add the package to the proguard rules.**

```text
-keeppackagenames com.oneadmax.**

-keep class com.oneadmax.global.** { public *; }
-keep enum com.oneadmax.internal.* { *; }
```


## Note

This plugin uses
[json_serializable](https://pub.dev/packages/json_serializable) for the
many data structs passed between the underlying platform layers and Dart. After
editing any of the serialized data structs, rebuild the serializers by running
`flutter packages pub run build_runner build --delete-conflicting-outputs`.
`flutter packages pub run build_runner watch --delete-conflicting-outputs` will
watch the filesystem for changes.

