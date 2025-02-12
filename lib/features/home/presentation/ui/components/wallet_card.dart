import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../data/models/wallet.dart';
import 'account_balance.dart';

class WalletsContainer extends StatelessWidget {
  const WalletsContainer({
    super.key,
    required this.wallets,
    required this.onWallet,
    required this.onDownload,
    required this.onToggle,
    required this.balanceVisibility,
    required this.padding,
  });

  final List<Wallet> wallets;
  final VoidCallback onWallet;
  final VoidCallback onDownload;
  final VoidCallback onToggle;
  final bool balanceVisibility;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.0,
      child: SingleChildScrollView(
        padding: padding,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            ...List.generate(wallets.length, (index) {
              final wallet = wallets.elementAt(index);
              return MiniWalletCard(
                separate: index != 0,
                wallet: wallet,
                balanceVisibility: balanceVisibility,
                onToggle: onToggle,
              );
            }),
            const SizedBox(width: 16.0),
            IconButton.filledTonal(
              onPressed: () {},
              style: IconButton.styleFrom(
                iconSize: 32.0,
                padding: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    required this.text,
    required this.wallet,
    required this.onWallet,
    required this.onDownload,
    required this.onToggle,
    required this.balanceVisibility,
    required this.padding,
  });

  final String text;
  final Wallet wallet;
  final VoidCallback onWallet;
  final VoidCallback onDownload;
  final VoidCallback onToggle;
  final bool balanceVisibility;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: AssetImage(AssetImages.pngs.homeCardBg),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FilledButton(
                onPressed: onWallet,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0,
                  ),
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 8.0),
                    Text(
                      wallet.currency,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0,
                      ),
                    ),
                    const Icon(
                      Icons.expand_more,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 4.0),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDownload,
                icon: const Icon(Icons.file_download_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFD9D9D9),
                  foregroundColor: Theme.of(context).primaryColor,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.all(5.0),
                  minimumSize: Size.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .8),
              fontSize: 16.0,
            ),
          ),
          AccountBalance(
            symbol: wallet.symbol,
            amount: wallet.balance,
            isBalanceVisible: balanceVisibility,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}

final _initialValueProvider = StateProvider<double>((_) => 0.0);

class MiniWalletCard extends ConsumerWidget {
  const MiniWalletCard({
    super.key,
    required this.separate,
    required this.wallet,
    required this.balanceVisibility,
    required this.onToggle,
  });

  final bool separate;
  final Wallet wallet;
  final bool balanceVisibility;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(_initialValueProvider.notifier);

    final iconButton = IconButton(
      onPressed: () {
        notifier.state = 0.0;
        onToggle.call();
      },
      color: Colors.white,
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(
        balanceVisibility
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
      ),
    );

    return Container(
      width: 170.0,
      margin: EdgeInsetsDirectional.only(start: separate ? 12.0 : 0.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              opacity: .07,
              child: Image.asset(wallet.map),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(wallet.flag, width: 24.0),
                    iconButton,
                  ],
                ),
                const Spacer(),
                FittedBox(
                  child: AccountBalance(
                    symbol: wallet.symbol,
                    amount: wallet.balance,
                    isBalanceVisible: balanceVisibility,
                  ),
                ),
                Text(
                  wallet.currency,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
