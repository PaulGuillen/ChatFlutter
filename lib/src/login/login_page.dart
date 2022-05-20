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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _imageBanner(),
          _textFieldEmail(),
          _textFieldPassword(),
          _buttonLogin(),
          _textDonHaveAccount()
        ],
        ),
      )
    );
  }

  Widget _imageBanner(){
    return Image.asset(
      'assets/img/delivery.png',
      width: 200,
      height: 200,
    );
  }

  Widget _textFieldEmail(){
    return const TextField(
      decoration: InputDecoration(
          hintText: 'Correo Electrónico'
      ),
    );
  }

  Widget _textFieldPassword(){
    return const TextField(
      decoration: InputDecoration(
          hintText: 'Contraseña'
      ),
    );
  }

  Widget _buttonLogin(){
    return  ElevatedButton(
      onPressed: () {},
      child: const Text('Ingresar'),
    );
  }

  Widget _textDonHaveAccount(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta?',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color:  MyColors.primaryColor
          ),
        ),
        const SizedBox(width: 7),
        Text(
          'Registrate',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color:  MyColors.primaryColor
          ),
        ),
      ],
    );
  }

}


