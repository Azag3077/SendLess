import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final cardPageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.activated = false,
    this.visibility = true,
    this.virtualCard,
  });

  final bool activated;
  final bool visibility;
  final VirtualCard? virtualCard;

  _State copyWith({
    bool? activated,
    bool? visibility,
    VirtualCard? virtualCard,
  }) {
    return _State(
      activated: activated ?? this.activated,
      visibility: visibility ?? this.visibility,
      virtualCard: virtualCard ?? this.virtualCard,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() => const _State();

  void onCallToActionButton(BuildContext context) {
    if (!state.activated) return _activateCard();

    state = state.copyWith(visibility: !state.visibility);
  }

  void _activateCard() {
    final virtualCard = VirtualCard(
      number: 1234567890,
      expiryDate: DateTime.now(),
      cvv: 365,
      name: 'Dummy User',
      type: 'Visa',
    );

    state = state.copyWith(activated: true, virtualCard: virtualCard);
  }

  void onCopy(BuildContext context, String text, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$text copied to clipboard!')),
    );
  }
}

class VirtualCard {
  const VirtualCard({
    required this.number,
    required this.expiryDate,
    required this.cvv,
    required this.name,
    required this.type,
  });

  final int number;
  final DateTime expiryDate;
  final int cvv;
  final String name;
  final String type;
}
