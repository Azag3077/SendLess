import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/bottom_sheet.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/texts.dart';
import '../../../core/routers/app_routes.dart';
import '../../virtual_account_selection/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final verifyPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  _State({
    this.idType,
  });

  final IdType? idType;

  _State copyWith({
    IdType? idType,
  }) {
    return _State(
      idType: idType ?? this.idType,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  final _pageText = AppTexts.verifyPage;

  @override
  _State build() => _State();

  Future<IdType?> showIdTypeBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return CustomBottomSheet<IdType>(
          title: _pageText.idType.tr(),
          items: IdType.values,
          onSelected: (value) => state = state.copyWith(idType: value),
          isLoading: false,
          selected: state.idType,
          buildText: (e) => e.trKey.tr(),
        );
      },
    );

    return state.idType;
  }

  void onVerify(BuildContext context) =>
      pushNamed(context, VirtualAccountSelectionPage.routeName);
}
