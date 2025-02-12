import 'package:flutter/material.dart';

import '../provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  ListTile _buildListTile({
    required BuildContext context,
    required String title,
    required VoidCallback onPressed,
    Widget? trailing,
    Color? titleColor,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onPressed,
      title: Text(title),
      titleTextStyle: textTheme.titleMedium?.copyWith(color: titleColor),
      trailing: trailing,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildSwitch(bool value) {
    return IgnorePointer(
      child: Switch(value: value, onChanged: (_) {}),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsPageProvider);
    final notifier = ref.read(settingsPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _buildListTile(
              context: context,
              title: 'Change Password',
              trailing: const Icon(Icons.chevron_right),
              onPressed: () => notifier.onChangePassword(context),
            ),
            _buildListTile(
              context: context,
              title: 'Change PIN',
              trailing: const Icon(Icons.chevron_right),
              onPressed: () => notifier.onChangePIN(context),
            ),
            _buildListTile(
              context: context,
              title: 'About',
              onPressed: () => notifier.onAbout(context),
            ),
            _buildListTile(
              context: context,
              title: 'Dark Mode',
              trailing: _buildSwitch(state.darkMode),
              onPressed: notifier.toggleDarkMode,
            ),
            _buildListTile(
              context: context,
              title: 'General Notification',
              trailing: _buildSwitch(state.notification),
              onPressed: notifier.toggleNotification,
            ),
            _buildListTile(
              context: context,
              title: 'App Updates',
              trailing: _buildSwitch(state.appUpdater),
              onPressed: notifier.toggleAppUpdater,
            ),
            _buildListTile(
              context: context,
              title: 'Delete Account',
              titleColor: Colors.red,
              onPressed: () => notifier.onDelete(context),
            ),
            _buildListTile(
              context: context,
              title: 'Log Out',
              titleColor: Theme.of(context).primaryColor,
              onPressed: () => notifier.onLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
