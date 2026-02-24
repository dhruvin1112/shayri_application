import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/shyaricontaint.dart';
import 'datamodel.dart';

void main() {
  runApp(MaterialApp(home: Shyari_Application(), debugShowCheckedModeBanner: false));
}

class Shyari_Application extends StatefulWidget {
  const Shyari_Application({super.key});

  @override
  State<Shyari_Application> createState() => _Shyari_AppState();
}

class _Shyari_AppState extends State<Shyari_Application> {
  List tileCo = List.filled(DataModel.word.length, "white");

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    getPermissions();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Love Shayri"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: DataModel.images.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTapDown: (details) {
              tileCo[index] = "pink";
              setState(() {});
            },
            onTapUp: (details) {
              tileCo[index] = "white";
              setState(() {});
            },
            onTapCancel: () {
              tileCo[index] = "white";
              setState(() {});
            },
            onTap: () {
              print("TAP ON $index");

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shayri(index)),
              );
            },
            child: Card(
              color: tileCo[index] == "white" ? Colors.white : Colors.pink,
              child: ListTile(
                leading: Image.asset(
                  DataModel.images[index],
                  width: 50,
                  height: 50,
                ),
                title: Text(
                  DataModel.word[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                trailing: tileCo[index] == "pink"
                    ? Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                )
                    : SizedBox(),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getPermissions()
  async {

    var status = await Permission.storage.status;
    print("St = $status");

    if(status.isDenied)
      {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.location,
          Permission.photos,
          Permission.storage,
        ].request();
      }
  }
}