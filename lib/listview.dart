import 'package:flutter/material.dart';

void main() => runApp(ListViewApp());

class ListViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return(MaterialApp(home: ListViewAppPage ()));
  }
}

class ListViewAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListViewAppPageSate();
  }
  
}

class ListViewAppPageSate extends State<ListViewAppPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
      title: Text('ListView'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Text('ListView tinh'),
            ListViewTinh(),
            Text('ListView dong'),
            ListViewDong(),
          ],
        ),
      ),
    );
  }
}

Widget ListViewDong() {
  int n = 5;
  List<int> listSo = List.generate(n, (i) => i * i);
  return ListView.builder(
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (BuildContext context,i) => Card(
        child: ListTile(
          title: Text('Phan tu ${listSo[i]}'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(duration: Duration(milliseconds: 100),content: Text('Phan tu ${listSo[i]}')));
          },
        ),
      ),
  );
}

Widget ListViewTinh(){
  return ListView(shrinkWrap: true, children: [
    Card(child: ListTile(title: Text('Do Hong Nhung'))),
    Card(child: ListTile(title: Text('Tran Nhat Tinh'))),
    Card(child: ListTile(title: Text('Nguyen Kim Ngoc'))),
    Card(child: ListTile(title: Text('Nguyen Trung Tinh'))),
    Card(child: ListTile(title: Text('Phan Ngoc Yen'))),
  ]);
}