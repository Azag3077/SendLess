import 'package:flutter/material.dart';

import '../../../../../core/constants/assets.dart';
import 'page_indicator.dart';

class SwiperView extends StatefulWidget {
  const SwiperView({
    super.key,
    required this.children,
  });

  final List<SwiperContent> children;

  @override
  State<SwiperView> createState() => _SwiperViewState();
}

class _SwiperViewState extends State<SwiperView> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 130.0,
          child: PageView(
            controller: _controller,
            children: widget.children,
          ),
        ),
        const SizedBox(height: 8.0),
        const Center(
          child: PageIndicator(
            index: 1,
            length: 3,
          ),
        ),
      ],
    );
  }
}

class SwiperContent extends StatelessWidget {
  const SwiperContent({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFF3E9850),
            Color(0xFF14321A),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                subtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  textStyle: const TextStyle(fontSize: 10.0),
                ),
                child: const Text('Enjoy now'),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
          Image.asset(AssetImages.pngs.screenshot),
        ],
      ),
    );
  }
}
