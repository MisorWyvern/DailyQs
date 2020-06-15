import 'package:flutter/material.dart';

//Trocar CORES
const Color _corDoFundo = Color(0xFF673ab7);
const Color _corDoBotaoEntra = Color(0xFF651fff);
const Color _corDoTextoBase = Color(0xFFffffff);

//Trocar Textos
const String _tituloLogin = "Organize. Crie. Produza.";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo[50],
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.2),
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
                dicaCampo: 'Informe o usuario.',
                labelCampo: 'Usuario',
                iconeCampo: Icon(Icons.account_box, color: _corDoTextoBase),
              ),
              CampoFormulario(
                
                dicaCampo: 'Informe a senha.',
                labelCampo: 'Senha',
                iconeCampo: Icon(Icons.lock, color: _corDoTextoBase),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(bottom: 0),
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    color: _corDoTextoBase,
                    fontSize: 9,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
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
}

class CampoFormulario extends StatelessWidget {
  final Icon iconeCampo;
  final String labelCampo;
  final String dicaCampo;
 

  const CampoFormulario({this.iconeCampo, this.labelCampo, this.dicaCampo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
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
          hintStyle: TextStyle(color: Color(0xFFb085f5),),
        ),
      ),
    );
  }
}