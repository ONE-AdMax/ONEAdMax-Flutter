# ONE AdMax Example

## Android Setup

### 1. `build.gradle (project)`

To use the ONE AdMax SDK, add the following repository:

```groovy
allprojects {
    repositories {
        maven {
            url "https://repo.onestore.co.kr/repository/onestore-sdk-public"
        }
    }
}
```

If you are using Cauly mediation, add the following as well:

```groovy
maven {
    name = "GitHubPackages"
    url = uri("https://maven.pkg.github.com/cauly/Android-SDK/SDK")
    credentials {
        username = 'cauly'
        password = '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'
    }
}
```

### 2. `build.gradle (app)`

```groovy
dependencies {
    implementation 'com.oneadmax.sdk:sdk-ads:1.2.2'
}
```

If you plan to use mediation, you also need to add dependencies for each mediation.  
(MezzoMedia requires a JAR file to be added manually.)  
⚠️ Please note that mismatched versions between ONE AdMax and mediation SDKs may result in errors.  
Below are the compatible mediation versions for ONE AdMax v1.2.2:

```groovy
dependencies {
    // AppLovin
    api 'com.applovin:applovin-sdk:13.1.0'

    // Cauly
    api 'com.google.android.gms:play-services-ads-identifier:17.0.0'
    api 'com.google.android.gms:play-services-appset:16.0.0'
    api 'com.fsn.cauly:cauly-sdk:3.5.35'

    // Mobon
    api('io.github.mobon:mobonSDK:1.0.0.65') {
        transitive = true
    }

    // UnityAds
    api 'com.unity3d.ads:unity-ads:4.14.1'

    // MezzoMedia. manlibrary_v3.0.0_20250210.jar v300
    implementation files('libs/manlibrary_v3.0.0_20250210.jar')

    // Vungle
    api 'com.vungle:vungle-ads:7.4.3'
}
```

### 3. AndroidManifest.xml

Register the app key issued from the ONE AdMax console:

```xml
<application>
    <meta-data
        android:name="com.oneadmax.global.appkey"
        android:value="...your app key..." />
</application>
```
Note: In the example app, different ads are shown depending on the app key, so we use conditional branching for multiple keys.  
However, in most cases, you only need to use a single app key when developing your own app.
---

##  Flutter/Dart Code Overview

### App Structure

The example app uses `Riverpod` for state management and `GoRouter` for navigation.  
The initial screen is defined in `admaxRouter` within `oam_router.dart`, and set in `main.dart`.  
The default entry point is `HomeScreen (/)`.

`HomeScreen` is responsible for initializing ONE AdMax and listing available ad types.  
Ads are provided through ONE AdMax (pure) and six different mediation partners.  
Supported ad formats vary by mediation.

---

### Initialization and Shutdown

ONE AdMax must be initialized before loading any ads.  
You are also encouraged to properly dispose of the SDK when the app exits.  
Logging is optional but can be enabled for debugging.

```dart
void initAdMax(){
    ONEAdMax.initialize((bool isSuccess) {
        ONEAdMax.setLogEnabled(true); // optional: enable logs
    });
}

void unInitAdMax() {
    ONEAdMax.dispose();
}
```

Ads are displayed on navigated screens based on the selected ad provider in `HomeScreen`.

## Mediation

If you are using mediation, you must register a Placement in the ONE AdMax console to receive a Placement ID.  
In the example app, you can enter the issued Placement ID in the `assets/.env` file.

## Ad Types Guide

### Rewarded Video Ads

This corresponds to the second tab (Reward) in the navigation bar.  
Rewarded video ads are designed to grant users a reward after they finish watching.  
Therefore, a user identifier must be set **before** loading the ad:

```dart
ONEAdMax.setUserId(userId);
```

> Reference: [Flutter Plugin Guide - Setting User ID](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-1.-for-flutter#undefined-2)

Create an instance and load the ad using a placement ID issued from the ONE AdMax console:

```dart
late OAMReward _oamReward;

_oamReward = OAMReward();
_oamReward.load(
    placementId: rewardPlacementId, 
    callback: RewardCallBackListener(
        onLoaded: onLoaded,
        onLoadFailed: onLoadFailed,
        onOpened: onOpened,
        onOpenFailed: onOpenFailed,
        onClosed: onClosed,
        onCompleted: onCompleted,
        onClicked: onClicked,
    )
);
```

Once loaded, show the ad:

```dart
_oamReward.show();
```

Handle app lifecycle changes accordingly:

```dart
void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
        case AppLifecycleState.resumed:
            _viewModel.resume();
            break;
        case AppLifecycleState.paused:
            _viewModel.pause();
            break;
    }
}

// viewModel.dart
void resume() => _oamReward.resume();
void pause() => _oamReward.pause();
```

Dispose of the ad properly when the screen is closed:

```dart
@override
void dispose() {
    _viewModel.dispose();
}

// viewModel.dart
void dispose() {
    _oamReward.dispose();
}
```

**Supported by**: ONE AdMax, UnityAds, Vungle, AppLovin

---

### Interstitial & Non-Rewarded Video Ads

These are fullscreen ads including both interstitials and non-rewarded videos.  
This corresponds to the third tab (Interstitial) in the navigation bar.

You can customize interstitial options:

```dart
_oamInterstitial.interstitialConfig.isHideCloseButton = false;
_oamInterstitial.interstitialConfig.backgroundColor = Colors.red;
_oamInterstitial.interstitialConfig.endingText = const EndingText(
    'Sample Text',
    12,
    Colors.white,
    TextAlign.center,
    true,
);
_oamInterstitial.interstitialConfig.closeBtnMargin = const CloseBtnMargin(
    top: 10,
    left: 10,
    right: 10,
    bottom: 10,
);
```

Create and load the interstitial ad using a valid placement ID:

```dart
_oamInterstitial = OAMInterstitial();

_oamInterstitial.load(
    placementId: interstitialPlacementId,
    callback: InterstitialCallBackListener(
        onLoaded: onLoaded,
        onLoadFailed: onLoadFailed,
        onOpened: onOpened,
        onOpenFailed: onOpenFailed,
        onClosed: onClosed,
        onClicked: onClicked,
    ),
);
```

To show the ad:

```dart
_oamInterstitial.show();
```

Dispose of the ad when the screen is closed:

```dart
@override
void dispose() {
    _oamInterstitial.dispose();
    super.dispose();
}
```

**Supported by**: ONE AdMax, Cauly, UnityAds

For non-rewarded video ads, use the `OAMInterstitialVideo` class:

```dart
late OAMInterstitialVideo _oamInterstitialVideo;
```

**Supported by**: ONE AdMax, UnityAds, Vungle, AppLovin

⚠️ Note: Interstitial and non-rewarded video ads use different classes and must have separate placement IDs.

---

### Banner Ads

Banner ads are rectangular display units that stay on-screen while users interact with the app.  
This corresponds to the fourth tab (Banner) in the navigation bar.

Placement IDs for each banner size must be issued via the ONE AdMax console.  
You can embed them as widgets in your layout.

```dart
OAMBannerWidget(
    placementId: banner.placementId,
    callback: BannerCallBackListener(
        onLoaded: onLoaded,
        onLoadFailed: onLoadFailed,
        onClicked: onClicked),
    bannerSize: banner.bannerSize,
    bannerMediationExtras: banner.bannerMediationExtras,
);
```

**Supported by**: ONE AdMax, Mobon, MezzoMedia, Cauly, UnityAds