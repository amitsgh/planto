import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:planto/Model/diseasemodel.dart';

// ignore: must_be_immutable
class DiseaseData extends StatefulWidget {
  final String value;
  var img;

  DiseaseData({this.value, this.img});

  @override
  _DiseaseDataState createState() => _DiseaseDataState(value, img);
}

class _DiseaseDataState extends State<DiseaseData> {
  String value;
  var img;
  bool isloading = false;
  List<DiseaseModel> diseaseModel = [];

  _DiseaseDataState(this.value, this.img);

  Future<void> sendData() async {
    setState(() {
      isloading = true;
    });
    http.post(
      (Uri.parse(
          "https://planto-965f9-default-rtdb.firebaseio.com/sample.json")),
      body: json.encode(
        {
          //'SampleImage': img,
          'name': value,
        },
      ),
    );
    setState(
      () {
        isloading = false;
      },
    );
    /* setState(() {
      diseaseModel.add(DiseaseModel(
        value: value,
        //imageUrl: img,
      ));
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(value),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(value).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something Went Wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 150),
                    //alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30, top: 30),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50, bottom: 10),
                                    child: Text('About',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins')),
                                  ),
                                  Text(
                                    snapshot.data.docs[0]['intro'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(
                                      'Management',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data.docs[0]['management'],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(img, fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 640),
                    child: InkWell(
                      onTap: () {
                        sendData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Saved'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        /*  print(sendData()); */
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        decoration: BoxDecoration(
                            color: HexColor('70EE9C'),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Save for Later',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
