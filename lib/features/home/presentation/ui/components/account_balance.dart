import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/double.dart';

enum BalanceDisplayStyle { normal, enlarge }

final _initialValueProvider = StateProvider<double>((_) => 0.0);

class AccountBalance extends ConsumerWidget {
  const AccountBalance({
    super.key,
    required this.amount,
    required this.isBalanceVisible,
    required this.symbol,
    this.onToggle,
    this.style = BalanceDisplayStyle.enlarge,
  });

  final double amount;
  final bool isBalanceVisible;
  final String symbol;
  final VoidCallback? onToggle;
  final BalanceDisplayStyle style;

  Widget _buildBalance() {
    return Text(
      amount.toPrice(symbol),
      style: const TextStyle(
        fontSize: 28.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        height: 1.0
      ),
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
        .animate(target: isBalanceVisible ? 1 : 0)
        .blur()
        .crossfade(
          alignment: Alignment.centerLeft,
          duration: 1.seconds,
          builder: _buildMaskBalance,
        );
    final initialValue = ref.watch(_initialValueProvider);
    final notifier = ref.read(_initialValueProvider.notifier);

    final iconButton = IconButton(
      onPressed: () {
        notifier.state = 0.0;
        onToggle?.call();
      },
      color: Colors.white,
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(
        isBalanceVisible
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
      ),
    );

    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 28.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                end: const Offset(0.0, 0.0),
                begin: const Offset(0.0, 0.2),
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: SizedBox(
          key: ValueKey<bool>(isBalanceVisible),
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (onToggle != null)
                IgnorePointer(
                  child: Opacity(
                    opacity: 0.0,
                    child: iconButton,
                  ),
                ),
              if (isBalanceVisible) ...<Widget>[
                if (style == BalanceDisplayStyle.normal)
                  Text(symbol)
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, right: 1.0),
                    child: Text(
                      symbol,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 1),
                  onEnd: () => notifier.state = amount,
                  tween: Tween<double>(begin: initialValue, end: amount),
                  builder: (_, double value, ___) => Text(value.integerPart),
                ),
                Text('.${amount.decimalPart}'),
                if (onToggle != null) iconButton,
              ] else ...[
                const SizedBox(width: 2.0),
                ...List.generate(5, (_) {
                  return const Icon(
                    Icons.emergency_rounded,
                    color: Colors.white,
                    size: 20.0,
                  );
                }),
                if (onToggle != null) iconButton,
              ]
            ],
          ),
        ),
      ),
    );
  }
}
