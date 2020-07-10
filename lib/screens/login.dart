import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//Trocar CORES
const Color _corDoFundo = Color(0xFF673ab7);
const Color _corDoBotaoEntra = Color(0xFF651fff);
const Color _corDoTextoBase = Color(0xFFffffff);

//Trocar Textos
const String _tituloLogin = "Organize. Crie. Produza.";
final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controladorEmail = new TextEditingController();
  TextEditingController controladorPass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo[50],
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height * 0.2),
          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.075,
              0, MediaQuery.of(context).size.width * 0.075, 0),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: _corDoFundo,
            //border: Border.all(width: 1, color: Colors.black54),
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                blurRadius: 5.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  3, // Move to right horizontally
                  3, // Move to bottom Vertically
                ),
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  _tituloLogin,
                  style: TextStyle(
                    color: _corDoTextoBase,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              CampoFormulario(
                dicaCampo: 'Informe o email.',
                labelCampo: 'Email',
                iconeCampo: Icon(Icons.account_box, color: _corDoTextoBase),
                controlador: controladorEmail,
              ),
              CampoFormulario(
                dicaCampo: 'Informe a senha.',
                labelCampo: 'Senha',
                iconeCampo: Icon(Icons.lock, color: _corDoTextoBase),
                controlador: controladorPass,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Cadastrar-se',
                        style: TextStyle(fontSize: 9, color: _corDoTextoBase,),
                        recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/login/cadastro'),
                      ),
                    ),
                    Expanded(child: Container(child: null)),
                    Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: _corDoTextoBase,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        logarComEmailSenha(controladorEmail.text, controladorPass.text);
                      },
                      color: _corDoBotaoEntra,
                      textColor: Colors.white,
                      child: Text('Entrar',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
  
  void logarComEmailSenha(String email, String senha) async {
    try{
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    ))
        .user;

        
          _mostrarAlertaLoginSucesso('Bem-Vindo!');
    }catch(a){
      debugPrint(a.toString());
      _mostrarAlertaLogin('Email ou senha inválidos. Por favor, informe valores válidos.');
    }    
          
        
  }

  Future<void> _mostrarAlertaLogin(String mensagem) async {
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

  Future<void> _mostrarAlertaLoginSucesso(String mensagem) async {
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
                Navigator.pushNamed(context, '/home');
              },
            ),
          ],
        );
      },
    );
  }

}

class CampoFormulario extends StatelessWidget {
  final Icon iconeCampo;
  final String labelCampo;
  final String dicaCampo;
  final TextEditingController controlador;

  const CampoFormulario({this.iconeCampo, this.labelCampo, this.dicaCampo, this.controlador});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controlador,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          //isDense: true,
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.all(15.0),
          prefixIcon: iconeCampo != null ? iconeCampo : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(8)),
            borderSide: BorderSide(color: Color(0xFFb085f5), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(8)),
            borderSide: BorderSide(color: _corDoTextoBase, width: 1),
          ),
          labelText: labelCampo,
          labelStyle: TextStyle(color: _corDoTextoBase),
          hintText: dicaCampo,
          hintStyle: TextStyle(
            color: Color(0xFFb085f5),
          ),
        ),
      ),
    );
  }
  
  

}
