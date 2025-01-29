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
