import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:products_app/providers/product_form_provider.dart';

import 'package:products_app/services/services.dart';
import 'package:products_app/shared/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class ProductDetailsScreen extends StatelessWidget {

   const ProductDetailsScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {

      final productService = Provider.of<ProductsService>(context);

      return ChangeNotifierProvider(
         create: ( _ ) => ProductFormProvider( productService.selectdProduct ),
         child: _ProductDetailsBody(productService: productService),
      );

   }
}

class _ProductDetailsBody extends StatelessWidget {
   const _ProductDetailsBody({
      Key? key,
      required this.productService,
   }) : super(key: key);

   final ProductsService productService;

   @override
   Widget build(BuildContext context) {

      final productForm = Provider.of<ProductFormProvider>(context);

      return Scaffold(
         body: SingleChildScrollView(
            child: Column(
               children: [
                  
                  Stack(
                     children: <Widget> [
                        
                        ProductImage(url: productService.selectdProduct.image),

                        Positioned(
                           top: 30,
                           child: IconButton(
                              icon: const Icon( Icons.arrow_back_ios_new_rounded ),
                              onPressed: () => Navigator.pop(context),
                           )
                        ),

                        Positioned(
                           top: 30,
                           right: 0,
                           child: IconButton(
                              icon: const Icon( Icons.camera_alt_outlined ),
                              onPressed: () {},
                           )
                        ),
                     ],
                  ),

                  const _Form(),

                  const SizedBox(height: 100)

               ],
            ),
         ),
         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
         floatingActionButton: FloatingActionButton(
            child: const Icon( Icons.save_outlined ),
            onPressed: () {
               
               if(!productForm.isValidateForm()) return;

               productService.saveOrCreateProduct(productForm.product);

            },
         ),
      );
   }
}

class _Form extends StatelessWidget {
   const _Form({
     Key? key,
   }) : super(key: key);

   @override
   Widget build(BuildContext context) {

      final productForm = Provider.of<ProductFormProvider>(context);
      final product = productForm.product;

      return Container(
         padding: const EdgeInsets.symmetric(horizontal: 30),
         width: double.infinity,
         decoration: _buildBoxDecoration(),
         child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
               children: <Widget> [
                  
                  const SizedBox(height: 10),

                  TextFormField(
                     initialValue: product.name,
                     inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                     ],
                     onChanged: ( value ) => product.name = value,
                     validator: ( value ) {
                        if( value == null || value.isEmpty ) {
                          return 'El nombre es obligatorio';
                        }
                     },
                     decoration: InputDecorations.authInput(
                        hintText: 'Nombre del producto', 
                        labelText: 'Nombre',
                        prefixIcon: Icons.font_download_outlined 
                     ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                     initialValue: '${product.price}',
                     onChanged: ( value ) => {
                        if ( double.tryParse(value) == null ) {
                           product.price = 0
                        } else {
                           product.price = int.parse(value)
                        }
                     },
                     keyboardType: TextInputType.number,
                     decoration: InputDecorations.authInput(
                        hintText: '\$150', 
                        labelText: 'Precio',
                        prefixIcon: Icons.attach_money_rounded
                     ),
                  ),
                  const SizedBox(height: 30),
                  SwitchListTile(
                     value: product.available,
                     title: const Text('Disponible'),
                     activeColor: Colors.deepPurpleAccent,
                     onChanged: productForm.updateAvailable
                  ),

                  const SizedBox(height: 30)

               ],
            ),
         ),
      );
   }

   BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only( bottomLeft: Radius.circular(19), bottomRight: Radius.circular(19) ),
      boxShadow: [
         BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0,5),
            blurRadius: 5
         )
      ]
   );
}