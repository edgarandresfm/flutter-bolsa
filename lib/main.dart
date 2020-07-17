import 'package:flutter/material.dart';
//import 'portfolio.dart' as portfolio;
//import 'bonos.dart' as bonos;
//import 'acciones.dart' as acciones;
//import 'operaciones.dart' as operaciones;
import 'authentication.dart';
import 'root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  /*int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("error al convertir color");
      }
    }
    return val;
  }*/
  //final primaryColor = const Color(0xFF151026);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //debugShowMaterialGrid: false,
      //showSemanticsDebugger: false,
      //supportedLocales: Locale('es'),
      /*theme: ThemeData(
        primaryColor: primaryColor,
      ),*/
      home: new RootPage(auth: new Auth()));
  }
}
            /*DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
                color: Colors.white,
                iconSize: 30.0,
              ),
            ],
            bottom: TabBar(
              //isScrollable: true,
              tabs: [
                Tab(
                  text: 'Portfolio',
                  //icon: new Icon(Icons.account_balance,)
                ),
                Tab(
                  text: 'Bonos',
                  //icon: new Icon(Icons.credit_card,)
                ),
                Tab(
                  text: 'Acciones',
                  //icon: new Icon(Icons.attach_money,)
                ),
                
              ],
            ),
            title: Text('BolsAPP'),
          ),
          drawer: new Drawer(
            child: ListView(
              children: <Widget>[
                new Container(
                  color: Color(getColorHexFromStr('35ABCF')),
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text('usuario 123'),
                    accountEmail: new Text('usuario@gmail.com'),
                  )
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new portfolio.Portfolio(),
              new bonos.Bonos(),
              new acciones.Acciones(),
            ],
          ),
        ),
      ),
    );
  }
}
*/