import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:products_app/services/services.dart';

class CheckAuthScreen extends StatelessWidget {
   
   const CheckAuthScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {

      final authservice = Provider.of<AuthService>(context, listen: false);

      return Scaffold(
         body: Center(
            child: FutureBuilder(
               future: authservice.getIdtoken(),
               builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

                  if (!snapshot.hasData) return const CircularProgressIndicator();

                  if (snapshot.data == '') {
                     Future.microtask(() => {
                        Navigator.pushReplacement(context, _pageRouteBuilder(const LoginScreeen())),
                     });
                  } else {
                     Future.microtask(() => {
                        Navigator.pushReplacement(context, _pageRouteBuilder(const HomeScreeen())),
                     });
                  }

                  return Container();

               },
            ),
         ),
      );
   }

   PageRouteBuilder<dynamic> _pageRouteBuilder( Widget page ) {
      return PageRouteBuilder(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: const Duration(milliseconds: 500),
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
               opacity: animation,
               child: child,
            );
         },
      );
   }
}