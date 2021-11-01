import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

   final Widget child;

   const CardContainer({Key? key, required this.child}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 30),
         child: Container(
            child: child,
            padding: const EdgeInsets.all(19),
            width: double.infinity,
            decoration: _cardShape(),
         ),
      );
   }

   BoxDecoration _cardShape() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(27),
      boxShadow: const [
         BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 5)
         )
      ]
   );
}