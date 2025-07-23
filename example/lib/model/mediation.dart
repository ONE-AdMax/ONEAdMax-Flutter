enum Mediation {
  pure("All"),
  mobon("Banner, Native"),
  mezzo("Banner"),
  cauly("Banner, Interstitial"),
  unityAds("Banner, Interstitial + Video, Reward Video"),
  vungle("Interstitial Video, Reward Video"),
  applovinBidding("Interstitial Video, Reward Video, Native"),
  applovinWaterfall("Interstitial Video, Reward Video");

  const Mediation(this.subtitle);

  final String subtitle;
}
