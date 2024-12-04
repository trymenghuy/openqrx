import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/domain/model/user/user_input.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';
import 'package:openqrx/helper/service/store_service.dart';

class ProfileSetupForm extends MapForm {
  const ProfileSetupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.instance.user;
    final isEdit = user?.displayName != null;
    return GenericForm(
      appBar: AppBar(automaticallyImplyLeading: isEdit),
      input: UserInput.input,
      map: {'name': user?.displayName, 'imageUrl': user?.photoURL},
      farmLevel: false,
      onSubmit: (map) async {
        if (user == null) {
          return;
        }
        await user.updateDisplayName(map['name']);
        final imageUrl = map['imageUrl'];
        if (imageUrl != null) {
          await user.updatePhotoURL(map['imageUrl']);
        }
        await StoreService.instance
            .collection('User')
            .doc(user.uid)
            .set(map.clean());
        if (context.mounted) {
          isEdit
              ? Navigator.of(context).pop()
              : XNavigator.pushName(AppRoutes.home);
        }
      },
    );
  }
}
