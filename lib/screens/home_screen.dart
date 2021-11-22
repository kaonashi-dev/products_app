import 'package:flutter/material.dart';
import 'package:products_app/screens/loading_screen.dart';
import 'package:provider/provider.dart';

import 'package:products_app/models/product.dart';
import 'package:products_app/services/services.dart';

import 'package:products_app/widgets/product_card.dart';

class HomeScreeen extends StatelessWidget {
  
   const HomeScreeen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {

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
                  child: ProductCard(product: productService.products[index]),
                  onTap: () {
                     productService.selectdProduct = productService.products[index].copy();
                     Navigator.pushNamed(context, 'product');
                  },
               );
            }
         ),
         floatingActionButton: FloatingActionButton(
            child: const Icon( Icons.add ),
            onPressed: () {
               productService.selectdProduct = Product(available: true, name: '', price: 0);
               Navigator.pushNamed(context, 'product');
            },
         ),
      );
   }
}
