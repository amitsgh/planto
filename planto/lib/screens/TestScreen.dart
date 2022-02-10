import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planto/screens/diseaseData.dart';
import 'package:tflite/tflite.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool _isLoading;
  PickedFile _image;
  List _output;
  final _picker = ImagePicker();

  @override
  void initState() {
    // implement initState
    super.initState();
    _isLoading = true;
    loadModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      labels: "assets/labels.txt",
      model: "assets/model_unquant.tflite",
    );
  }

  chooseImage() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _isLoading = true;
      _image = image;
    });
    runModelOnImage(image);
  }

  runModelOnImage(PickedFile image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 15,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5);
    setState(() {
      _isLoading = false;
      _output = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder<FirebaseApp>(
      // Initialize FlutterFire:
      future: _initialization,
      // ignore: missing_return
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset('label.png'))
              ],
            ),
            backgroundColor: Colors.white,
          ),
          body: _isLoading
              ? Container(
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                )
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: _image == null
                            ? Container(
                                child: Image.asset('logo.png'),
                              )
                            : Container(
                                margin: EdgeInsets.all(10),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(File(_image.path)),
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _output == null
                                ? Text("")
                                : Column(
                                    children: [
                                      Text(
                                        "${_output[0]["label"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).accentColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => DiseaseData(
                                                value: "${_output[0]["label"]}",
                                                img: File(_image.path),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text('Info'),
                                            Icon(Icons
                                                .keyboard_arrow_right_rounded)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            label: Text('Test Sample'),
            icon: Icon(Icons.local_florist),
            onPressed: () {
              chooseImage();
            },
          ),
        );
      },
    );
  }
}
