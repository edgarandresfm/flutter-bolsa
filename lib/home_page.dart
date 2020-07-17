import 'package:flutter/material.dart';
import 'authentication.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'acciones.dart' as acciones;
//import 'main.dart';
import 'bonos.dart' as bonos;
import 'portfolio.dart' as portfolio;
//import 'todo.dart';
//import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut, this.email})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final String email;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class DataSearch extends SearchDelegate<String>{
  final cities = [
    "(VIS) - Banco Vision",
    "(DTS) - Datasystem",
    "(ATM) - Automaq",
    "(INV) - Inverfin"
  ];
  final recentCities =[
    
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    
    return [IconButton(icon: Icon(Icons.clear), onPressed:(){
      query="";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList=query.isEmpty ? recentCities:cities.where((p)=>p.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemBuilder: (context,index) => ListTile(
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }

}

class _HomePageState extends State<HomePage> {
  

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  int getColorHexFromStr(String colorStr) {
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
  }

  final primaryColor = const Color(0xFF35ABCF);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      theme: ThemeData.light(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: primaryColor,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: DataSearch(),
                  );
                },
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
              
              padding: EdgeInsets.zero,
              children: <Widget>[
                new Container(
                  
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text('Cuenta:'),
                    accountEmail: new Text(widget.email),
                )),
                ListTile(
                  title: Text('Operaciones'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Cuenta'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Salir'),
                  onTap: () {
                    _signOut();
                  },
                ),
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
