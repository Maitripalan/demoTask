import 'package:flutter/material.dart';
import 'package:platoDemoTask/screen2.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'counter.dart';

class screen1 extends StatefulWidget {
  @override
  _screen1State createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  final CollectionReference employee =
      FirebaseFirestore.instance.collection('demoTable2');
  TextEditingController _name = TextEditingController();
  TextEditingController _ocupation = TextEditingController();

  Future<QuerySnapshot> getUserDetails() async {
    var firebaseUserDetails =
        await FirebaseFirestore.instance.collection('demoTable2').get();
    return firebaseUserDetails;
  }



  Future updatedata(String name, String ocp, String id) async {
   
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('demoTable2').doc(id);

    Map<String, dynamic> emp = {"name": name, "ocupation": ocp};

    documentReference.update(emp).whenComplete(() => print("updated"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: new Center(
                child: new Text(
              "Employee Details ",
              style: TextStyle(
                  color: Color(0xFFAD1457),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            )),
          ),
          new Container(
            height: 300.0,
            child: new FutureBuilder<QuerySnapshot>(
              future: getUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                      children: documents
                          .map((doc) => Card(
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      doc['name'],
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Text(doc['ocupation']),
                                  leading: new IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Color(0xFFAD1457),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return new AlertDialog(
                                                title: new Text(
                                                  "Edit Details ",
                                                  style: TextStyle(
                                                      color: Color(0xFF78909C)),
                                                ),
                                                content: new ListView(
                                                  children: <Widget>[
                                                    new Center(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 16,
                                                                right: 16),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child:
                                                            new TextFormField(
                                                          controller: _name,
                                                          cursorColor:
                                                              Color(0xFF78909C),
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: "Name",
                                                            labelStyle: TextStyle(
                                                                color: Color(
                                                                    0xFFAD1457)),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                      ),
                                                    )),
                                                    new Center(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 16,
                                                                right: 16),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child:
                                                            new TextFormField(
                                                          controller:
                                                              _ocupation,
                                                          cursorColor:
                                                              Color(0xFF78909C),
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Ocupation",
                                                            labelStyle: TextStyle(
                                                                color: Color(
                                                                    0xFFAD1457)),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  new MaterialButton(
                                                    onPressed: () async {
                                                      

                                                      String uused = doc.id;

                                                      print(uused);

                                                      updatedata(
                                                          _name.text.toString(),
                                                          _ocupation.text
                                                              .toString(),
                                                          uused);


                                                      Navigator.of(context)
                                                          .pop(context);
                                                          setState(() {
                                                            
                                                          });
                                                    },
                                                    child: new Text("Done"),
                                                  )
                                                ],
                                              );
                                            });
                                      }),
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text("Error");
                }
              },
            ),
          ),
          Center(
            child: Consumer<Counter>(
              builder: (context, count, child) {
                return Text(
                  count.getCounter.toString(),
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
          ),
          RaisedButton(
            elevation: 0.4,
            color: Color(0xFFAD1457),
            child: Text(
              "Go to Next Activity",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen2()));
            },
          )
        ],
      )),
    );
  }
}

