# ONE AdMax Example

## Android 설정

### 1. `build.gradle (project)` 설정

ONE AdMax SDK를 사용하려면 아래 저장소를 추가해야 합니다:
```groovy
allprojects {
    repositories {
        maven {
            url "https://repo.onestore.co.kr/repository/onestore-sdk-public"
        }
    }
}
```

Cauly mediation을 사용하는 경우, 추가 저장소 설정이 필요합니다:
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

### 2. `build.gradle (app)` 설정
```groovy
dependencies {
    implementation 'com.oneadmax.sdk:sdk-ads:1.2.2'
}
```

mediation을 사용하는 경우, 각각에 대한 의존성도 추가해야 합니다.  
MezzoMedia는 JAR 파일로 직접 추가합니다.  
※ ONE AdMax와 mediation SDK 버전이 불일치하면 오류가 발생할 수 있습니다.  
아래는 ONE AdMax v1.2.2에 호환되는 mediation version 입니다.

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

### 3. AndroidManifest.xml 설정
ONE AdMax 콘솔에서 발급 받은 appkey를 AndroidManifest.xml에 등록합니다.
```xml
<application>
    <meta-data
        android:name="com.oneadmax.global.appkey"
        android:value="...your app key..." />
</application>
```
참고 : 예제앱은 appKey에 따라 설정된 광고가 달라서 두개를 분기하여 사용중입니다. 일반적으로 앱을 개발하실때는 하나로 사용하시면 됩니다.
---

## Flutter/Dart 코드 설명

### 앱 기본 구조

예제 앱은 `Riverpod`으로 상태를 관리하고, `GoRouter`로 화면을 전환합니다.  
`main.dart`에서는 `oam_router.dart`에 정의된 `admaxRouter`를 통해 첫 화면을 지정하며,  
기본 화면은 `HomeScreen (/)`입니다.

`HomeScreen`은 ONE AdMax를 초기화하고, 사용 가능한 광고를 리스트업합니다.  
광고는 ONE AdMax(pure)와 6개의 mediation으로 제공됩니다.  
각 mediation에 따라 지원되는 광고 형식이 다릅니다.

---

### 초기화 및 종료
ONE AdMax 를 사용하기 위해서는 광고를 로드하기전에 초기화가 필요합니다.  
반대로 앱 종료시 ONE AdMax 를 비활성화 해주는것이 좋습니다.   
필요에 따라 로그를 활성화하여 활용할 수 있습니다.
```dart
void initAdMax(){
    ONEAdMax.initialize((bool isSuccess) {
        ONEAdMax.setLogEnabled(true); // optional: 로그 활성화
    });
}

void unInitAdMax() {
    ONEAdMax.dispose();
}
```

Home Screen에서 선택한 광고 제공사에 따라 네비게이션바로 이동한 화면에 광고가 표시됩니다.

## 미디에이션

미디에이션을 사용하는 경우, ONE AdMax 콘솔에서 Placement를 등록하여 Id를 발급 받아야합니다.  
예제앱에서는 발급 받은 Placement Id를 assets/.env 파일에 입력해주면 됩니다.

## 광고 유형별 가이드

### 보상형 비디오 광고
네비게이션바의 두번째 메뉴인 Reward 부분입니다.  
보상형 비디오 광고는 사용자가 광고를 모두 시청하였을때 보상을 지급하기 위한 용도입니다.  
그래서 반드시 광고를 시청하기 이전에 다음과 같이 사용자에 대한 식별키 지정이 필요합니다.  
(단, 예제앱은 실제 보상을 지급하지 않기 때문에 식별키를 지정하지 않았습니다. )
```dart
ONEAdMax.setUserId(userId);
```
다음의 페이지에서 식별키 지정에 대한 주의 사항을 확인해주세요.
> 참고: [Flutter Plugin Guide - User ID 설정](https://one-admax-organization.gitbook.io/one-admax-sdk/05.-flutter-plugin-guide/5-1.-for-flutter#undefined-2)

보상형 광고 인스턴스를 먼저 생성하고, 보여줄 광고가 있는지 로드합니다.  
로드할때 필요한 placementId는 ONE AdMax 콘솔에서 생성이 가능합니다.  
callback으로 다양한 상황에 대해 대응이 가능합니다.

```dart
late OAMReward _oamReward;
...
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

광고가 준비가 되었다면 사용자에게 보여줄 수 있습니다. 다음의 내용을 호출하여 광고를 보여줍니다.
```dart
_oamReward.show();
```

또한 앱의 라이프사이클을 캐치하여 그에 맞게 광고를 멈추거나 재실행할 수 있습니다.
```dart
void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
        case AppLifecycleState.resumed:
            _viewModel.resume();
            break;
        case AppLifecycleState.paused:
            _viewModel.pause();
            break;
        
        ...
    }
}

