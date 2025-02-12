import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/enums.dart';
import '../provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profilePageProvider);
    final notifier = ref.read(profilePageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(radius: 30.0),
            const SizedBox(height: 8.0),
            Text(
              state.userProfile!.fullname,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withValues(alpha: .71),
              ),
            ),
            GestureDetector(
              onTap: () => notifier.onCopy(context, '@Dummy_user', 'azag'),
              child: Text(
                '@Dummy_user',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: .71),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            _buildListTile(
              context: context,
              title: 'Full Name',
              subtitle: state.userProfile!.fullname,
              onPressed: () =>
                  notifier.updateProfileInfo(context, ProfileField.fullname),
              trailingIcon: Icons.edit_note,
            ),
            _buildListTile(
              context: context,
              title: 'Phone Number',
              subtitle: state.userProfile!.phoneNumber,
              onPressed: () =>
                  notifier.updateProfileInfo(context, ProfileField.phoneNumber),
              trailingIcon: Icons.edit_note,
            ),
            _buildListTile(
              context: context,
              title: 'Email',
              subtitle: state.userProfile!.email,
              onPressed: () =>
                  notifier.updateProfileInfo(context, ProfileField.email),
              trailingIcon: Icons.edit_note,
            ),
            _buildListTile(
              context: context,
              title: 'Gender',
              subtitle: state.userProfile!.gender.trKey.tr(),
              // onPressed: () => notifier.updateProfileInfo(context, ProfileField.gender),
              trailingIcon: Icons.edit_note,
            ),
            _buildListTile(
              context: context,
              title: 'Settings',
              subtitle: 'control your notification and security settings',
              onPressed: () => notifier.onSettings(context),
            ),
            _buildListTile(
              context: context,
              title: 'Get help',
              subtitle: 'Get support or send feedback',
              onPressed: () {},
            ),
            _buildSocialListTile(
              text: 'Follow on Instagram',
              assetName: AssetImages.svgs.instagram,
              onPressed: () {},
            ),
            _buildSocialListTile(
              text: 'Follow on youtube',
              assetName: AssetImages.svgs.youtube,
              onPressed: () {},
            ),
            _buildSocialListTile(
              text: 'Follow on X',
              assetName: AssetImages.svgs.x,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    VoidCallback? onPressed,
    IconData? trailingIcon,
  }) {
    return ListTile(
      onTap: onPressed,
      title: Text(title),
      subtitle: Text(subtitle),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      subtitleTextStyle: Theme.of(context).textTheme.bodyLarge,
      trailing: trailingIcon == null ? null : Icon(trailingIcon),
    );
  }

  Widget _buildSocialListTile({
    required String text,
    required String assetName,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: onPressed,
            leading: SvgPicture.asset(assetName),
            title: Text(text),
            titleTextStyle: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFF5E5E5E),
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 40.0),
            child: Divider(height: 2.0),
          ),
        ],
      ),
    );
  }
}
