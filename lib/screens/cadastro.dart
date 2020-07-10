//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdm_av1/screens/home.dart';
import 'package:pdm_av1/screens/login.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController controladorEmailCD = new TextEditingController();
  TextEditingController controladorPassCD = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Color(0xFF333333),
          child: Column(
            children: [
              CampoFormulario(
                iconeCampo: Icon(
                  Icons.mail,
                  color: corListaIcone,
                ),
                labelCampo: 'Email:',
                dicaCampo: 'Informe o seu email.',
                controlador: controladorEmailCD,
              ),
              CampoFormulario(
                iconeCampo: Icon(
                  Icons.vpn_key,
                  color: corListaIcone,
                ),
                labelCampo: 'Senha:',
                dicaCampo: 'Informe a sua senha.',
                controlador: controladorPassCD,
              ),
              RaisedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                cadastrarComEmailSenha(controladorEmailCD.text,controladorPassCD.text);
              }),
              
            ],
          ),
        ),
      ),
    );
  }

  void cadastrarComEmailSenha(String email, String senha) async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    ))
        .user;
  }
}
