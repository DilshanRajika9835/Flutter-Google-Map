import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_app/bookmarkscreen.dart';
import 'package:new_app/managescreen.dart';
import 'package:new_app/mapscreen.dart';

StreamController<int> streamController = StreamController<int>();

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    print("------------Hello There ----------------------");
    print(streamController.stream.listen((index) {
      print(index.toInt());
      setState(() {
        _selectedIndex = index.toInt();
        print(_selectedIndex);
      });
    }));
  }

  List<Widget> _widgetOptions = <Widget>[
    MapScreen(),
    BookMarkScreen(),
    ManageScreen()
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: Container(
          width: 250,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       colors: [
          //         const Color(0xFF3366FF),
          //         const Color(0xFF00CCFF),
          //       ],
          //       begin: const FractionalOffset(0.0, 0.0),
          //       end: const FractionalOffset(1.0, 0.0),
          //       stops: [0.0, 1.0],
          //       tileMode: TileMode.clamp),
          // ),
          child: Drawer(
            elevation: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 190,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: new Color(0xFF0062ac),
                    ),
                    accountName: Text("Marcelo Augusto Elias"),
                    accountEmail: Text("Matrícula: 5046850"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? new Color(0xFF0062ac)
                              : Colors.white,
                      backgroundImage: AssetImage('assets/pin10.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin9.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin8.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin7.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin9.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin3.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin10.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin1.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        title: Text("Keelse Super Center"),
                        onTap: () {},
                        leading: new Image.asset(
                          "assets/pin7.png",
                          width: 50.0,
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 0,
        //title: Text('Flutter Map'),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [
        //           const Color(0xFF3366FF),
        //           const Color(0xFF00CCFF),
        //         ],
        //         begin: const FractionalOffset(0.0, 0.0),
        //         end: const FractionalOffset(1.0, 0.0),
        //         stops: [0.0, 1.0],
        //         tileMode: TileMode.clamp),
        //   ),
        // ),

        actions: [],
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            label: "Map",
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.bookmark),
            label: "Bookmark",
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            label: "Edit",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
        backgroundColor: Colors.green, //here set your transparent level

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
