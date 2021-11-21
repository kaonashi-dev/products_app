import 'package:flutter/material.dart';

import 'package:products_app/models/product.dart';

class ProductCard extends StatelessWidget {

   final Product product;
   
   const ProductCard({Key? key, required this.product}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 23),
         child: Container(
            margin: const EdgeInsets.only( top: 30, bottom: 50 ),
            width: double.infinity,
            height: 350,
            decoration: _cardBorders(),
            child: Stack(
               children: [

                  _BackgroundImage(url: product.image),

                  Positioned(
                     left: 0,
                     bottom: 0,
                     child: _DetailsProduct(id: product.id!, name: product.name)
                  ),

                  Positioned(
                     right: 0,
                     top: 0,
                     child: _PriceTag(price: product.price)
                  ),

                  if( !product.available )
                     Positioned(
                        left: 0,
                        top: 0,
                        child: _NotAvailable()
                     ),

               ],
            ),
         ),
      );
   }

   BoxDecoration _cardBorders() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const <BoxShadow> [
         BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 3),
            blurRadius: 7
         )
      ]
   );
}

class _NotAvailable extends StatelessWidget {

   @override
   Widget build(BuildContext context) {

      return Container(
         child: const FittedBox(
            fit: BoxFit.contain,
            child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 9),
               child: Text(
                  'No disponible',
                  style: TextStyle( color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
               ),
            ),
         ),
         width: 100,
         height: 50,
         alignment: Alignment.center,
         decoration: _buildBoxDecoration(),
      );
   }

   BoxDecoration _buildBoxDecoration() {
      return const BoxDecoration(
         color: Colors.brown,
         borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(19))
      );
   }
}

class _PriceTag extends StatelessWidget {

   final int price;

   const _PriceTag({Key? key, required this.price}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Container(
         child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 9),
               child: Text(
                  '\$$price', 
                  style: const TextStyle( color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
               ),
            ),
         ),
         width: 111,
         height: 50,
         alignment: Alignment.center,
         decoration: _buildBoxDecoration(),
      );
   }

   BoxDecoration _buildBoxDecoration() {
      return const BoxDecoration(
         color: Colors.deepPurpleAccent,
         borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(19))
      );
   }
}

class _DetailsProduct extends StatelessWidget {

   final String id;
   final String name;

   const _DetailsProduct({
      Key? key,  
      required this.id, 
      required this.name
   }) : super(key: key);

   @override
   Widget build(BuildContext context) {

      final screenSize = MediaQuery.of(context).size;

      return Container(
         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
         width: screenSize.width * 0.7,
         height: 75,
         decoration: _buildBoxDecoration(),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
               Text(
                  name, 
                  style: const TextStyle( color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
               ),
               Text(
                  id, 
                  style: const TextStyle( color: Colors.white, fontSize: 15 ),
               ),
            ],
         ),
      );
   }

   BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topRight: Radius.circular(19))
   );
}

class _BackgroundImage extends StatelessWidget {

   final String? url;

   const _BackgroundImage({Key? key, this.url}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return ClipRRect(
         borderRadius: BorderRadius.circular(30),
         child: SizedBox(
            width: double.infinity,
            height: 350,
            child: url == null
               ? const Image(image: AssetImage('assets/no-image.png'))
               : FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(url!),
                  fit: BoxFit.cover,
               ),
         ),
      );
   }
}