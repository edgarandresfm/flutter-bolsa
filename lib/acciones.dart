import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('acciones').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
      

      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    //reverse: true,
    //shrinkWrap: true,
    padding: const EdgeInsets.only(top: 10.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);

  return Padding(
    key: ValueKey(record.emisor),
    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                    <--- top side
            color: Colors.black26,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        title: Text(record.ticker),
        subtitle: Text(record.emisor),
        trailing: Text(record.moneda+' '+record.precio.toString()),
        onTap: () => print(record),
      ),
    ),
    
  );
}

class Record {
  final String emisor, ticker,moneda;
  final int precio;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['emisor'] != null),
        assert(map['ticker'] != null),
        assert(map['precio'] != null),
        assert(map['moneda'] != null),
        emisor = map['emisor'],
        ticker = map['ticker'],
        precio = map['precio'],
        moneda = map['moneda'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$emisor:$ticker:$moneda $precio>";
}

class Acciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Align(
      child: _buildBody(context),
    ));
    /*return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _buildBody(context),
      ],
    );*/
  }
}
