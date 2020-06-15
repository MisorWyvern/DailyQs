import 'package:flutter/material.dart';

//TITULOS
const String _tituloAppBar = 'Ajuda';

class Ajuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(
            'Essa tela está destinada a ser um guia para o usuário e será feita quando o aplicativo estiver completo.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
