import 'package:flutter/material.dart';

import '../../../../../core/constants/assets.dart';
import '../../provider.dart';

class VirtualCardContainer extends StatelessWidget {
  const VirtualCardContainer({
    super.key,
    required this.virtualCard,
    required this.visibility,
  });

  final VirtualCard? virtualCard;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(AssetImages.pngs.visaCard),
        ),
      ),
    );
  }
}
