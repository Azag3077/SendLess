import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/double.dart';
import '../../../../../core/extensions/num_duration.dart';

enum BalanceDisplayStyle { normal, enlarge }

final _initialValueProvider = StateProvider<double>((_) => 0.0);

class AccountBalance extends ConsumerWidget {
  const AccountBalance({
    super.key,
    required this.amount,
    required this.isBalanceVisible,
    required this.currency,
    required this.onToggle,
    this.style = BalanceDisplayStyle.enlarge,
  });

  final double amount;
  final bool isBalanceVisible;
  final String currency;
  final VoidCallback onToggle;
  final BalanceDisplayStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialValue = ref.watch(_initialValueProvider);
    final notifier = ref.read(_initialValueProvider.notifier);

    final iconButton = IconButton(
      onPressed: () {
        notifier.state = 0.0;
        onToggle();
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
        fontSize: 24.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedSwitcher(
        duration: 500.ms,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          key: ValueKey<bool>(isBalanceVisible),
          children: <Widget>[
            IgnorePointer(
              child: Opacity(
                opacity: 0.0,
                child: iconButton,
              ),
            ),
            if (isBalanceVisible) ...<Widget>[
              if (style == BalanceDisplayStyle.normal)
                Text(currency)
              else
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                  child: Text(
                    currency,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              TweenAnimationBuilder(
                duration: 1.seconds,
                onEnd: () => notifier.state = amount,
                tween: Tween<double>(begin: initialValue, end: amount),
                builder: (_, double value, ___) => Text(value.integerPart),
              ),
              Text('.${amount.decimalPart}'),
              iconButton,
            ] else
              ...[
                const SizedBox(width: 2.0),
                ...List.generate(5, (_) {
                  return const Icon(
                    Icons.emergency_rounded,
                    color: Colors.white,
                    size: 20.0,
                  );
                }),
                iconButton,
              ]
          ],
        ),
      ),
    );
  }
}
