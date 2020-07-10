import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:pdm_av1/models/quest.dart';

//CORES
const Color corListaIcone = Color(0xFF651fff);
const Color _corTextoBase = Color(0xFF320b86);

//TITULOS
const String _tituloAppBar = 'DailyQs';

//ICONES
const double tamanhoIcones = 40;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Conexão Fluter+Firebase
  final db = Firestore.instance;
  final String colecao = "quests";

  //Lista dinâmica para manipulação dos dados
  List<Quest> lista = List();

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
            .map((doc) => Quest.fromMap(doc.data, doc.documentID))
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
      //DRAWER

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Gabriel Rosim'),
              accountEmail: Text('gabriel@exemplo.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: corListaIcone,
                child: Text('G'),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF320b86),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: corListaIcone),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/home/perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment, color: corListaIcone),
              title: Text('Sobre'),
              onTap: () {
                Navigator.pushNamed(context, '/home/sobre');
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: corListaIcone),
              title: Text('Ajuda'),
              onTap: () {
                Navigator.pushNamed(context, '/home/ajuda');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: corListaIcone),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pushNamed(context, '/home/configs');
              },
            ),
          ],
        ),
      ),

      // APP BAR

      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                Navigator.pushNamed(context, '/home/addQuest')
                    .then((questRecebida) {});
              })
        ],
        title: Text(
          _tituloAppBar,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),

      //INICIO LISTA DE QUESTS

      body: StreamBuilder<QuerySnapshot>(

          //fonte de dados
          stream: db.collection(colecao).snapshots(),

          //exibição dos dados
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return null;
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                List<DocumentSnapshot> docs = snapshot.data.documents;
                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: lista[index].situacao == 0 ? null : Color(0xFF94ffad),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.assignment, size: tamanhoIcones, color: corListaIcone,),
                              title: Text(
                                lista[index].nomeQuest,
                                style: TextStyle(
                                  color: _corTextoBase,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                lista[index].quantidade.toString() +
                                    " x " +
                                    lista[index].descQuest,
                                style: TextStyle(
                                  color: _corTextoBase,
                                ),
                              ),
                            ),
                            ButtonBar(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.check_circle,
                                    size: tamanhoIcones,
                                    color: Color(0xFF00AA00),
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: tamanhoIcones,
                                    color: Color(0xFFFF0000),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
            }
          }),
    );
  }
}

class Quest {
  //atributos
  String _id;
  String _nomeQuest;
  String _descQuest;
  int _quantidade;
  int _situacao;

  //construtor
  Quest(String idDocumento, String text, int parse);

  //getters
  String get id => _id;
  String get nomeQuest => _nomeQuest;
  String get descQuest => _descQuest;
  int get quantidade => _quantidade;
  int get situacao => _situacao;

  Quest.map(dynamic obj) {
    this._id = obj['id'];
    this._nomeQuest = obj['nomeQuest'];
    this._descQuest = obj['descQuest'];
    this._quantidade = obj['quantidade'];
    this._situacao = obj['situacao'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["nomeQuest"] = _nomeQuest;
    map["descQuest"] = _descQuest;
    map["quantidade"] = _quantidade;
    map["situacao"] = _situacao;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Quest.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    this._nomeQuest = map["nomeQuest"];
    this._descQuest = map["descQuest"];
    this._quantidade = map["quantidade"];
    this._situacao = map["situacao"];
  }
}
