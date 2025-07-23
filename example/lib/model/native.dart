import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../const/oamPlacementIds.dart';

sealed class MediationNative {
  final String placementId;
  final String factoryId;


  MediationNative(this.placementId, this.factoryId);

  factory MediationNative.pure() => PureNative(OamPlacementIds.NATIVE_ID, 'plugin/native_widget');
  factory MediationNative.mobon() => MobonNative(dotenv.env['MOBON_NATIVE_PLACEMENT_ID']!, 'plugin/native_mobon_widget');
  factory MediationNative.applovin() => AppLovinNative(dotenv.env['APPLOVIN_NATIVE_PLACEMENT_ID']!, 'plugin/native_applovin_widget');

}

class PureNative extends MediationNative {
  PureNative(super.placementId, super.factoryId);
}

class MobonNative extends MediationNative {
  MobonNative(super.placementId, super.factoryId);
}

class AppLovinNative extends MediationNative {
  AppLovinNative(super.placementId, super.factoryId);
}