import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  
  const ProductImage({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: const EdgeInsets.only(left: 0, right: 0),
         child: Container(
            width: double.infinity,
            height: 450,
            decoration: _buildBoxDecaration(),
            child: const FadeInImage(
               placeholder: AssetImage('assets/loading.gif'),
               image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
               fit: BoxFit.cover,
            ),
         )
      );
   }

   BoxDecoration _buildBoxDecaration() => BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
         BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0,0)
         ),
      ],
      color: Colors.deepPurpleAccent
   );
}