// viewModel.dart
void resume() {
    _oamReward.resume();
}
void pause() {
    _oamReward.pause();
}
```

메모리 해지를 위해 광고가 보여지는 화면이 종료될때 꼭 dispose를 호출해주세요
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

보상형 비디오 광고는 ONE AdMax, UnityAds, Vungle, Applovin 에서 지원합니다.

### 전면 광고 (+비보상형 비디오 광고)
화면 전체를 덮는 광고와 비보상형 비디오 광고를 포함합니다.  
네비게이션바에서 세번째 메뉴인 interstitial 입니다.

전면 광고는 다양한 커스텀 옵션을 제공합니다.   
배경색, 닫기버튼 노출여부, 마진, 백키, 메세지 등에 대한 설정이 가능합니다.   
예제앱에서는 다음과 같이 커스텀 옵션을 지정하고 있습니다.
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

전면 광고를 보여주기 위해서는 인스턴스를 생성하고 미리 광고를 불러와야합니다.
광고를 불러올때는 placementId가 필요하며, ONE AdMax 콘솔에서 발급 받을 수 있습니다.
또한 callback을 통해 다양한 상황에 대해 대응이 가능합니다.
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

광고가 준비되었다면 필요한 상황에 사용자에게 보여줄 수 있습니다.
```dart
_oamInterstitial.show();
```

광고를 보여주고 화면이 닫힐 때 메모리 해제를 위해 다음의 내용을 호출해주세요.
```dart
@override
  void dispose() {
    _oamInterstitial.dispose();
    super.dispose();
  }
```

전면 광고는 ONE AdMax, cauly, unityAds 에서 지원합니다.

비보상형 비디오 광고도 전면 광고와 동일하게 사용 가능합니다.
단, 생성시 객체를 Video로 지정해주어야 합니다.
```dart
late OAMInterstitialVideo _oamInterstitialVideo;
```

비보상형 비디오 광고는 ONE AdMax, UnityAds, Vungle, Applovin 에서 지원합니다.

일반 전면 광고와 비보상형 비디오 광고는 명칭이 비슷하지만 다른 객체를 사용하여야하고,   
placementId도 따로 발급 받아야함을 주의해주세요.


### 배너 광고
배너 광고는 화면의 한 부분을 차지하는 직사각형의 이미지 또는 텍스트 광고입니다.   
사용자가 앱과 상호작용하는 동안 화면에 지속적으로 노출 되며, 자동으로 새로고침 됩니다.  
네비게이션바에서 4번째 메뉴인 Banner 부분입니다.

ONE AdMax 콘솔에서 배너광고를 생성하고 각 사이즈별로 placementId를 발급받아야합니다.  
사용중인 화면내에 위젯으로 바로 추가하여 사용 가능합니다.  
callback 으로 여러 상황에 대응이 가능합니다.
size를 명확히 지정해주어야 하며, 미디에이션 사용시 추가적인 extra를 요구할 수도 있습니다.
```dart
OAMBannerWidget(
    placementId: banner.placementId,
    callback: BannerCallBackListener(
        onLoaded: onLoaded,
        onLoadFailed: onLoadFailed,
        onClicked: onClicked),
    bannerSize: banner.bannerSize,
    bannerMediationExtras: banner.bannerMediationExtras
);
```

배너 광고는 ONE AdMax, Mobon, MezzoMedia, Cauly, Unityads에서 지원합니다.