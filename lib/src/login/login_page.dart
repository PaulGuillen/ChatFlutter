import 'package:chat_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

class  LoginPage extends StatefulWidget {
  const  LoginPage({Key? key}) : super(key: key);

  @override
  State< LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State< LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Evitar el redimensionamietno de la app - es malo
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        title: Text('Flutter'),
      ),
      body: SizedBox(

        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/img/delivery.png',
            width: 200,
            height: 200,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Correo Electrónico'
            ),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Contraseña'
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Ingresar'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No tienes cuenta?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  MyColors.primaryColor
                ),
              ),
              SizedBox(width: 7),
              Text(
                'Registrate',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:  MyColors.primaryColor
                ),
              ),
            ],
          )
        ],
        ),
      )
    );
  }
}


