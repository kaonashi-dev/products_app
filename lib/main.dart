import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  
   const MyApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return MaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'PRODUCTOS APP',
         initialRoute: 'login',
         routes: {
            'login': ( _ ) => const LoginScreeen(),
            'home': ( _ ) => const HomeScreeen()
         },
         theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey[300]
         ),
      );
   }
}