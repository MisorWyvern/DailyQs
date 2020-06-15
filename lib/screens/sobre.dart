import 'package:flutter/material.dart';

//CORES

//TITULOS
const String _tituloAppBar = 'Sobre';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10,10,5,10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.white),
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
                  width: 128,
                  child: Image.asset('assets/images/portrait_loki.png'),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                  width: MediaQuery.of(context).size.width - 143,
                  child: Text(
                      'Obrigado por utilizar esse aplicativo.\nMeu nome é Gabriel Rosim e sou seu único desenvolvedor.',
                      style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.justify,),
                ),
              ],
            ),
            Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  
                  child: Text(
                      'Nessa página você poderá ler algumas informações sobre o aplicativo.',
                      style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.justify,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: Text(
                      'Tema:',
                      style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.left,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: Text(
                      'O tema escolhido foi desenvolver um aplicativo do tipo "To-Do List".',
                      style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.justify,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: Text(
                      'Objetivo:',
                      style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.left,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: Text(
                      'O objetivo geral é fazer uma lista de tarefas (apelidadas de "Quests" no aplicativo) que consiga renovar automaticamente todo dia, semana ou mês de acordo com a vontade de usuário.',
                      style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.justify,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: Text(
                      'Créditos:',
                      style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.left,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                      'Icone do app foi criado editando um icone feito pela Freepik do site www.flaticon.com',
                      style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.justify,),
                ),
          ],
        ),
      ), //Text('Icone foi editado utilizando um icone feito pela Freepik do site www.flaticon.com'),
    );
  }
}
