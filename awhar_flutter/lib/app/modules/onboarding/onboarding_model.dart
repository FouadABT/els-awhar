/// Onboarding page data model
class OnboardingPageData {
  final String titleKey;
  final String subtitleKey;
  final String imagePath;
  final OnboardingBackgroundStyle backgroundStyle;

  const OnboardingPageData({
    required this.titleKey,
    required this.subtitleKey,
    required this.imagePath,
    required this.backgroundStyle,
  });
}

/// Background style for onboarding pages
enum OnboardingBackgroundStyle {
  /// Cream / Soft Peach - for discovery
  discover,

  /// Soft mint / light green - for action
  action,

  /// Soft beige / peach - for trust
  trust,
}
