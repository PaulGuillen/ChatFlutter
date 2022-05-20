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
    return Container(
      margin: EdgeInsets.only(
          top: 100,
          bottom: MediaQuery.of(context).size.height * 0.15
      ),
      child: Image.asset(
        'assets/img/delivery.png',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Correo Electrónico',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
                Icons.email,
                color: MyColors.primaryColor
            )
        ),
      ),
    );
  }

  Widget _textFieldPassword(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
                Icons.lock,
                color: MyColors.primaryColor
            )
        ),
      ),
    );
  }

  Widget _buttonLogin(){
    return  Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Ingresar'),
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          shape : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          padding: const EdgeInsets.symmetric(vertical: 15)
        ),
      ),
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
              color:  MyColors.primaryColorDark
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


