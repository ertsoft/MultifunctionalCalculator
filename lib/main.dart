import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './menu.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Calculator",
      home: MyAppHome(),
      theme: ThemeData(
        brightness: Brightness.light
      ),
    );
  }
}

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {

  @override
  void initState(){
    super.initState();

    setPortrait();
  }

  @override
  void dispose(){
    setAllOrientations();

    super.dispose();
  }

  Future setPortrait() async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Future setAllOrientations() async{
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      drawer: Menu(),

      // Body
    body:  Container(
      child: Text("This is Home Page"),
    ),
    );

  }


}
