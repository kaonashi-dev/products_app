import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:products_app/models/product.dart';

class ProductsService extends ChangeNotifier {

   final String _baseUrl = dotenv.get('FIREBASE_BASE_URL');
   final List<Product> products = [];
   
   late Product selectdProduct;

   bool isLoading = true;
   bool isSaving = true;

   ProductsService() {
      loadProducts();
   }
   
   Future <List<Product>> loadProducts() async {

      isLoading = true;
      notifyListeners();

      final url = Uri.https(_baseUrl, 'products.json');
      final response = await http.get( url );

      final Map<String, dynamic> productsMap = json.decode(response.body);

      productsMap.forEach((key, value) {
         final tempProduct = Product.fromMap( value );
         tempProduct.id = key;
         products.add( tempProduct );
      });

      isLoading = false;
      notifyListeners();

      return products;

   }

   Future saveOrCreateProduct( Product product ) async {

      isSaving = true;
      notifyListeners();

      if ( product.id == null ) {
         /// Crear producto
         await createProduct(product);
      } else {
         /// Actualizar producto
         await updateProduct(product);
      }

      isSaving = false;
      notifyListeners();

   }

   Future<String?> updateProduct( Product product) async {

      final url = Uri.https(_baseUrl, 'products/${ product.id }.json');
      await http.put( url, body: product.toJson() );

      final index = products.indexWhere((element) => element.id == product.id );
      products[index] = product;

      return product.id;
   }

   Future<String?> createProduct( Product product) async {

      final url = Uri.https(_baseUrl, 'products.json');
      final response = await http.post( url, body: product.toJson() );
      final data = json.decode(response.body);

      product.id = data['name'];
      products.add(product);

      return product.id;
   }

} 