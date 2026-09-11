import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Scope of interior design work.
enum InteriorDesignScope {
  all('all'),
  specific('specific');

  final String value;
  const InteriorDesignScope(this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      InteriorDesignScope.all => loc.interiorDesignScopeEntireProject,
      InteriorDesignScope.specific => loc.interiorDesignScopeSpecificAreas,
    };
  }

  static InteriorDesignScope? fromValue(String? value) {
    if (value == null) return null;
    for (final item in InteriorDesignScope.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }
}

/// Budget tier for interior design.
enum BudgetTier {
  standard('standard'),
  premium('premium'),
  ultraLuxury('ultra_luxury');

  final String value;
  const BudgetTier(this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      BudgetTier.standard => loc.interiorDesignBudgetStandard,
      BudgetTier.premium => loc.interiorDesignBudgetPremium,
      BudgetTier.ultraLuxury => loc.interiorDesignBudgetUltraLuxury,
    };
  }

  static BudgetTier? fromValue(String? value) {
    if (value == null) return null;
    for (final item in BudgetTier.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }
}

/// Expected project delivery timeline for interior design.
enum ProjectTimeline {
  flexible('flexible'),
  threeToSixMonths('3_6_months'),
  asap('asap');

  final String value;
  const ProjectTimeline(this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      ProjectTimeline.flexible => loc.interiorDesignTimelineFlexible,
      ProjectTimeline.threeToSixMonths =>
        loc.interiorDesignTimelineThreeToSixMonths,
      ProjectTimeline.asap => loc.interiorDesignTimelineAsap,
    };
  }

  static ProjectTimeline? fromValue(String? value) {
    if (value == null) return null;
    for (final item in ProjectTimeline.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }
}
