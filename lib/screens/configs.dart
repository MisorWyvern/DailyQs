import 'package:flutter/material.dart';
import 'package:pdm_av1/screens/home.dart';

const Color _corSwitchAtivo = Color(0xff9a67ea);
bool isDarkMode = false;

//TITULOS
const String _tituloAppBar = 'Configurações';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //DARK MODE

              Row(
                
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Icon(Icons.brightness_2, color: corListaIcone),
                  ),
                  Expanded(
                    child: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                        print(isDarkMode);
                      });
                    },
                    activeTrackColor: _corSwitchAtivo,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              Divider(),

              //HORA DO RESET

              Row(
                
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Icon(Icons.timer, color: corListaIcone),
                  ),
                  Expanded(
                    child: Text(
                      'Horário da repetição\n00:00',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              RaisedButton(onPressed: null,child: Text('ALTERAR HORÁRIO')),
              Divider(),

              //ALTERAR SENHA
              Row(
                
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Icon(Icons.vpn_key, color: corListaIcone),
                  ),
                  Expanded(
                    child: Text(
                      'Senha',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              RaisedButton(onPressed: null,child: Text('ALTERAR SENHA')),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
