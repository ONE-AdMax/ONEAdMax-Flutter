sealed class MediationNative {
  final String placementId;
  final String factoryId;


  MediationNative(this.placementId, this.factoryId);

  factory MediationNative.pure() => PureNative('ONESTORE_NATIVE', 'plugin/native_widget');
  factory MediationNative.adfit() => AdFitNative('xc68IecGCuJ0mHX', 'plugin/native_adfit_widget');
  factory MediationNative.adfittemplate() => AdFitTemplateNative('xc68IecGCuJ0mHX', 'plugin/native_adfit_template_widget');
  factory MediationNative.mobon() => MobonNative('acPNfTDu1Urdw56', 'plugin/native_mobon_widget');
  factory MediationNative.applovin() => AppLovinNative('dwvg5nwfH33YgTy', 'plugin/native_applovin_widget');

}

class PureNative extends MediationNative {
  PureNative(super.placementId, super.factoryId);
}

class AdFitNative extends MediationNative {
  AdFitNative(super.placementId, super.factoryId);
}

class AdFitTemplateNative extends MediationNative {
  AdFitTemplateNative(super.placementId, super.factoryId);
}

class MobonNative extends MediationNative {
  MobonNative(super.placementId, super.factoryId);
}

class AppLovinNative extends MediationNative {
  AppLovinNative(super.placementId, super.factoryId);
}