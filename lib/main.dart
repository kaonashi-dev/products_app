import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:products_app/services/services.dart';

import 'package:products_app/screens/screens.dart';

void main() async {

   await dotenv.load();

   runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  
  const StateApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return MultiProvider(
         providers: [
            ChangeNotifierProvider(create: ( _ ) => ProductsService())
         ],
         child: const MyApp(),
      );
   }
}

class MyApp extends StatelessWidget {
  
   const MyApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return MaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'PRODUCTOS APP',
         initialRoute: 'home',
         routes: {
            'login': ( _ ) => const LoginScreeen(),
            'home': ( _ ) => const HomeScreeen(),
            'product_details': ( _ ) => const ProductDetailsScreen(),
         },
         theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey[300],
            appBarTheme: const AppBarTheme(
               color: Colors.deepPurpleAccent
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
               backgroundColor: Colors.deepPurpleAccent
            )
         ),
      );
   }
}