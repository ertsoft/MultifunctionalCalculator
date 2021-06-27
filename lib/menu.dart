import 'package:flutter/material.dart';
import 'package:multy_calculator/multiple_calculator.dart';
import 'package:multy_calculator/simple_calculator.dart';
import './convertor.dart';
import './calculator_derivate.dart';
import './calculator_integrale.dart';

class Menu extends StatelessWidget {
  var index_page = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/ert_soft.jpg'))),
          ),
          Divider(
            height: 25,
            thickness: 2,
            color: Colors.deepPurpleAccent,
          ),
          ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text(
              'Calculator Simplu',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                           SimpleCalculator()
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text(
              'Calculator Științific',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                   MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MultipleCalculator()
                  ));
            },
          ),
          Divider(
            height: 25,
            thickness: 1,
            indent: 40,
            endIndent: 40,
            color: Colors.teal,
          ),
          ListTile(
            leading: Icon(Icons.swap_calls_sharp),
            title: Text(
              'Convertor',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Convertor()
                  ));
            },
          ),
          Divider(
            height: 25,
            thickness: 1,
            indent: 40,
            endIndent: 40,
            color: Colors.teal,
          ),
          ListTile(
            leading: Icon(Icons.all_inclusive),
            title: Text(
              'Derivate',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DerivateCalculator()
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.architecture),
            title: Text(
              'Integrale',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          IntegralsCalculator()
                  ));
            },
          ),
        ],
      ),
    );
  }

  int take_index() {
    return index_page;
  }
}
