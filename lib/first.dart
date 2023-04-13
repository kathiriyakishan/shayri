import 'package:flutter/material.dart';
import 'package:shayri/second.dart';

import 'config.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a = List.filled(Myshayri.length, false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: ListView.builder(itemCount: Myshayri.length,itemBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(top: 8.0,left: 10,right: 10),
          child: GestureDetector(
            onTapDown: (details) {
              a[index]=true;
              setState(() {

              });
            },
            onTapUp: (details) {
              a[index]= false;
              setState(() {

              });
            },
            onTapCancel: () {
              a[index] = false;
              setState(() {

              });
            },
            child: ListTile(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return second(index,index);
              },));
            },
              leading: SizedBox(height: 60, width: 60,
                  child: CircleAvatar(backgroundImage: AssetImage("images/${img[index]}"),)),
              hoverColor: Colors.blue,tileColor: (a[index]) ? Colors.blue : Colors.grey,
              trailing: Icon(Icons.arrow_forward_ios,size: 30,color: Colors.black,),
              title: Text("${Myshayri[index]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black,width: 2),
                borderRadius: BorderRadius.circular(10),),

              contentPadding: EdgeInsets.all(4),
            ),
          ),
        );
      },
      ),
    );
  }
}
