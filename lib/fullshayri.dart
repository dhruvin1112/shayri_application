import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'datamodel.dart';
import 'editshayri.dart';

class Shayri_Love extends StatefulWidget {
  int catIndex;
  int shayarindex;
  int gradiantSet = 0;


  Shayri_Love(this.catIndex, this.shayarindex, {super.key});

  @override
  State<Shayri_Love> createState() => _Shayri_LoveState();
}

class _Shayri_LoveState extends State<Shayri_Love> {
  int correntIndex=0;
  List iconPressed = [false, false, false, false, false];
  bool isClicked = false;
  PageController pageController = PageController();

  @override
  void initState() {

    super.initState();
    correntIndex=widget.shayarindex;
    pageController = PageController(initialPage: widget.shayarindex);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Love Shayri"),
        backgroundColor: Colors.green,
        centerTitle: false,
      ),

      body: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,


            children: [
              IconButton(
                icon: Icon(Icons.zoom_out_map, color: Colors.green, size: 40),
                onPressed: () {
                  showModalBottomSheet(
                    scrollControlDisabledMaxHeightRatio: 0.9,
                    isDismissible: true,
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: DataModel.colors.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                widget.gradiantSet = index;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                DataModel.shayrii[widget.catIndex][widget
                                    .shayarindex],
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: DataModel.colors[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              Text(
                "${correntIndex + 1}/${DataModel.shayrii[widget.catIndex].length}",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),


              IconButton(
                icon: Icon(Icons.repeat_sharp, color: Colors.red, size: 40),
                onPressed: () {
                  setState(() {
                    if (widget.gradiantSet < DataModel.colors.length - 1) {
                      widget.gradiantSet++;
                    } else {
                      widget.gradiantSet = 0;
                    }
                  });
                },
              ),
            ],
          ),

          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: DataModel.shayrii[widget.catIndex].length,
              onPageChanged: (index) {
                setState(() {
                  correntIndex=index;
                });
              },
              itemBuilder: (context, index) {
              return  Container(
                alignment: Alignment.center,
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: DataModel.colors[widget.gradiantSet],
                ),
                child: Text(
                  DataModel.shayrii[widget.catIndex][index],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              );
            
            },),
          ),

          Expanded(flex:2,child: SizedBox(height: 5,)),

          Container(
            height: 70,
            width: double.infinity,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,


              children: [
                IconButton(
                  icon: Icon(
                    Icons.file_copy_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: DataModel
                            .shayrii[widget.catIndex][widget.shayarindex],
                      ),
                    ).then((value) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Shayari Copied",style: TextStyle(fontSize: 35),),duration: Duration(seconds: 5),showCloseIcon: true,),);
                    });
                  },
                ),


                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (correntIndex > 0) {
                      correntIndex--;
                      pageController.jumpToPage(correntIndex);
                      setState(() {});
                    }
                  },
                ),


                IconButton(
                  icon: Icon(
                    Icons.edit_off,
                    size: 40,
                    color: Colors.yellowAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Edit_Shayri(widget.catIndex, widget.shayarindex),
                      ),
                    );
                  },
                ),


                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (correntIndex <
                        DataModel.shayrii[widget.catIndex].length - 1) {
                      correntIndex++;
                      pageController.jumpToPage(correntIndex);
                    }
                    setState(() {});
                  },
                ),


                IconButton(
                  icon: Icon(Icons.share, size: 30, color: Colors.white),
                  onPressed: () {

                    // SharePlus.instance.share(ShareParams(text: ));

                    SharePlus.instance.share(
                      ShareParams(
                        text: DataModel
                            .shayrii[widget.catIndex][widget.shayarindex],
                        title: "Read this Interesting shayari",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
