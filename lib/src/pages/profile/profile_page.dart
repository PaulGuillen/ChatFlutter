
import 'package:chat_flutter/src/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  ProfileController con = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => con.signOut(),
            child: Icon(Icons.edit),
            backgroundColor: Colors.lightBlueAccent,
          ),
          FloatingActionButton(
            onPressed: () => con.signOut(),
            child: Icon(Icons.power_settings_new),
            backgroundColor: Colors.green,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              circleImageUser(),
              SizedBox(height: 20),
              userInfo(
                  'Nombre del usuario',
                  '${con.user.name ?? ''} ${con.user.lastname ?? ''}',
                  Icons.person
              ),
              userInfo(
                  'Email',
                  con.user.email ?? '',
                  Icons.email
              ),
              userInfo(
                  'Telefono',
                  con.user.phone ?? '',
                  Icons.phone
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInfo(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }

  Widget circleImageUser() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 220,
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/img/user_profile_2.png',
                image: con.user.image ?? 'https://i.pinimg.com/originals/d2/ea/d8/d2ead876ae76ba7147f68e7d2417c5f3.png'
            ),
          ),
        ),
      ),
    );
  }

}


