import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/assets.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../data/models/wallet.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.balanceVisibility = true,
    this.pageIndex = 0,
    this.wallets = const [],
    this.txnTabIndex = 0,
  });

  final bool balanceVisibility;
  final int pageIndex;
  final List<Wallet> wallets;
  final int txnTabIndex;

  _State copyWith({
    bool? balanceVisibility,
    int? pageIndex,
    List<Wallet>? wallets,
    int? txnTabIndex,
  }) {
    return _State(
      balanceVisibility: balanceVisibility ?? this.balanceVisibility,
      pageIndex: pageIndex ?? this.pageIndex,
      wallets: wallets ?? this.wallets,
      txnTabIndex: txnTabIndex ?? this.txnTabIndex,
    );
  }
}

class _Notifier extends Notifier<_State> {
  PageController? _txnController;
  bool _isBtnClick = false;

  @override
  _State build() {
    ref.onDispose(_onDispose);
    return _State(
      wallets: <Wallet>[
        Wallet(
          currency: 'United State Dollar',
          symbol: r'$',
          flag: AssetImages.pngs.usaFlag,
          map: AssetImages.pngs.usaMap,
          balance: 580440231.30,
        ),
        Wallet(
          currency: 'Nigerian Naira',
          symbol: '₦',
          flag: AssetImages.pngs.nigeriaFlag,
          map: AssetImages.pngs.nigeriaMap,
          balance: 14000.00,
        ),
        Wallet(
          currency: 'Canadian Dollar',
          symbol: r'$',
          flag: AssetImages.pngs.canadaFlag,
          map: AssetImages.pngs.canadaMap,
          balance: 0.00,
        ),
      ],
    );
  }

  void initialize(PageController txnController) =>
      _txnController = txnController;

  void _onDispose() {}

  void updatePageIndex(int value) => state = state.copyWith(pageIndex: value);

  void onProfile(BuildContext context) {}

  void onAddMoney(BuildContext context) {}

  void onBellIcon(BuildContext context) {}

  void onWallet(BuildContext context) {}

  void onDownload(BuildContext context) {}

  void toggleBalanceVisibility() =>
      state = state.copyWith(balanceVisibility: !state.balanceVisibility);

  void onSend(BuildContext context) {}

  void onConvert(BuildContext context) {}

  void onTransfer(BuildContext context) {}

  void onCashOut(BuildContext context) {}

  void onSeeAllTransactions(BuildContext context) {}

  Future<void> onTxnTab(int index) async {
    if (state.txnTabIndex == index) return;

    state = state.copyWith(txnTabIndex: index);
    _isBtnClick = true;
    await _txnController?.animateToPage(index,
        duration: 300.ms, curve: Curves.linear);
    _isBtnClick = false;
  }

  void onPageChanged(int index) {
    if (_isBtnClick) return;
    state = state.copyWith(txnTabIndex: index);
  }
}
