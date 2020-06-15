import 'package:flutter/material.dart';
import 'package:pdm_av1/models/quest.dart';

//CORES
const Color corListaIcone = Color(0xFF651fff);
const Color _corTextoBase = Color(0xFF320b86);

//TITULOS
const String _tituloAppBar = 'DailyQs';

//ICONES
const double tamanhoIcones = 40;

//PADDING
const double _paddingMensagem = 15;

class Home extends StatefulWidget {
  final List<Quest> _quests = List();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    .then((questRecebida) {
                  setState(() => _atualizaQuests(questRecebida));
                });
              })
        ],
        title: Text(
          _tituloAppBar,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),

      //INICIO LISTA DE QUESTS

      body: widget._quests.isEmpty
          ? //VERIFICA SE A LISTA ESTA VAZIA
          //SE SIM, MOSTRA MENSAGEM
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, _paddingMensagem),
                    child: Text(
                      'Você ainda não possui missões criadas...',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, _paddingMensagem),
                    child: Text(
                      'Clique no icone:',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,_paddingMensagem),
                    child: Icon(Icons.add_circle),
                  ),
                  Text(
                    'Para adicionar uma nova missão.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            )
          :
          //SE NAO, CRIA LISTA
          ListView.builder(
              itemCount: widget._quests.length,
              itemBuilder: (context, i) {
                final quest = widget._quests[i];
                return ItemQuest(quest);
              },
            ),
    );
  }

  //Receber e montar a 'quest'
  void _atualizaQuests(Quest questRecebida) {
    if (questRecebida != null) {
      widget._quests.add(Quest(
          questRecebida.quantidade,
          questRecebida.nomeQuest,
          questRecebida.descQuest,
          questRecebida.iconeQuest));
    }
  }
}

class ItemQuest extends StatelessWidget {
  final Quest _quest;

  ItemQuest(this._quest);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          leading: _quest.iconeQuest,
          title: Text(
            _quest.nomeQuest,
            style: TextStyle(
              color: _corTextoBase,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            _quest.quantidade.toString() + " x " + _quest.descQuest,
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
      ]),
    );
  }
}
