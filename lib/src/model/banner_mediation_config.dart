sealed class BannerMediationExtras {
  Map<String, dynamic> toMap();
}

class MezzoExtras extends BannerMediationExtras {
  bool? isEnableBackgroundCheck;
  int? ageLevel;
  String? storeUrl;

  MezzoExtras({this.ageLevel, this.isEnableBackgroundCheck, this.storeUrl});

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (isEnableBackgroundCheck != null) {
      data['MEZZO_ENABLE_BACKGROUND_CHECK'] = isEnableBackgroundCheck;
    }
    if (ageLevel != null) {
      data['MEZZO_AGE_LEVEL'] = ageLevel;
    }
    if (storeUrl != null) {
      data['MEZZO_STORE_URL'] = storeUrl;
    }
    return data;
  }
}

class CaulyExtras extends BannerMediationExtras {
  bool? isEnableLock;
  bool? isEnableDynamicReloadInterval;
  int? reloadInterval;
  int? threadPriority;

  CaulyExtras(
      {this.isEnableLock,
      this.isEnableDynamicReloadInterval,
      this.reloadInterval,
      this.threadPriority});

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    //Default false
    if (isEnableLock != null) {
      data['CAULY_ENABLE_LOCK'] = isEnableLock;
    }
    //Default true
    if (isEnableDynamicReloadInterval != null) {
      data['CAULY_ENABLE_DYNAMIC_RELOAD_INTERVAL'] =
          isEnableDynamicReloadInterval;
    }
    //Default 20s
    if (reloadInterval != null) {
      data['CAULY_RELOAD_INTERVAL'] = reloadInterval;
    }
    //Default 5
    if (threadPriority != null) {
      data['CAULY_THREAD_PRIORITY'] = threadPriority;
    }
    return data;
  }
}
