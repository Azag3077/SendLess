import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/double.dart';

class AccountBalance extends ConsumerWidget {
  const AccountBalance({
    super.key,
    required this.amount,
    required this.isBalanceVisible,
    required this.symbol,
    this.onToggle,
  });

  final double amount;
  final bool isBalanceVisible;
  final String symbol;
  final VoidCallback? onToggle;

  Widget _buildBalance() {
    return Text(
      amount.toPrice(symbol),
      style: const TextStyle(
          fontSize: 28.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: 1.0),
    ).animate();
  }

  Widget _buildMaskBalance(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (_) {
        return const Icon(
          Icons.emergency_rounded,
          color: Colors.white,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildBalance()
        .animate(target: isBalanceVisible ? 0 : 1)
        .blur()
        .crossfade(
          alignment: Alignment.centerLeft,
          duration: 1.seconds,
          builder: _buildMaskBalance,
        );
  }
}
