import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
	
	final Widget child;
	
	const AuthBackground({Key? key, required this.child}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			// color: Colors.red,
			width: double.infinity,
			height: double.infinity,
			child: Stack(
				children: [_PurpleBox(), _HeaderIcon(), child],
			),
		);
	}
}

class _HeaderIcon extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return SafeArea(
			child: Container(
            margin: const EdgeInsets.only(top: 19),
				width: double.infinity,
				child: const Icon(
					Icons.person_pin_sharp,
					color: Colors.white,
					size: 100,
				)
			),
		);
	}
}

class _PurpleBox extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;

		return Container(
			width: double.infinity,
			height: size.height * 0.4,
			decoration: _purpleBackgroud(),
			child: Stack(
			children: [
				Positioned(child: _Bubble(), top: -50, left: -50),
				Positioned(child: _Bubble(), top: 90, left: 50),
				Positioned(child: _Bubble(), top: -10, right: 10),
				Positioned(child: _Bubble(), bottom: 0, right: 0),
			],
			),
		);
	}

	BoxDecoration _purpleBackgroud() {
		return const BoxDecoration(
			gradient: LinearGradient(colors: [
			Color.fromRGBO(63, 63, 157, 1),
			Color.fromRGBO(90, 70, 179, 1),
		]));
	}
}

class _Bubble extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Container(
			width: 100,
			height: 100,
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(100),
				color: const Color.fromRGBO(255, 255, 255, 0.05)),
		);
	}
}
