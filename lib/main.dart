import 'package:flutter/material.dart';
import 'package:pdm_av1/screens/login.dart';
import 'package:pdm_av1/screens/home.dart';
import 'package:pdm_av1/screens/quests/adicionarQuest.dart';
import 'package:pdm_av1/screens/sobre.dart';
import 'package:pdm_av1/screens/perfil.dart';
import 'package:pdm_av1/screens/configs.dart';
import 'package:pdm_av1/screens/ajuda.dart';

void main() => runApp(DailyQs());

class DailyQs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      
      primaryColor: Colors.deepPurple[500],
      accentColor: Colors.deepPurpleAccent[700],
      
      // Define the default font family.
      fontFamily: 'Times',

      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: 'PressStart2P', color: Color(0xFFEEEEEE)),
        headline2: TextStyle(fontSize: 18.0, fontFamily: 'PressStart2P', color: Color(0xFF320b86)),
        bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Color(0xFF320b86)),
        bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Color(0xFFdddddd)),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurpleAccent[700],
        textTheme: ButtonTextTheme.primary,
      ),
    ),
    
    home: Login(), // Rota de nome '/'
    routes: <String, WidgetBuilder> {
      '/home': (BuildContext context) => Home(),
      '/home/addQuest': (BuildContext context) => AdicionarQuest(),
      '/home/sobre': (BuildContext context) => Sobre(),
      '/home/ajuda': (BuildContext context) => Ajuda(),
      '/home/configs': (BuildContext context) => Configuracoes(),
      '/home/perfil': (BuildContext context) => Perfil(),
      
    },
    );
  }
}

