import 'package:flutter/material.dart';

import 'package:products_app/models/product.dart';

class ProductFormProvider extends ChangeNotifier {

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

   late Product product;

   ProductFormProvider( this.product );

   updateAvailable( bool value ) {
      product.available = value;
      notifyListeners();
   }

   bool isValidateForm() {

      // ignore: avoid_print
      print(product.name); 

      return formKey.currentState?.validate() ?? false;
   }

}