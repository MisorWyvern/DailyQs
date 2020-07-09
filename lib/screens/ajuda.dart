import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdm_av1/screens/home.dart';

//TITULOS
const String _tituloAppBar = 'Ajuda';

class Ajuda extends StatefulWidget {
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  //Conexão Fluter+Firebase
  final db = Firestore.instance;
  final String colecao = "faq";

  //Lista dinâmica para manipulação dos dados
  List<Pergunta> lista = List();

  //Stream para "ouvir" o Firebase
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    super.initState();

    //cancelar o listen, caso a coleção esteja vazia.
    listen?.cancel();

    //retornar dados da coleção e inserir na lista dinâmica
    listen = db.collection(colecao).snapshots().listen((res) {
      setState(() {
        lista = res.documents
            .map((doc) => Pergunta.fromMap(doc.data, doc.documentID))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: StreamBuilder<QuerySnapshot>(

          //fonte de dados
          stream: db.collection(colecao).snapshots(),

          //exibição dos dados
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                List<DocumentSnapshot> docs = snapshot.data.documents;
                List<int> mostraResposta = [];
                mostraResposta.length = docs.length;
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
                  child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              child: ExpansionTile(
                                leading: Icon(
                                  Icons.help,
                                  color: corListaIcone,
                                  size: tamanhoIcones,
                                ),
                                title: Text(lista[index].pergunta,
                                    style:
                                        Theme.of(context).textTheme.headline3),
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Text(
                                      lista[index].resposta,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }),
                );
            }
          }),
    );
  }
}

class Pergunta {
  //atributos
  String _id;
  String _pergunta;
  String _resposta;

  //construtor
  Pergunta(String idDocumento, String text, String parse);

  //getters
  String get id => _id;
  String get pergunta => _pergunta;
  String get resposta => _resposta;

  Pergunta.map(dynamic obj) {
    this._id = obj['id'];
    this._pergunta = obj['pergunta'];
    this._resposta = obj['resposta'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["pergunta"] = _pergunta;
    map["resposta"] = _resposta;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Pergunta.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    this._pergunta = map["pergunta"];
    this._resposta = map["resposta"];
  }
}

/*
ListTile(
                        title: Text(
                          lista[index].pergunta,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(lista[index].resposta,
                            style: TextStyle(fontSize: 16)),
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              //deletar documento da lista
                              db.collection(colecao).document(lista[index].id).delete();
                              // _deletar(context, docs[index], index);
                            }),
                        onTap: () {
                          //Navigator.pushNamed(context, "/cadastro",
                          //    arguments: lista[index].id);
                        },
                      );
                      */
