import 'package:flutter/material.dart';
import 'package:wikisearchapp/searchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchData(),
    );
  }
}

class SearchData extends StatefulWidget {
  const SearchData({Key? key}) : super(key: key);

  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text('WikiSearch', style: TextStyle(color: Colors.black54)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //showSearch(context: context, delegate: WikipediaSearch());
              },
              icon: Icon(
                Icons.search,
              )),
        ],
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchPage()));

        },
          child: Text('Press to search'),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,),
            label: 'History',
          ),
        ],

      ),
    );
  }
}


