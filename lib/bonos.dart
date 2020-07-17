import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('bonos').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.only(top: 10.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  //String tasaVen="$record.tasa $record.vencimiento";
  //print(tasaVen);
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
        title: Text(record.vencimiento),
        subtitle: Text(record.emisor),
        trailing: Text(record.moneda+' '+record.precio.toString()),
        leading: Text (record.tasa),
        onTap: () => print(record),
      ),
    ),
  );
}

class Record {
  final String emisor, moneda, tasa, vencimiento;
  final int precio;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['emisor'] != null),
        assert(map['tasa'] != null),
        assert(map['moneda'] != null),
        assert(map['precio'] != null),
        assert(map['vencimiento'] != null),
        emisor = map['emisor'],
        tasa = map['tasa'],
        moneda = map['moneda'],
        vencimiento = map['vencimiento'],
        precio = map['precio'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$emisor:$moneda $precio:$tasa:$vencimiento>";
}

class Bonos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildBody(context),
      ],
    );
  }
}
