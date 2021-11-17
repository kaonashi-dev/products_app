import 'package:flutter/material.dart';
import 'package:products_app/screens/loading_screen.dart';
import 'package:provider/provider.dart';

import 'package:products_app/services/services.dart';

import 'package:products_app/widgets/product_card.dart';

class HomeScreeen extends StatelessWidget {
  
   const HomeScreeen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {

      // ignore: unused_local_variable
      final productService = Provider.of<ProductsService>(context);

      if (productService.isLoading) return const LoadingScreen();

      return Scaffold(
         appBar: AppBar(
            title: const Text('Productos'),
            centerTitle: true,
         ),
         body: ListView.builder(
            itemCount: productService.products.length,
            itemBuilder: ( BuildContext context, int index ) {
               return GestureDetector(
                  child: ProductCard(product: productService.products[index],),
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
