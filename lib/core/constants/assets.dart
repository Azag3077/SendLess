class AssetImages {
  static final png = _PngAssetsName();
  static final svgs = _SvgAssetsName();
}

class _PngAssetsName {
  static const _root = 'assets/images/pngs';

  final money = '$_root/money.png';
  final search = '$_root/search.png';
  final splash = '$_root/launcher-icon.jpg';
  final onboarding = '$_root/onboarding.png';
  final visaCard = '$_root/vise-card.png';
}

class _SvgAssetsName {
  static const _root = 'assets/images/svgs';

  final logo = '$_root/logo.svg';
  final splashLogo = '$_root/splash_logo.svg';
}
