import 'package:flutter/material.dart';

import 'package:products_app/widgets/product_card.dart';

class HomeScreeen extends StatelessWidget {
  
   const HomeScreeen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: AppBar(
            title: const Text('Productos'),
            centerTitle: true,
         ),
         body: ListView.builder(
            itemCount: 15,
            itemBuilder: ( BuildContext context, int index ) {
               return GestureDetector(
                  child: const ProductCard(),
                  onTap: () => Navigator.pushNamed(context, 'product_details'),
               );
            }
         ),
         floatingActionButton: FloatingActionButton(
            child: const Icon( Icons.add ),
            onPressed: () {},
         ),
      );
   }
}
