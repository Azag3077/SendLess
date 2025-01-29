import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/enums.dart';
import '../../../../data/models/transaction.dart';
import '../provider.dart';
import 'components/app_bar.dart';
import 'components/page_indicator.dart';
import 'components/quick_action_cards.dart';
import 'components/swiper.dart';
import 'components/tab.dart';
import 'components/transaction_list_tile.dart';
import 'components/wallet_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _txnController = PageController();

  @override
  void initState() {
    ref.read(homePageProvider.notifier).initialize(_txnController);
    super.initState();
  }

  @override
  void dispose() {
    _txnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageProvider);
    final notifier = ref.read(homePageProvider.notifier);

    const pagePadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      appBar: HomeAppBar(
        title: 'Hi Azag 👋🏿',
        addMoneyText: 'Add money',
        onProfile: () => notifier.onProfile(context),
        onAddMoney: () => notifier.onAddMoney(context),
        onBellIcon: () => notifier.onAddMoney(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16.0),
            Padding(
              padding: pagePadding,
              child: Column(
                children: <Widget>[
                  WalletCard(
                    text: 'Account Balance',
                    wallet: state.wallet!,
                    onWallet: () => notifier.onWallet(context),
                    onDownload: () => notifier.onDownload(context),
                    onToggle: notifier.toggleBalanceVisibility,
                    balanceVisibility: state.balanceVisibility,
                  ),
                  const SizedBox(height: 16.0),
                  QuickActionRow(
                    children: <QuickAction>[
                      QuickAction(
                        iconPath: AssetImages.svgs.send,
                        text: 'Send',
                        onPressed: () => notifier.onSend(context),
                      ),
                      QuickAction(
                        text: 'Convert',
                        iconPath: AssetImages.svgs.arrowLeftRight,
                        onPressed: () => notifier.onConvert(context),
                      ),
                      QuickAction(
                        text: 'Transfer',
                        iconPath: AssetImages.svgs.arrowUpRight,
                        onPressed: () => notifier.onTransfer(context),
                      ),
                      QuickAction(
                        text: 'Cash Out',
                        iconPath: AssetImages.svgs.briefCase,
                        onPressed: () => notifier.onCashOut(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const SwiperView(),
            const SizedBox(height: 16.0),
            Padding(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Recent Transaction'),
                      TextButton(
                        onPressed: () => notifier.onSeeAllTransactions(context),
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  Row(
                    children: <CustomTab>[
                      CustomTab(
                        text: TxnStatus.all.trKey.tr(),
                        selected: state.txnTabIndex == 0,
                        onTab: () => notifier.onTxnTab(0),
                      ),
                      CustomTab(
                        text: TxnStatus.credit.trKey.tr(),
                        selected: state.txnTabIndex == 1,
                        onTab: () => notifier.onTxnTab(1),
                      ),
                      CustomTab(
                        text: TxnStatus.debit.trKey.tr(),
                        selected: state.txnTabIndex == 2,
                        onTab: () => notifier.onTxnTab(2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400.0,
              child: PageView.builder(
                controller: _txnController,
                itemCount: TxnStatus.values.length,
                onPageChanged: notifier.onPageChanged,
                itemBuilder: (_, int index) {
                  final status = TxnStatus.values.elementAt(index);
                  final transactions = _transactions
                      .where((txn) => index == 0 || txn.type == status);
                  return PageViewContent(transactions.toList());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: TBR
final _transactions = <Transaction>[
  Transaction(
    name: 'John Fonseca',
    currency: r'$',
    amount: 1800400,
    type: TxnStatus.credit,
    datetime: DateTime.now(),
  ),
  Transaction(
    name: 'John Cena',
    currency: r'$',
    amount: 800400,
    type: TxnStatus.credit,
    datetime: DateTime.now(),
  ),
  Transaction(
    name: 'MTN Airtime Top-up',
    currency: '₦',
    amount: 2500,
    type: TxnStatus.debit,
    datetime: DateTime.now(),
  ),
  Transaction(
    name: 'Victor Isaac',
    currency: '₦',
    amount: 800000,
    type: TxnStatus.debit,
    datetime: DateTime.now(),
  ),
  Transaction(
    name: 'Wisdom King',
    currency: '₦',
    amount: 12000,
    type: TxnStatus.credit,
    datetime: DateTime.now(),
  ),
  Transaction(
    name: 'Eko Electricity',
    currency: '₦',
    amount: 5000,
    type: TxnStatus.debit,
    datetime: DateTime.now(),
  ),
];

class PageViewContent extends StatelessWidget {
  const PageViewContent(this.transactions, {super.key});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: transactions.length,
      padding: const EdgeInsets.all(16.0),
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactions.elementAt(index);

        return TransactionListTile(transaction);
      },
    );
  }
}
