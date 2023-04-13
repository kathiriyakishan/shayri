import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shayri/first.dart';

void main()
{
  runApp(MaterialApp(home: home(),));
}
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("SHAYRI APP")),
    body:InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return first();
        },));
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey,image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/back.jpg"))),

      ),
    ),
    );
  }
}
