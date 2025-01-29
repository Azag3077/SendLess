import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/num_duration.dart';
import '../../../data/models/wallet.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.balanceVisibility = true,
    this.pageIndex = 0,
    this.wallet,
    this.txnTabIndex = 0,
  });

  final bool balanceVisibility;
  final int pageIndex;
  final Wallet? wallet;
  final int txnTabIndex;

  _State copyWith({
    bool? balanceVisibility,
    int? pageIndex,
    Wallet? wallet,
    int? txnTabIndex,
  }) {
    return _State(
      balanceVisibility: balanceVisibility ?? this.balanceVisibility,
      pageIndex: pageIndex ?? this.pageIndex,
      wallet: wallet ?? this.wallet,
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
      wallet: Wallet(
        currency: 'United State Dollar',
        symbol: r'$',
        flag: '',
        balance: 2580440.30,
      ),
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
