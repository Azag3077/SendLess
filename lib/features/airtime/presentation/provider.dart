import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final airtimePageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.amount = '',
    this.network,
    this.phoneNumber = '',
  });

  final String amount;
  final Network? network;
  final String phoneNumber;

  _State copyWith({
    String? amount,
    Network? network,
    String? phoneNumber,
  }) {
    return _State(
      amount: amount ?? this.amount,
      network: network ?? this.network,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  @override
  _State build() => const _State();

  void updatePhoneNumber(String value) =>
      state = state.copyWith(phoneNumber: value);

  void onSelectAmount(String value) => state = state.copyWith(amount: value);

  void onNetwork(Network network) => state = state.copyWith(network: network);

  void onConfirm(BuildContext context) {}
}

enum Network {
  mtn('MTN'),
  airtel('Airtel'),
  glo('GLO'),
  nineMobile('9Mobile');

  const Network(this.name);

  final String name;
}
