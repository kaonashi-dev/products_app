import 'package:flutter/material.dart';

import 'package:products_app/models/product.dart';

class ProductFormProvider extends ChangeNotifier {

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

   late Product product;

   ProductFormProvider( product );

   bool isValidateForm() {

      return formKey.currentState?.validate() ?? false;
   }

}