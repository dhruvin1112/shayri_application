import 'package:flutter/material.dart';
import 'datamodel.dart';
import 'fullshayri.dart';

class Shayri extends StatefulWidget {
  int catIndex;

  Shayri(this.catIndex, {super.key});

  @override
  State<Shayri> createState() => _ShayriState();
}

class _ShayriState extends State<Shayri> {
  List tileCo = List.filled(DataModel.word.length, "pink");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Love Shayri"),
        backgroundColor: Colors.green,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return InkWell(
            onTapDown: (details) {
              tileCo[index] = "red";
              setState(() {});
            },
            onTapUp: (details) {
              tileCo[index] = "blue";
              setState(() {});
            },
            onTapCancel: () {
              tileCo[index] = "blue";
              setState(() {});
            },
            child: Card(
              color: tileCo[index] == "red" ? Colors.red : Colors.blue,
              child: ListTile(
                onTap: () {
                  print("Tap on $index");
              
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Shayri_Love(widget.catIndex, index),
                    ),
                  );
                },
              
                leading: Image.asset(
                  "${DataModel.images[widget.catIndex]}",
                  height: 50,
                  width: 50,
                ),
                title: Text("🍀🌷🌸🌻🌹🌹🍀🌷🌸🌻🌹🌹"),
              
                subtitle: Text(
                  DataModel.shayrii[widget.catIndex][index],
                  maxLines: 1,
                ),
              
                titleTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}