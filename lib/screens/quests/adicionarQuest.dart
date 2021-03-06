import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:pdm_av1/models/quest.dart';
//import 'package:pdm_av1/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TITULO
const String _tituloAppBar = 'Adicionar DailyQ';

//TEXTO CAMPOS
const String _labelCampoNome = 'Nome:';
const String _dicaCampoNome = 'Escreva um nome p/ missão';
const String _labelCampoDesc = 'Resumo:';
const String _dicaCampoDesc = 'Ex. Ver um filme';
const String _labelCampoQtd = 'Quantidade:';
const String _dicaCampoQtd = 'Ex. 1 para uma repetição';

//TEXTO BOTAO
const String _textoBotaoCriar = 'Criar';

class AdicionarQuest extends StatefulWidget {
  @override
  _AdicionarQuestState createState() => _AdicionarQuestState();
}

class _AdicionarQuestState extends State<AdicionarQuest> {
  final TextEditingController controladorCampoNome = TextEditingController();
  final TextEditingController controladorCampoDesc = TextEditingController();
  final TextEditingController controladorCampoQtd = TextEditingController();

  var db = Firestore.instance;

  //retornar dados do documento a partir do idDocument
  void getDocumento(String idDocumento) async {
    //Recuperar o documento no Firestore
    DocumentSnapshot doc =
        await db.collection("quests").document(idDocumento).get();

    setState(() {
      controladorCampoNome.text = doc.data["nomeQuest"];
      controladorCampoDesc.text = doc.data["descQuest"];
      controladorCampoQtd.text = doc.data["quantidade"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // RECUPERAR o ID do Documento
    //
    final String idDocumento = ModalRoute.of(context).settings.arguments;

    if (idDocumento != null) {
      if (controladorCampoNome.text == "" && controladorCampoDesc.text == "") {
        getDocumento(idDocumento);
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CampoFormulario(
              controlador: controladorCampoNome,
              label: _labelCampoNome,
              dica: _dicaCampoNome,
              icone: Icon(Icons.assignment_late),
            ),
            CampoFormulario(
              controlador: controladorCampoDesc,
              label: _labelCampoDesc,
              dica: _dicaCampoDesc,
              icone: Icon(Icons.assignment),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: controladorCampoQtd,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  labelText: _labelCampoQtd,
                  hintText: _dicaCampoQtd,
                  icon: Icon(Icons.looks_one),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            RaisedButton(
                onPressed: () {
                  if (controladorCampoDesc.text == "" ||
                      controladorCampoNome.text == "" ||
                      controladorCampoQtd.text == "") {
                    _mostrarAlerta();
                  } else {
                    if (idDocumento == null) {
                      //INSERIR NOVO SE NAO POSSUIR ID
                      db.collection('quests').document().setData({
                        'nomeQuest': controladorCampoNome.text,
                        'descQuest': controladorCampoDesc.text,
                        'quantidade': int.tryParse(controladorCampoQtd.text),
                        'situacao': 0
                      });
                      Navigator.pop(context);
                    } else {
                      //ATUALIZAR SE POSSUIR ID
                      db.collection('quests').document(idDocumento).updateData({
                        'nomeQuest': controladorCampoNome.text,
                        'descQuest': controladorCampoDesc.text,
                        'quantidade': int.tryParse(controladorCampoQtd.text),
                        'situacao': 0
                      });
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(_textoBotaoCriar)),
          ],
        ),
      ),
    );
  }

  Future<void> _mostrarAlerta() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Obriga o usuario a clicar no botao!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Valores Inválidos!',
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
                    'Por favor, informe valores válidos para todos os campos.',
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
                'Aceito',
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
}

class CampoFormulario extends StatelessWidget {
  final TextEditingController controlador;
  final String label;
  final String dica;
  final Icon icone;

  const CampoFormulario({this.controlador, this.label, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
            labelText: label,
            hintText: dica,
            icon: icone != null ? icone : null),
      ),
    );
  }
}
