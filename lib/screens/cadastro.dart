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
  Future<void> _mostrarAlertaCadastro(String mensagem) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Obriga o usuario a clicar no botao!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ERRO!',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                    child: Icon(
                      Icons.warning,
                      size: 60,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                  Text(
                    mensagem,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF0000)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _mostrarAlertaCadastroSucesso(String mensagem) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Obriga o usuario a clicar no botao!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sucesso!',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                    child: Icon(
                      Icons.done,
                      size: 60,
                      color: Color(0xFF00FF00),
                    ),
                  ),
                  Text(
                    mensagem,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00FF00)),
              ),
              onPressed: () {
                int i = 0;
                Navigator.of(context).popUntil((_) => i++ >= 2);
              },
            ),
          ],
        );
      },
    );
  }

  void cadastrarComEmailSenha(String email, String senha) async {
    
    try{    
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    ))
        .user;

        debugPrint('PASSOU EM TUDO.');
        _mostrarAlertaCadastroSucesso('Email cadastrado com sucesso.');
    }catch(e){
      if(e.toString() == "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)"){
      _mostrarAlertaCadastro('Email inválido! Por favor, informe um valor válido para email.');
      }
      else if (e.toString() == "PlatformException(error, Given String is empty or null, null)"){
        _mostrarAlertaCadastro('Valores em branco. Por favor, informe valores validos para todos os campos.');
      }
      else if (e.toString() == "PlatformException(ERROR_WEAK_PASSWORD, The given password is invalid. [ Password should be at least 6 characters ], null)"){
        _mostrarAlertaCadastro('Senha inválida! Por favor informe uma senha com no mínimo 6 caracteres.');
      }
      else if (e.toString() == "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)"){
        _mostrarAlertaCadastro('Email já cadastrado! Por favor informe outro email ou faça login.');
      }
      else{
        _mostrarAlertaCadastro(e.toString());
      }
    }

   
      _mostrarAlertaCadastroSucesso('Email cadastrado com sucesso.');
      Navigator.of(context).pop();
    
    
    
  }
}
