import 'package:flutter/material.dart';

import 'package:products_app/models/product.dart';
import 'package:products_app/services/services.dart';

class ProductFormProvider extends ChangeNotifier {

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

   late Product product;

   ProductFormProvider( this.product );

   updateAvailable( bool value ) {
      product.available = value;
      notifyListeners();
   }

   bool isValidateForm() {

      print(product.name); 

      return formKey.currentState?.validate() ?? false;
   }

}