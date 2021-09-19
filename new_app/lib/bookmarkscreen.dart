import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  final images = ImagePicker();
  File? image;
  bool isloading = true;

  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    //build(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/3.png"),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.darken)
                    )
                    ),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            // color: Colors.blue,
                            color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(5),
                      width: 300.0,
                      child: Column(children: [
                        isloading
                            ? CircularProgressIndicator()
                            : image != null
                                ? Image.file(
                                    image!,
                                    width: 160,
                                    fit: BoxFit.fill,
                                  )
                                // : CircularProgressIndicator()
                                : Center(child: FlutterLogo(size: 160)),
                      ]),
                    ),
                  ),
                  Container(
                    child: ButtonTheme(
                        minWidth: 100.0,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            gallerypickImage();
                          },
                          color: Colors.pink,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Select Image"),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Location :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        TextFormField(
                          maxLines: 1,
                          maxLength: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                              // counterText: '',
                              hintText: "Enter your Loacation",
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                        Text(
                          "Caption :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        TextFormField(
                          maxLines: 1,
                          maxLength: 15,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          decoration: InputDecoration(
                              // counterText: '',
                              border: InputBorder.none,
                              hintText: "Enter your Caption",
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ButtonTheme(
                        minWidth: 200.0,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            // successTost();
                            // saveFile();
                            // readFile();
                            localPath();
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Save marker"),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
  Future gallerypickImage() async {
    try {} on PlatformException catch (e) {
      print("Fail to pick Image :$e");
    }
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    print("---------------------------------------------------");

    if (image == null) return;
    final imageTempory = File(image.path);

    setState(() {
      this.isloading = false;
      this.image = imageTempory;
    });

    print(image.path);
  }

  void successTost() {
    Fluttertoast.showToast(
        msg: "Marker Change  Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Future<String> getFilePath() async {
  //   return image!.path;
  // }

  // void saveFile() async {
  //   File file = File(await getFilePath()); // 1
  //   file.writeAsString(image!.path); // 2
  //   print("Calling Save ");
  // }

  // readFile() async {
  //   File file = File(await getFilePath()); // 1
  //   String fileContent = await file.readAsString(); // 2

  //   print('File Content: $fileContent');
  //   return fileContent;
  // }
}

Future<String> localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  print(directory.path);
  print(tempPath);
  return directory.path;
}
