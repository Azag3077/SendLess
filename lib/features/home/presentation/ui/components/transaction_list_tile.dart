import 'package:flutter/material.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/extensions/double.dart';
import '../../../../../data/models/transaction.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile(this.transaction, {super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.type == TxnStatus.credit;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 3.0,
            spreadRadius: 3.0,
            color: Colors.grey.shade100,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {},
          leading: const CircleAvatar(),
          title: Text(transaction.name),
          titleTextStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black.withValues(alpha: .7),
          ),
          subtitle: Text(
              DateFormat('MMM dd, yyyy, hh:mm a').format(transaction.datetime)),
          subtitleTextStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.black.withValues(alpha: .6),
            fontWeight: FontWeight.w400,
          ),
          trailing: Text(
            '${isCredit ? '+' : '-'} '
            '${transaction.currency}'
            '${transaction.amount.toPriceInString}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }
}
