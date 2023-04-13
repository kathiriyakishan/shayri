import 'package:flutter/material.dart';
import 'package:shayri/third.dart';

import 'config.dart';

class second extends StatefulWidget {
  int main, full;
  second(this.main, this.full);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.main == 0) {
      list = [];
      list.addAll(alchol_shayari);
    } else if (widget.main == 1) {
      list = [];
      list.addAll(friend_shayari);
    } else if (widget.main == 2) {
      list = [];
      list.addAll(attitude_shayari);
    } else if (widget.main == 3) {
      list = [];
      list.addAll(birthday_shayari);
    } else if (widget.main == 4) {
      list = [];
      list.addAll(breakup_shayari);
    } else if (widget.main == 5) {
      list = [];
      list.addAll(fun_shayari);
    } else if (widget.main == 6) {
      list = [];
      list.addAll(god_shayari);
    } else if (widget.main == 7) {
      list = [];
      list.addAll(goodluck_shayari);
    } else if (widget.main == 8) {
      list = [];
      list.addAll(holi_shayari);
    } else if (widget.main == 9) {
      list = [];
      list.addAll(love_shayari);
    } else if (widget.main == 10) {
      list = [];
      list.addAll(motiv_shayari);
    } else if (widget.main == 11) {
      list = [];
      list.addAll(politic_shayari);
    } else if (widget.main == 12) {
      list = [];
      list.addAll(rain_shayari);
    } else if (widget.main == 13) {
      list = [];
      list.addAll(romantic_shayari);
    } else if (widget.main == 14) {
      list = [];
      list.addAll(sad_shayari);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${Myshayri[widget.main]}"),centerTitle: true),
      body: ListView.builder(itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 10, right: 10),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return third(index,widget.full);
                  },
                ));
              },
              leading: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/${img[widget.main]}"),
                  )),
              hoverColor: Colors.blue,tileColor: (a[index]) ? Colors.grey : Colors.grey,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 30,
                color: Colors.black,
              ),
              title:Text("${emoji[index]}\n${list[index]}\n${emoji[1]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 2),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.all(4),
            ),
          );
        },
      ),
    );
  }
}
