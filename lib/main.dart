import 'package:flutter/material.dart';
import 'package:platoDemoTask/screen1.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


import 'counter.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    
    ChangeNotifierProvider<Counter>(builder:(context)=>Counter() ,
    child: MyApp(),
    )
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screen1(),
        floatingActionButton: FloatingActionButton(
             backgroundColor: Color(0xFFAD1457),
              tooltip: 'Increment',
              child: Icon(Icons.add,color: Colors.white,),

                elevation: 0.5,

          onPressed: ()
          {

            Provider.of<Counter>(context).incrementCounter();
          },
        ),
      ),
    );
  }
}