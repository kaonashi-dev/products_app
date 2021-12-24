// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:products_app/models/product.dart';

class ProductsService extends ChangeNotifier {

   final String _baseUrl = dotenv.get('FIREBASE_BASE_URL');
   final String _cloudinaryUrl = dotenv.get('CLOUDINARY_BASE_URL');
   final List<Product> products = [];
   
   late Product selectdProduct;
   
   File? newPicture;

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

   void updateSelectedPoductImage( String path ) {

      selectdProduct.image = path;
      newPicture = File.fromUri( Uri(path: path) );

      notifyListeners();

   }

   Future<String?> uploadImage() async {

      if ( newPicture == null ) return null;

      isSaving = true;
      notifyListeners();

      final url = Uri.parse(_cloudinaryUrl);

      final uploadRequest = http.MultipartRequest(
         'POST',
         url,
      );
      final file = await http.MultipartFile.fromPath('file', newPicture!.path);

      uploadRequest.files.add(file);

      final streamResponse = await uploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);

      if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
         print('algo salio mal :(');
         print( resp.body );
         return null;
      }

      newPicture = null;

      final decodedData = json.decode( resp.body );
      return decodedData['secure_url'];

   }
} 