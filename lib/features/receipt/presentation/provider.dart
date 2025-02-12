import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final receiptPageProvider = Provider((_) => _Provider());

class _Provider {
  void onShare(GlobalKey key) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => _shareReceipt(key));

  Future<void> _shareReceipt(GlobalKey key) async {
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) return;

    final pngBytes = byteData.buffer.asUint8List();
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/receipt.png';
    final file = File(filePath);
    await file.writeAsBytes(pngBytes);

    await Share.shareXFiles([XFile(filePath)], text: 'Here is your receipt!');

    await Future.delayed(const Duration(seconds: 5));

    if (file.existsSync()) file.delete();
  }
}
