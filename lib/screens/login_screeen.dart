import 'package:flutter/material.dart';

import 'package:products_app/shared/input_decorations.dart';

import 'package:products_app/widgets/widgets.dart';

class LoginScreeen extends StatelessWidget {
	
	const LoginScreeen({Key? key}) : super(key: key);

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
										Text('LOGIN', style: Theme.of(context).textTheme.headline5),
										const SizedBox(height: 30),

										const _LoginForm()

									],
								),
							),

							const SizedBox(height: 70)

						],
					),
				)
			)
		);
	}
}

class _LoginForm extends StatelessWidget {
	const _LoginForm({
		Key? key,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Form(
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
					),

					const SizedBox(height: 30),

					MaterialButton(
						shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
						disabledColor: Colors.grey,
						elevation: 0,
						color: Colors.deepPurple,
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
							child: const Text(
								'INGRESAR',
								style: TextStyle( color: Colors.white ),
								),
						),
						onPressed: () {}
					)

				],
			),
		);
	}
}
