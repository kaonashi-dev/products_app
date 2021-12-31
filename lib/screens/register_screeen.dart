import 'package:flutter/material.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart';

import 'package:products_app/providers/login_form_provider.dart';

import 'package:products_app/shared/input_decorations.dart';

import 'package:products_app/widgets/widgets.dart';

class RegisterScreeen extends StatelessWidget {
	
	const RegisterScreeen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: AuthBackground(
				child: SingleChildScrollView(
					child:  Column(
						children: <Widget> [
							
							const SizedBox(height: 170),

							CardContainer(
								child: Column(
									children: [

										const SizedBox(height: 10),
										Text('REGISTRO', style: Theme.of(context).textTheme.headline5),
										const SizedBox(height: 30),

                              ChangeNotifierProvider(
                                 create: ( _ ) =>  LoginFormProvider(),
                                 child: _LoginForm(),
                              ),

									],
								),
							),

							const SizedBox(height: 70),
                     TextButton(
                        child: const Text(
                           '¿ya tienes una cuenta?',
                           style: TextStyle(color: Colors.black, fontSize: 19),
                        ),
                        style: ButtonStyle(
                           overlayColor: MaterialStateProperty.all( Colors.deepPurple.withOpacity(0.1) ),
                        ),
                        onPressed: () {
                           Navigator.pushNamed(context, 'login');
                        }
                     ),
							const SizedBox(height: 50),

						],
					),
				)
			)
		);
	}
}

class _LoginForm extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

      final loginForm = Provider.of<LoginFormProvider>(context);

		return Form(

         key: loginForm.formKey,
         autovalidateMode: AutovalidateMode.onUserInteraction,

			child: Column(
				children: [

					TextFormField(
						autocorrect: false,
						keyboardType: TextInputType.emailAddress,
						decoration: InputDecorations.authInput(
							labelText: 'Correo electrónico', 
							hintText: 'user@correo.com', 
							prefixIcon: Icons.alternate_email_rounded
						),
                  onChanged: ( value ) => loginForm.email = value,
                  validator: ( value ) {
                     String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                     RegExp regExp = RegExp(pattern);

                     return regExp.hasMatch(value ?? '') ? null : 'No es un correo válido';
                  },
					),

					const SizedBox(height: 30),

					TextFormField(
						autocorrect: false,
						keyboardType: TextInputType.text,
						obscureText: true,
						decoration: InputDecorations.authInput(
							labelText: 'Contraseña', 
							hintText: '*****', 
							prefixIcon: Icons.lock
						),
                  onChanged: ( value ) => loginForm.password = value,
                  validator: ( value ) {
                     
                     if ( value != null && value.length >= 7) return null;

                     return 'La contraseña debe ser de 7 caracteres';

                  },
					),

					const SizedBox(height: 30),

					MaterialButton(
						shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
						disabledColor: Colors.grey,
						elevation: 0,
						color: Colors.deepPurple,
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
							child: Text(
                        loginForm.isLoading ? 'Cargando...' : 'Ingresar',
								style: const TextStyle( color: Colors.white ),
								),
						),
						onPressed: loginForm.isLoading ? null : () async {

                     FocusScope.of(context).unfocus();
                     final authProvider = Provider.of<AuthService>(context, listen: false);
                     
                     if( !loginForm.isValidateForm() ) return;

                     loginForm.isLoading = true;

                     final String? errorMsg = await authProvider.createUser(loginForm.email, loginForm.password);

                     if ( errorMsg == null ) {
                        loginForm.isLoading = false;
                        Navigator.pushReplacementNamed(context, 'home');
                     } else {
                        print(errorMsg);
                        loginForm.isLoading = false;
                     }


                  }
					)

				],
			),
		);
	}
}
