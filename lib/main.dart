import 'package:flutter/material.dart';
import 'package:lolstats/BaseAppBar.dart';
import 'package:lolstats/screens/UserScreen.dart';
import 'themes.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomThemes.getBaseTheme(),
      home: UserScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  int bottomSelectedIndex = 0;
  PageController _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  List<BottomNavigationBarItem> buildBottomNavBarItems(){
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text("Home screen")
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text("Profile")
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.gamepad),
          title: Text("Champions")
      ),
    ];
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  Widget buildPageView()
  {
    return PageView(
      controller: _controller,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Container(
          color: Colors.deepOrangeAccent,
          child: Center(
            child: Text("eluwina"),
          ),
        ),
        Container(
          color: Colors.amberAccent,
          child: Center(
            child: Text("siemandero"),
          ),
        ),
        Container(
          color: Colors.deepPurple,
          child: Center(
            child: Text("mucias gracias amigo"),
          ),
        ),
      ],
    );
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      _controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BaseAppBar.getBaseAppBar(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
      body: Center(
        child: buildPageView(),
      ),
    );
  }
}
