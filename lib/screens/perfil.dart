import 'package:flutter/material.dart';

//TITULOS
const String _tituloAppBar = 'Perfil';

const String _labelNome = 'Nome:';
const String _nome = 'Gabriel Rosim';
const String _labelEmail = 'Email:';
const String _email = 'gabriel@exemplo.com';

//CORES
const Color _corFundoPerfil = Color(0xff320b86);
const Color _corFundoFoto = Color(0xff651fff);

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.mode_edit),
            onPressed: () {},
          ),
        ],
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(color: _corFundoPerfil),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      (MediaQuery.of(context).size.width / 2) - 64, 30, 0, 0),
                  alignment: Alignment.center,
                  height: 128,
                  width: 128,
                  decoration: BoxDecoration(
                    color: _corFundoFoto,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'G',
                    style: TextStyle(color: Color(0xffdddddd), fontSize: 40),
                  ),
                ),
              ],
            ),
            DadoPerfil(
              icone: Icon(Icons.account_box),
              titulo: _labelNome,
              subtitulo: _nome,
            ),
            DadoPerfil(
              icone: Icon(Icons.mail),
              titulo: _labelEmail,
              subtitulo: _email,
            ),
          ],
        ),
      ),
    );
  }
}

class DadoPerfil extends StatelessWidget {
  final Icon icone;
  final String titulo;
  final String subtitulo;

  const DadoPerfil({Key key, this.icone, this.titulo, this.subtitulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: icone,
          title: Text(titulo),
          subtitle: Text(subtitulo),
        ),
      ),
    );
  }
}
