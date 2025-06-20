/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/homeScreen
  $AssetsImagesHomeScreenGen get homeScreen =>
      const $AssetsImagesHomeScreenGen();

  /// Directory path: assets/images/icons
  $AssetsImagesIconsGen get icons => const $AssetsImagesIconsGen();

  /// Directory path: assets/images/splashScreen
  $AssetsImagesSplashScreenGen get splashScreen =>
      const $AssetsImagesSplashScreenGen();
}

class $AssetsImagesHomeScreenGen {
  const $AssetsImagesHomeScreenGen();

  /// File path: assets/images/homeScreen/Cardiologist.png
  AssetGenImage get cardiologist =>
      const AssetGenImage('assets/images/homeScreen/Cardiologist.png');

  /// File path: assets/images/homeScreen/Dentist.png
  AssetGenImage get dentist =>
      const AssetGenImage('assets/images/homeScreen/Dentist.png');

  /// File path: assets/images/homeScreen/Doctor.png
  AssetGenImage get doctor =>
      const AssetGenImage('assets/images/homeScreen/Doctor.png');

  /// File path: assets/images/homeScreen/Group.png
  AssetGenImage get group =>
      const AssetGenImage('assets/images/homeScreen/Group.png');

  /// File path: assets/images/homeScreen/Lungs.png
  AssetGenImage get lungs =>
      const AssetGenImage('assets/images/homeScreen/Lungs.png');

  /// File path: assets/images/homeScreen/Mask Group.png
  AssetGenImage get maskGroup =>
      const AssetGenImage('assets/images/homeScreen/Mask Group.png');

  /// File path: assets/images/homeScreen/Psychiatrist.png
  AssetGenImage get psychiatrist =>
      const AssetGenImage('assets/images/homeScreen/Psychiatrist.png');

  /// File path: assets/images/homeScreen/Rectangle 460.png
  AssetGenImage get rectangle460 =>
      const AssetGenImage('assets/images/homeScreen/Rectangle 460.png');

  /// File path: assets/images/homeScreen/Stroke 4.png
  AssetGenImage get stroke4 =>
      const AssetGenImage('assets/images/homeScreen/Stroke 4.png');

  /// File path: assets/images/homeScreen/Vector.png
  AssetGenImage get vector =>
      const AssetGenImage('assets/images/homeScreen/Vector.png');

  /// File path: assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png
  AssetGenImage get pexelsCedricFauntleroy42703712x => const AssetGenImage(
    'assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png',
  );

  /// List of all assets
  List<AssetGenImage> get values => [
    cardiologist,
    dentist,
    doctor,
    group,
    lungs,
    maskGroup,
    psychiatrist,
    rectangle460,
    stroke4,
    vector,
    pexelsCedricFauntleroy42703712x,
  ];
}

class $AssetsImagesIconsGen {
  const $AssetsImagesIconsGen();

  /// File path: assets/images/icons/apple_icon.png
  AssetGenImage get appleIcon =>
      const AssetGenImage('assets/images/icons/apple_icon.png');

  /// File path: assets/images/icons/facebook_icon.png
  AssetGenImage get facebookIcon =>
      const AssetGenImage('assets/images/icons/facebook_icon.png');

  /// File path: assets/images/icons/google_icon.png
  AssetGenImage get googleIcon =>
      const AssetGenImage('assets/images/icons/google_icon.png');

  /// File path: assets/images/icons/name_icon.png
  AssetGenImage get nameIcon =>
      const AssetGenImage('assets/images/icons/name_icon.png');

  /// File path: assets/images/icons/username_icon.png
  AssetGenImage get usernameIcon =>
      const AssetGenImage('assets/images/icons/username_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    appleIcon,
    facebookIcon,
    googleIcon,
    nameIcon,
    usernameIcon,
  ];
}

class $AssetsImagesSplashScreenGen {
  const $AssetsImagesSplashScreenGen();

  /// File path: assets/images/splashScreen/logogreen.png
  AssetGenImage get logogreen =>
      const AssetGenImage('assets/images/splashScreen/logogreen.png');

  /// File path: assets/images/splashScreen/logosplash.png
  AssetGenImage get logosplash =>
      const AssetGenImage('assets/images/splashScreen/logosplash.png');

  /// File path: assets/images/splashScreen/onboardingpic.png
  AssetGenImage get onboardingpic =>
      const AssetGenImage('assets/images/splashScreen/onboardingpic.png');

  /// List of all assets
  List<AssetGenImage> get values => [logogreen, logosplash, onboardingpic];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
