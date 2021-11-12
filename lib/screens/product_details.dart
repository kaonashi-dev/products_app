import 'package:flutter/material.dart';

import 'package:products_app/shared/input_decorations.dart';

import 'package:products_app/widgets/widgets.dart';

class ProductDetailsScreen extends StatelessWidget {

   const ProductDetailsScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         body: SingleChildScrollView(
            child: Column(
               children: [
                  
                  Stack(
                     children: <Widget> [
                        
                        const ProductImage(),

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
      return Container(
         padding: const EdgeInsets.symmetric(horizontal: 30),
         width: double.infinity,
         decoration: _buildBoxDecoration(),
         child: Form(
            child: Column(
               children: <Widget> [
                  
                  const SizedBox(height: 10),

                  TextField(
                     decoration: InputDecorations.authInput(
                        hintText: 'Nombre del producto', 
                        labelText: 'Nombre',
                        prefixIcon: Icons.font_download_outlined 
                     ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                     keyboardType: TextInputType.number,
                     decoration: InputDecorations.authInput(
                        hintText: '\$150', 
                        labelText: 'Precio',
                        prefixIcon: Icons.attach_money_rounded
                     ),
                  ),
                  const SizedBox(height: 30),
                  SwitchListTile(
                     value: true,
                     title: const Text('Disponible'),
                     activeColor: Colors.deepPurpleAccent,
                     onChanged: (value) {

                     }
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