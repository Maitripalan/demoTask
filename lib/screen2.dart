import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter.dart';

class screen2 extends StatefulWidget {
  @override
  _screen2State createState() => _screen2State();
}

class _screen2State extends State<screen2> {

  TextEditingController _name = TextEditingController();
                    TextEditingController _ocupation = TextEditingController();
              final CollectionReference dataemp =   FirebaseFirestore.instance.collection("demoTable1");
String userId = "";
int counterValue  = 0;
Text t;


 
  Future updatedata(String name, String ocp, String id) async {
   
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('demoTable1').doc(id);

    Map<String, dynamic> emp = {"name": name, "ocupation": ocp};

    documentReference.update(emp).whenComplete(() => print("updated"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
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
           Container(
              height: 300.0,
              child: new StreamBuilder(
                stream: FirebaseFirestore.instance.collection("demoTable1").snapshots(),
               
                builder: (context,snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index){
                      DocumentSnapshot demo1 = snapshot.data.docs[index];
                      return ListTile(
                        
                        title: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(demo1['name'],style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                      ),
                        ),
                        subtitle: Text(demo1['ocupation']),
                         leading: new IconButton(icon: Icon(Icons.edit , color: Color(0xFFAD1457),), onPressed: (){
                           showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Edit Details ",style: TextStyle(color:Color(0xFF78909C)),),
                         
                          content: new ListView(
                            children: <Widget>[
                              new Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    padding: EdgeInsets.only(left:16,right:16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color:Colors.grey,width:1),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child:  new TextFormField(
                                      controller: _name,
                               
                                cursorColor: Color(0xFF78909C),
                              
                                decoration: InputDecoration(
                                  
                                
                                  labelText: "Name",
                                  labelStyle: TextStyle(color: Color(0xFFAD1457)),
                                ),
                              
                                keyboardType: TextInputType.text,
                              
                                
                              ),
                              
                                  ),
                                )
                              ),
                              new Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    padding: EdgeInsets.only(left:16,right:16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color:Colors.grey,width:1),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child:  new TextFormField(
                                      controller: _ocupation,
                               
                                cursorColor: Color(0xFF78909C),
                              
                                decoration: InputDecoration(
                                  
                                
                                  labelText: "Ocupation",
                                  labelStyle: TextStyle(color: Color(0xFFAD1457)),
                                ),
                              
                                keyboardType: TextInputType.text,
                              
                                
                              ),
                              
                                  ),
                                )
                              )

                            ],
                          ),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                          String uused = demo1.id;

                                                      print("uused $uused");

                                                      updatedata(
                                                          _name.text.toString(),
                                                          _ocupation.text
                                                              .toString(),
                                                          uused);
                               
                                
                                                                  Navigator.of(context).pop(context);
                                                                  setState(() {
                                                                    
                                                                  });
                                                                },
                                                                child: new Text("Update"),
                                                              )
                                                            ],
                                                          );
                                                        });
                                                          
                                                         }),
                                
                                                      );
                                                    }
                                                    );
                                                }
                                                ),
                                            ),
                                              
          Container(
            child: Center(child: Consumer<Counter>(
              builder: (context, count, child) {
                return Text(count.getCounter.toString(),style: TextStyle(fontSize: 20),);
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFAD1457),
              tooltip: 'Increment',
              child: Icon(Icons.add,color: Colors.white,),

                elevation: 0.5,
        onPressed: () {
          Provider.of<Counter>(context).incrementCounter();
        },
      ),
    );
  }
}
