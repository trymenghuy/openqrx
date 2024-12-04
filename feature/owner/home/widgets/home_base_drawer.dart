import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/owner/home/widgets/drawer_tile.dart';
import 'package:openqrx/feature/shared/widgets/switch/switch_font.dart';
import 'package:openqrx/feature/shared/widgets/switch/switch_language.dart';
import 'package:openqrx/feature/shared/widgets/switch/switch_mode.dart';
import 'package:openqrx/helper/img_helper.dart';
import 'package:provider/provider.dart';

class HomeBaseDrawer extends StatelessWidget {
  final List<Widget>? children;
  const HomeBaseDrawer({super.key, this.children});

  @override
  Widget build(BuildContext context) {
    const divider = Divider(height: 16);
    return Consumer2<SettingProvider, UserProvider>(
        builder: (context, setting, provider, __) {
      final user = provider.user;
      // final defaultFarm = provider.defaultFarm;
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImgHelper.avatar(user?.photoURL, radius: 36),
                        IconButton(
                            onPressed: () {
                              XNavigator.pushName(AppRoutes.profileSetup);
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                  space10,
                  Text(
                    '${(user?.displayName).orEmpty} - ${provider.role.name}',
                    style: xStyle.titleMedium,
                  ),
                  Text(
                    provider.phone.orEmpty,
                    style: xStyle.bodyMedium,
                  ),
                ],
              ),
            ),
            if (children.orIsNotEmpty) ...[...children!, divider],
            DrawerTile(
                text: 'Mode',
                svg: const Icon(Icons.dark_mode),
                onTap: () {
                  SwitchMode.pop(setting);
                }),
            DrawerTile(
                text: txt.chooseLanguage,
                svg: const Icon(Icons.translate),
                onTap: () {
                  SwitchLanguage.pop(setting);
                }),
            DrawerTile(
                text: 'Font size',
                svg: const Icon(Icons.font_download_sharp),
                onTap: () {
                  SwitchFont.pop(setting);
                }),
            divider,
            DrawerTile(
                text: 'Logout',
                svg: const Icon(Icons.logout),
                onTap: () {
                  button.confirm(
                      title: txt.logout_btn_txt,
                      subTitle: txt.logout_msg_title,
                      onNext: () {
                        UserProvider.instance.logout();
                      });
                }),
            // DrawerTile(
            //     text: 'Refresh Auth',
            //     svg: SvgIcons.xLogout2BoldDuotone,
            //     onTap: () {
            //       UserProvider.instance.getRole(forceRefresh: true);
            //     })
          ],
        ),
      );
    });
  }
}
