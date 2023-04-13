import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'config.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:permission_handler/permission_handler.dart';

class edit extends StatefulWidget {
  int full;
  edit(this.full, {Key? key}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  Color c=Colors.yellow;
  bool temp=true;

  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
get()
async {
  var status = await Permission.storage.status;
  if (status.isDenied)
  {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
}

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double status_bar = MediaQuery.of(context).padding.top;
    double appbar = kToolbarHeight;
    double total_height = screen_height - status_bar - appbar;

    return Scaffold(
      appBar: AppBar(title: Text("edit")),
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 50,
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: total_height,
                          child: GridView.builder(
                            itemCount: mycolor.length - 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  col_ind = index;
                                  tmp_color = true;
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      mycolor[index],
                                      mycolor[index + 1]
                                    ],
                                  )),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.expand,
                    color: Colors.black,
                  )),
              SizedBox(width: 30),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int d = Random().nextInt(mycolor.length - 1);
                      col_ind = d;
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        Expanded(
          child: WidgetsToImage(
           controller: controller,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: (temp)?c:Colors.pink,
                gradient: tmp_color == true ? LinearGradient(colors: [mycolor[col_ind], mycolor[col_ind + 1]]) : null,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text("${emo}\n${list[widget.full]}\n${emo}",
                  style: TextStyle(
                      color: text_color == true ? mycolor[text_index] : null,
                      fontFamily: Cur_font,
                      fontSize: cur_size),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
        Container(
            height: 100,
            width: double.infinity,
            color: Colors.blue,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: Colors.blue.shade50,
                                    child: GridView.builder(
                                      itemCount: mycolor.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 7),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              setState(() {
                                                c=mycolor[index];
                                                temp=true;
                                                back_color = true;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              color: mycolor[index],
                                            ));
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Background",
                              style: TextStyle(color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: Colors.blue.shade50,
                                    child: GridView.builder(
                                      itemCount: mycolor.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 7),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              text_index = index;
                                              text_color = true;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            color: mycolor[index],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Text Color",
                              style: TextStyle(color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () async {
                              bytes = await controller.capture();
                              var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/shayari";
                              Directory dir = Directory(path);
                              if(! await dir.exists())
                                {
                                  dir.create();
                                }
                              int r = Random().nextInt(10000);
                              String imgs="${r}.jpg";
                         File f=File("${dir.path}/${imgs}");
                         await  f.writeAsBytes(bytes!);
                              Share.shareXFiles([XFile("${f.path}")], text: 'Great picture');



                              setState(() {});
                            },
                            child: Text(
                              "   Share   ",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 100,
                                    color: Colors.purpleAccent,
                                    margin: EdgeInsets.all(10),
                                    child: PageView.builder(
                                      itemCount: fonts.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              Cur_font = fonts[index];
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              "shayari",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: fonts[index]),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "       Font       ",
                              style: TextStyle(color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: emoji.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text("${emoji[index]}",
                                              textAlign: TextAlign.center),
                                          onTap: () {
                                            setState(() {
                                              emo = emoji[index];
                                              Navigator.pop(context);
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "    Emoji    ",
                              style: TextStyle(color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: StatefulBuilder(
                                      builder: (context, setState1) {
                                        return Slider(
                                          value: cur_size,
                                          onChanged: (value) {
                                            setState(() {
                                              setState1(() {
                                                cur_size = value;
                                              });
                                            });
                                          },
                                          min: 1,
                                          max: 50,
                                        );
                                      },
                                    ),
                                    height: 150,
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Text Size",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
