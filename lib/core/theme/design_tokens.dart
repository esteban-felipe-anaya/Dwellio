import 'package:flutter/widgets.dart';

/// Centralized design tokens — spacing, radii, sizing, durations and
/// breakpoints. No widget should hardcode these values inline.
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  // Common EdgeInsets presets.
  static const EdgeInsets pageH = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets pageAll = EdgeInsets.all(lg);
  static const EdgeInsets cardAll = EdgeInsets.all(md);
}

class AppRadii {
  const AppRadii._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius sheetRadius =
      BorderRadius.vertical(top: Radius.circular(xl));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(pill));
}

class AppSizes {
  const AppSizes._();

  static const double listingCardImage = 180;
  static const double agentAvatar = 56;
  static const double iconChip = 18;
  static const double mapPinSize = 44;
  static const double maxContentWidth = 1280;
}

class AppDurations {
  const AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

/// Responsive breakpoints (logical pixels), aligned with Material 3 window
/// size classes.
class Breakpoints {
  const Breakpoints._();

  static const double medium = 600; // mobile -> tablet
  static const double expanded = 840; // tablet -> desktop/web

  static bool isCompact(double width) => width < medium;
  static bool isMedium(double width) => width >= medium && width < expanded;
  static bool isExpanded(double width) => width >= expanded;
}
