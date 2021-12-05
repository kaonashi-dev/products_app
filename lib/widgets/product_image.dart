import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

   final String? url;
  
   const ProductImage({Key? key, this.url}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: const EdgeInsets.only(left: 0, right: 0),
         child: Container(
            width: double.infinity,
            height: 450,
            decoration: _buildBoxDecaration(),
            child: Opacity(
               opacity: 0.9,
               child: getImage(url),
            )
         )
      );
   }

   BoxDecoration _buildBoxDecaration() => BoxDecoration(
      boxShadow: [
         BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0,0)
         ),
      ],
      color: Colors.white
   );

   Widget getImage( String? picture ) {

      if ( picture == null ) {
         return const Image(image: AssetImage('assets/no-image.png'));
      }
         
      if( picture.startsWith('http') ) {
         return FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
         );
      }

      return Image.file(
         File(picture),
         fit: BoxFit.cover,
      );
 
   }
}