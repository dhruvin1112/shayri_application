import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'datamodel.dart';

class Edit_Shayri extends StatefulWidget {
  int catIndex;
  int shayariindex;

  Edit_Shayri(this.catIndex, this.shayariindex, {super.key});

  @override
  State<Edit_Shayri> createState() => _Edit_ShayriState();
}

class _Edit_ShayriState extends State<Edit_Shayri> {
  int gradiantSet = 0;
  int colorIndex = 0;
  bool isGradient = true;
  Color textColor = Colors.black;
  var textSize = 20.0;
  String selectFont = "";
  String selectEmoji="";

  WidgetsToImageController imageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.green,
        title: Text("फोटो पे शायरी लिखे"),
        titleTextStyle: TextStyle(fontSize: 20),
      ),
      body: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: WidgetsToImage(
                controller: imageController,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: isGradient ? DataModel.colors[gradiantSet] : null,
                    color: isGradient ? null : DataModel.color[colorIndex],
                  ),
                  child: Text(
                    "$selectEmoji\n${DataModel.shayrii[widget.catIndex][widget.shayariindex]}\n$selectEmoji",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontFamily: selectFont,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              children: [
                SizedBox(height: 5),

                Container(
                  height: 50,
                  width: 150,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.repeat, color: Colors.red, size: 40),
                        onPressed: () {
                          setState(() {
                            isGradient = true;
                            gradiantSet =
                                (gradiantSet + 1) % DataModel.colors.length;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.zoom_out_map,
                          color: Colors.green,
                          size: 40,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            scrollControlDisabledMaxHeightRatio: 0.9,
                            isDismissible: true,
                            isScrollControlled: true,
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),

                                itemCount: DataModel.colors.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        isGradient = true;
                                        gradiantSet = index;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        gradient: DataModel.colors[index],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        DataModel.shayrii[widget
                                            .catIndex][widget.shayariindex],
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showModalBottomSheet(
                            scrollControlDisabledMaxHeightRatio: 0.15,
                            isDismissible: true,
                            backgroundColor: Colors.blueGrey,
                            context: context,
                            builder: (context) {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 7,
                                    ),
                                itemCount: DataModel.color.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        isGradient = false;
                                        colorIndex = index;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 5,
                                      width: 5,
                                      margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: DataModel.color[index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        fixedSize: Size(100, 50),
                        backgroundColor: Colors.greenAccent,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Background"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showModalBottomSheet(
                            scrollControlDisabledMaxHeightRatio: 0.15,
                            isDismissible: true,
                            backgroundColor: Colors.indigoAccent,

                            context: context,
                            builder: (context) {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 7,
                                    ),
                                itemCount: DataModel.color.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        textColor = DataModel.color[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 5,
                                      width: 5,
                                      margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: DataModel.color[index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        fixedSize: Size(100, 50),
                        backgroundColor: Colors.greenAccent,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Text Color"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var bytes = await imageController.capture();
                        print("bytes = $bytes");

                        var exPath = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOAD);
                        exPath += "/myImgs";

                        print("Path = $exPath");

                        Directory dir = Directory(exPath);
                        if(!await dir.exists())
                          {
                            await dir.create();
                          }

                        int ran = Random().nextInt(999999);
                        var path = exPath+"/img$ran.png";


                        File myfile = File(path);
                        myfile.writeAsBytesSync(bytes!);

                        XFile xf = XFile(myfile.path);

                        SharePlus.instance.share(ShareParams(files: [xf],));


                      },
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        fixedSize: Size(100, 50),
                        backgroundColor: Colors.greenAccent,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Share"),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          scrollControlDisabledMaxHeightRatio: 0.3,
                          isDismissible: true,
                          backgroundColor: Colors.grey,
                          context: context,
                          builder: (context) {
                            return SizedBox(height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: DataModel.font.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectFont = DataModel.font[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      width: 100,
                                      color: Colors.pink,
                                      alignment: .center,
                                      child: Text("Font",
                                        style: TextStyle(fontFamily: DataModel.font[index],
                                        fontSize: 18,
                                        color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        fixedSize: Size(100, 50),
                        backgroundColor: Colors.greenAccent,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Font"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showModalBottomSheet(
                            scrollControlDisabledMaxHeightRatio: 0.2,
                            isDismissible: true,
                            backgroundColor: Colors.black38,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 200,
                                child: ListView.builder(
                                    itemCount: DataModel.emoji.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectEmoji = DataModel.emoji[index];
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(DataModel.emoji[index],
                                          textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      );
                                    },),
                              );
                          },);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        fixedSize: Size(100, 50),
                        backgroundColor: Colors.greenAccent,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Emoji"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          scrollControlDisabledMaxHeightRatio: 0.3,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder:
                                  (
                                    BuildContext context,
                                    void Function(void Function()) setState1,
                                  ) {
                                    return Slider(
                                      value: textSize,
                                      activeColor: Colors.red,
                                      inactiveColor: Colors.blue,
                                      label: "Demo",
                                      onChanged: (value) {
                                        textSize = value;
                                        setState(() {});
                                        setState1(() {});
                                      },
                                      max: 100,
                                    );
                                  },
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        fixedSize: Size(100, 50),
                        backgroundColor: Colors.greenAccent,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Text Size"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}