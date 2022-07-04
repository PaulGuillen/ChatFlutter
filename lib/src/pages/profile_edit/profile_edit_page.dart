import 'package:chat_flutter/src/pages/profile_edit/profile_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditPage  extends StatelessWidget {

  ProfileEditController con = Get.put(ProfileEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile edit'),
      ),
    );
  }
}
