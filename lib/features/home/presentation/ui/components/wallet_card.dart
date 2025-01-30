import 'package:flutter/material.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../data/models/wallet.dart';
import 'account_balance.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    required this.text,
    required this.wallet,
    required this.onWallet,
    required this.onDownload,
    required this.onToggle,
    required this.balanceVisibility,
  });

  final String text;
  final Wallet wallet;
  final VoidCallback onWallet;
  final VoidCallback onDownload;
  final VoidCallback onToggle;
  final bool balanceVisibility;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(4, (index) {
            return AzagA(
              separate: index != 0,
              wallet: wallet,
              // balanceVisibility: balanceVisibility,
              balanceVisibility: true,
              onToggle: onToggle,
            );
          }),
        ),
      ),
    );
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
            currency: wallet.symbol,
            amount: wallet.balance,
            isBalanceVisible: balanceVisibility,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}

class AzagA extends StatelessWidget {
  const AzagA({
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
  Widget build(BuildContext context) {
    return Container(
      width: 170.0,
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsetsDirectional.only(start: separate ? 8.0 : 0.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.flag),
            const Spacer(),
            FittedBox(
              child: AccountBalance(
                currency: wallet.symbol,
                amount: wallet.balance,
                isBalanceVisible: balanceVisibility,
                // onToggle: onToggle,
              ),
            ),
            const SizedBox(height: 4.0),
            const Text('Nigeria Naira'),
          ],
        ),
      ),
    );
  }
}
