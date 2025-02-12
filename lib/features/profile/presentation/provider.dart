import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/buttons.dart';
import '../../../components/textfields.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../core/routers/app_routes.dart';
import '../../settings/presentation/ui/page.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  const UserProfile({
    required this.fullname,
    required this.phoneNumber,
    required this.email,
    required this.gender,
  });

  final String fullname;
  final String phoneNumber;
  final String email;
  final Gender gender;

  UserProfile copyWith({
    String? fullname,
    String? phoneNumber,
    String? email,
    Gender? gender,
  }) {
    return UserProfile(
      fullname: fullname ?? this.fullname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
    );
  }
}

enum ProfileField { fullname, phoneNumber, email, gender }

final profilePageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.activated = false,
    this.visibility = true,
    this.virtualCard,
    this.userProfile,
  });

  final bool activated;
  final bool visibility;
  final VirtualCard? virtualCard;
  final UserProfile? userProfile;

  _State copyWith({
    bool? activated,
    bool? visibility,
    VirtualCard? virtualCard,
    UserProfile? userProfile,
  }) {
    return _State(
      activated: activated ?? this.activated,
      visibility: visibility ?? this.visibility,
      virtualCard: virtualCard ?? this.virtualCard,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() {
    return const _State(
      userProfile: UserProfile(
        fullname: 'Dummy User',
        phoneNumber: '08123456789',
        email: 'dummy@gmail.com',
        gender: Gender.female,
      ),
    );
  }

  Future<void> updateProfileInfo(
      BuildContext context, ProfileField field) async {
    late final String label;
    late final String text;
    late final TextInputType keyboardType;

    switch (field) {
      case ProfileField.fullname:
        label = 'Fullname';
        text = state.userProfile!.fullname;
        keyboardType = TextInputType.name;
      case ProfileField.phoneNumber:
        label = 'Phone number';
        text = state.userProfile!.phoneNumber;
        keyboardType = TextInputType.phone;
      case ProfileField.email:
        label = 'Email';
        text = state.userProfile!.email;
        keyboardType = TextInputType.emailAddress;
      case ProfileField.gender:
        label = 'Gender';
        text = state.userProfile!.gender.trKey.tr();
    }

    final controller = TextEditingController(text: text);

    final result = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Azag(
          label: label,
          controller: controller,
          keyboardType: keyboardType,
        );
      },
    );

    Future.delayed(400.ms, controller.dispose);

    if (result != null) {
      late final UserProfile userProfile;
      switch (field) {
        case ProfileField.fullname:
          userProfile = state.userProfile!.copyWith(fullname: result);
        case ProfileField.phoneNumber:
          userProfile = state.userProfile!.copyWith(phoneNumber: result);
        case ProfileField.email:
          userProfile = state.userProfile!.copyWith(email: result);
        case ProfileField.gender:
      }
      state = state.copyWith(userProfile: userProfile);
    }
  }

  void onSettings(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onCopy(BuildContext context, String text, String value) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
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

class Azag extends StatelessWidget {
  const Azag({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
  });

  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                CloseButton(onPressed: () => pop(context)),
                Expanded(
                  child: Center(
                    child: Text(
                      'Change $label',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 40.0),
              ],
            ),
            const SizedBox(height: 16.0),
            SignupTextField(
              controller: controller,
              keyboardType: keyboardType,
              suffixIconConstraints: const BoxConstraints(),
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Text('Edit'),
              ),
            ),
            const SizedBox(height: 16.0),
            CustomFilledButton(
              text: 'Update',
              onPressed: () => pop(context, controller.text),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
