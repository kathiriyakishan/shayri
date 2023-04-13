import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayri/edit.dart';

import 'config.dart';

class third extends StatefulWidget {
  int full,main;  //  full shayri index, main list
  third(this.full,this.main);

  @override
  State<third> createState() => _thirdState();
}

class _thirdState extends State<third> {
  PageController controller = PageController();
  @override
  void initState() {
    // TODO: implement initState
    controller=PageController(initialPage: widget.main);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    double screen_height = MediaQuery.of(context).size.height;
    double status_bar = MediaQuery.of(context).padding.top;
    double appbar = kToolbarHeight;
    double total_height = screen_height-status_bar-appbar;

    return Scaffold(
      appBar: AppBar(title: Text("${Myshayri[widget.main]}"),centerTitle: true),
      body: Column(children: [
        Container(width: double.infinity, height: 50,color: Colors.blue,

          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 30,),
            ElevatedButton(onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context, builder: (context) {
                return Container(
                  height: total_height,
                  child: GridView.builder(itemCount: mycolor.length-1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                     ),itemBuilder: (context, index) {
                        return InkWell(onTap: () {
                          col_ind=index;
                          tmp_color=true;
                          Navigator.pop(context);
                          setState(() {
                          });
                        },
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [mycolor[index],mycolor[index+1]],
                                )
                            ), ),
                        );
                      },),
                );
              },);
            }, child: Icon(Icons.expand,color: Colors.black,)),

              Text("${widget.full+1}/${list.length}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),

            ElevatedButton(onPressed: () {
              setState(() {
               int b = Random().nextInt(mycolor.length-1);
                col_ind=b;
              });
            }, child: Icon(Icons.refresh,color: Colors.black,)),
              SizedBox(width: 30,)
            ],
          ),
        ),



        Expanded(child: PageView.builder(itemCount:list.length,
          controller: controller,
          onPageChanged: (value) {
          widget.full=value;
          setState(() {
          });
        },
          itemBuilder: (context, index) {
          return Container(width: double.infinity,margin: EdgeInsets.all(20),alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(168, 237, 234,100),
              gradient: tmp_color==true ?LinearGradient(colors: [mycolor[col_ind],mycolor[col_ind+1]]) : null,
              borderRadius: BorderRadius.only(topRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
              border: Border.all(color: Colors.black,width: 2),),
            child: Text("${emoji[1]}\n${list[widget.full]}\n${emoji[1]}",style: TextStyle(fontSize: 30),textAlign: TextAlign.center),
          );
        },)
        ),
        Container(height: 60,width: double.infinity,color: Colors.blue,
          child: Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {
                    FlutterClipboard.copy("${list[widget.full]}").then(( value ) =>
                    Fluttertoast.showToast(
                        msg: "Copied",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    ));
                    setState(() {

                    });
                  }, child: Icon(Icons.copy,color: Colors.black,)),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      if(widget.full != 0)
                      {
                        widget.full--;
                        controller.jumpToPage(widget.full);
                      }
                    });
                  }, child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
                  ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return edit(widget.full);
                    },)
                    );

                  }, child: Icon(Icons.edit)),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      if(widget.full != list.length-1)
                      {
                        widget.full++;
                      }else
                      {
                        widget.full = 0;
                      }
                    });
                  }, child: Icon(Icons.arrow_forward_ios,color: Colors.black,)),
                  ElevatedButton(onPressed: () {
                    Share.share("${list[widget.full]}");
                    setState(() {

                    });
                  }, child: Icon(Icons.share,color: Colors.black,)),
            ]),
          ),
        ),
        SizedBox(height: 20,)
      ]),

    );
  }
}
